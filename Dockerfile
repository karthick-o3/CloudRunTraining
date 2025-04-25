#FROM eclipse-temurin:17
#WORKDIR /app
#COPY .. /app
#ENV HOST 0.0.0.0
#RUN chmod +x gradlew
#RUN ./gradlew build
#EXPOSE 8080
#CMD ["java", "-jar", "/app/build/libs/cloudrun-0.0.1-SNAPSHOT.jar"]


FROM eclipse-temurin:17 AS build
WORKDIR /app
COPY . /app
RUN chmod +x gradlew
RUN ./gradlew build --no-daemon

FROM eclipse-temurin:17
WORKDIR /app
COPY --from=build /app/build/libs/cloudrun-0.0.1-SNAPSHOT.jar app.jar
#ENV HOST=0.0.0.0
#EXPOSE 8080
CMD ["java", "-jar", "app.jar"]