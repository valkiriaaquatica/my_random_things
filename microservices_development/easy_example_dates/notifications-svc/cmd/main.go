package main

import (
	"log"
	"github.com/IBM/sarama"
)
// strt the kafka consumer
func startKafkaConsumer(brokers []string, topic string) {
	config := sarama.NewConfig()
	config.Consumer.Return.Errors = true

	consumer, err := sarama.NewConsumer(brokers, config)
	if err != nil {
		log.Fatalf("Failed to start Kafka consumer: %v", err)
	}
	defer consumer.Close()

	partitionConsumer, err := consumer.ConsumePartition(topic, 0, sarama.OffsetNewest)
	if err != nil {
		log.Fatalf("Failed to start consumer for partition 0 : %v", err)
	}
	defer partitionConsumer.Close()

	log.Printf("Listening for messages on topic: %s", topic)

	// this is the main loop to listen on kafka
	for {
		select {
		case msg := <-partitionConsumer.Messages():
			log.Printf("Received message: %s", string(msg.Value))
			processMessage(msg.Value) 
		case err := <-partitionConsumer.Errors():
			log.Printf("Consumer error: %v", err)
		}
	}
}

// just prints on the svc log
func processMessage(message []byte) {
	log.Printf("Processing message: %s", string(message))
}

func main() {
	brokers := []string{"my-cluster-kafka-bootstrap:9092"} //svc of kafka in the cluster
	topic := "user-notifications" // topic created in the ../../k8s/kafka-resources.yaml
	go startKafkaConsumer(brokers, topic) //go routine to start the kafka consumer

	select {} // do nothing, just wait
}
