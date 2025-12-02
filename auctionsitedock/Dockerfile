# Runtime image with Java 18 (matches your pom.xml java.version)
# FROM eclipse-temurin:18-jdk

FROM tomcat:10.1-jdk21

# Remove default webapps so yours becomes the root app
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy your WAR and deploy it as the ROOT webapp
COPY target/auctionsite.war /usr/local/tomcat/webapps/ROOT.war

# Pass environment variables to Tomcat process
ENV SPRING_DATASOURCE_URL=jdbc:mysql://db:3306/auction_site?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
ENV SPRING_DATASOURCE_USERNAME=root
ENV SPRING_DATASOURCE_PASSWORD=atthelastsecond
ENV SPRING_JPA_HIBERNATE_DDL_AUTO=validate

EXPOSE 8080

# Run the Spring Boot WAR (embedded Tomcat)
# ENTRYPOINT ["java", "-jar", "app.war"]
