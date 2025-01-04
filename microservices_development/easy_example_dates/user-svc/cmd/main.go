package main

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"
	"github.com/gorilla/mux"
	"github.com/IBM/sarama"
	_ "github.com/lib/pq"
	"time"
)

type User struct {
	ID        int       `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	CreatedAt time.Time `json:"created_at"`
}

var db *sql.DB // global variable to access the database
var kafkaProducer sarama.SyncProducer // global variable to access the kafka producer

func initDB() {
	var err error
				// the values in the ../../k8s/database.yaml
	connStr := "postgres://user:password@postgres:5432/userdb?sslmode=disable"
	db, err = sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal("Failed to connect to database:", err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatal("Failed to ping database:", err)
	}

	log.Println("Connected to the database successfully")
}

// start the kafka producer
func initKafkaProducer(brokers []string) sarama.SyncProducer {
	config := sarama.NewConfig()
	config.Producer.Return.Successes = true
	config.Producer.RequiredAcks = sarama.WaitForAll
	config.Producer.Retry.Max = 5

	producer, err := sarama.NewSyncProducer(brokers, config)
	if err != nil {
		log.Fatalf("Failed to start Kafka producer: %v", err)
	}

	return producer
}

// send message to kafka
func sendMessage(producer sarama.SyncProducer, topic string, message string) {
	msg := &sarama.ProducerMessage{
		Topic: topic,
		Value: sarama.StringEncoder(message),
	}

	partition, offset, err := producer.SendMessage(msg)
	if err != nil {
		log.Fatalf("Failed to send message: %v", err)
	} else {
		log.Printf("Message sent to partition %d at offset %d\n", partition, offset)
	}
}

// function for create user
func createUserHandler(w http.ResponseWriter, r *http.Request) {
	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		log.Printf("Failed to decode the request body: %v", err)
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}
	query := "INSERT INTO users (name, email, password, created_at) VALUES ($1, $2, $3, $4) RETURNING id"
	err := db.QueryRow(query, user.Name, user.Email, user.Password, time.Now()).Scan(&user.ID)

	if err != nil {
		log.Printf("Failed to execute the query: %v", err)
		http.Error(w, "Failed to create user", http.StatusInternalServerError)
		return
	}
	// send the message to kafka
	message := `{"event": "user_created", "user_id": ` + string(rune(user.ID)) + `, "name": "` + user.Name + `"}`
	sendMessage(kafkaProducer, "user-notifications", message)

	log.Printf("User created successfully with id: %d", user.ID)
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(user)
}

// returns all the users
func getUsersHandler(w http.ResponseWriter, r *http.Request) {
	rows, err := db.Query("SELECT id, name, email, created_at FROM users")
	if err != nil {
		http.Error(w, "Failed to fetch users", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var users []User
	for rows.Next() {
		var user User
		if err := rows.Scan(&user.ID, &user.Name, &user.Email, &user.CreatedAt); err != nil {
			http.Error(w, "Failed to parse users", http.StatusInternalServerError)
			return
		}
		users = append(users, user)
	}

	json.NewEncoder(w).Encode(users)
}

//////////////////////////////////////// appointments //////////////////////////////////////////
type Appointment struct {
	ID        int       `json:"id"`
	UserID    int       `json:"user_id"`
	Appointment	time.Time `json:"appointment"`
	Description string    `json:"description"`
	CreatedAt time.Time `json:"created_at"`
}

// create appointment
func createAppointmentHandler(w http.ResponseWriter, r *http.Request) {
	var appointment Appointment
	if err := json.NewDecoder(r.Body).Decode(&appointment); err != nil {
		log.Printf("Failed to decode the request body: %v", err)
		http.Error(w, "Invalid input", http.StatusBadRequest)
		return
	}
	createdAt := time.Now()
	appointment.CreatedAt = createdAt
	log.Println("Received a new appointment:") // check the table in the congigmap postgres-init-scripts or in the ../../k8s/database.yaml
	query := `INSERT INTO appointments (user_id, appointment_date, description, created_at) VALUES ($1, $2, $3, $4) RETURNING id`
	err := db.QueryRow(query, appointment.UserID, appointment.Appointment, appointment.Description, appointment.CreatedAt).Scan(&appointment.ID)
	if err != nil {
		log.Printf("Failed to insert the new appointment: %v", err)
		http.Error(w, "Failed to insert the new appointment", http.StatusInternalServerError)
		return
	}

	log.Printf("Appointment created successfully with ID: %d", appointment.ID)
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(appointment)
}

// returns all the appointments by user
func getAppointmentsByUserHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	userID := vars["user_id"]

	query := `SELECT id, user_id, appointment_date, description, created_at FROM appointments WHERE user_id = $1`
	rows, err := db.Query(query, userID)
	if err != nil {
		log.Printf("Failed to query appointments: %v", err)
		http.Error(w, "Failed to query appointments", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	appointments := []Appointment{}
	for rows.Next() {
		var appointment Appointment
		if err := rows.Scan(&appointment.ID, &appointment.UserID, &appointment.Appointment, &appointment.Description, &appointment.CreatedAt); err != nil {
			log.Printf("Failed to scan appointment: %v", err)
			http.Error(w, "Failed to scan appointment", http.StatusInternalServerError)
			return
		}
		appointments = append(appointments, appointment)
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(appointments)
}


func main() {
	initDB()
	kafkaProducer = initKafkaProducer([]string{"my-cluster-kafka-bootstrap:9092"})

	// serveFrontend()
	r := mux.NewRouter()
	// routes used by UI and js
	r.HandleFunc("/users", createUserHandler).Methods("POST")
	r.HandleFunc("/users", getUsersHandler).Methods("GET")
	r.HandleFunc("/appointments", createAppointmentHandler).Methods(http.MethodPost)
	r.HandleFunc("/appointments/{user_id}", getAppointmentsByUserHandler).Methods(http.MethodGet)
	// serve the frontend
	r.PathPrefix("/").Handler(http.FileServer(http.Dir("./static")))

	// pure logging
	log.Println("Starting server on : 8080")
	if err := http.ListenAndServe(":8080", r); err != nil {
		log.Fatal("Server failed:", err)
	}
}
