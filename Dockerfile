FROM tomcat:10-jdk17

WORKDIR /usr/local/tomcat

# Remove default ROOT
RUN rm -rf webapps/ROOT

# Create ROOT app (deployed at /)
RUN mkdir -p webapps/ROOT/WEB-INF/{classes,lib}

# Copy web resources to ROOT
COPY src/main/webapp/ webapps/ROOT/

# Download MySQL connector AND Jakarta servlet-api
RUN curl -fsSL -o webapps/ROOT/WEB-INF/lib/mysql-connector-j-8.0.33.jar \
  https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar && \
  curl -fsSL -o /tmp/servlet-api.jar \
  https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/5.0.0/jakarta.servlet-api-5.0.0.jar

# Copy Java sources
COPY src/main/java/ /tmp/java

# Compile with Jakarta servlet-api on classpath
RUN find /tmp/java -name "*.java" > /tmp/sources.txt && \
    javac -encoding UTF-8 \
      -cp "/usr/local/tomcat/lib/*:webapps/ROOT/WEB-INF/lib/*:/tmp/servlet-api.jar" \
      -d webapps/ROOT/WEB-INF/classes \
      @/tmp/sources.txt && \
    rm -rf /tmp/java /tmp/sources.txt /tmp/servlet-api.jar

# Show what was created (debug)
RUN echo "=== ROOT contents ===" && ls -la webapps/ROOT/ && \
    echo "=== JSP files ===" && find webapps/ROOT -name "*.jsp" && \
    echo "=== Compiled classes ===" && find webapps/ROOT/WEB-INF/classes -name "*.class"

EXPOSE 8080
ENV DB_DRIVER=com.mysql.cj.jdbc.Driver