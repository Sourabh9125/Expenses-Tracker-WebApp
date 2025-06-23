#--------
# stage 1
FROM maven:3.9.6-eclipse-temurin-17   AS builder

WORKDIR /app

COPY pom.xml .

COPY src ./src 

RUN mvn clean package -DskipTests=true

#-----------
#stage 2

FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/expensesapp.jar

EXPOSE 8080

CMD ["java","-jar","/app/target/expensesapp.jar"]


