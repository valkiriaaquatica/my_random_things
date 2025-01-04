# Using Tilt to show how a microservices is build in Kind. With Go, Postgres, Kafka. 
# THIS IS AN EASY EXAMPLE, BUT A GOOD BASE

## Overview
The project will consist of three core microservices:
1. **UI and Reservation Service**:  has the frontend and the small go backend to hold users and reservations.
2. **Notifications Service**: shows how to connect the belo microservcies -> kafka -> this microservice and sends notifications (for the example just debug)
3. **Kafka**: as message queu with pub/sub
3. **Postgres**: to store data

## Prerequisites
- **Tools**: Go, Docker, Helm, Kind, Tilt, kubectl.
- **Environment**: Basic knowledge of Kubernetes, Docker, and microservics.

### How to run it
All is run on default namespace
```bash
git clone https://github.com/valkiriaaquatica/my_random_things.git
cd my_random_things/microservices_development/easy_example_dates
tilt up
```
Now check http://localhost:10350/ and Tilt will show up.
Start interacting with microservices in http://localhost:8080/  and see logs on Tilt IU-