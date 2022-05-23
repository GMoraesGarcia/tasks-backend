FROM openjdk

WORKDIR /app

COPY target/tasks-backend.war /app/back.war

ENTRYPOINT ["java", "-jar", "back.war"]