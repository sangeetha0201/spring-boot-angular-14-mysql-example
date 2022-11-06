FROM openjdk:11

RUN mkdir /apps

COPY ./target/*.jar /apps/springboot.jar

EXPOSE 8080

CMD ["java", "-jar", "/apps/springboot.jar"]
