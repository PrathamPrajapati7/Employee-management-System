FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN cp src/main/resources/db-railway.properties src/main/resources/db.properties
RUN mvn clean package -DskipTests

FROM tomcat:9.0-jdk11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/employee-mgmt.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
