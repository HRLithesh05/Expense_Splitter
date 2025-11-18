FROM tomcat:10-jdk17

# Remove all default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Create ROOT directory structure
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
             /usr/local/tomcat/webapps/ROOT/WEB-INF/lib

# Download MySQL JDBC driver directly to lib
ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar \
    /usr/local/tomcat/webapps/ROOT/WEB-INF/lib/

# Download Jakarta Servlet API for compilation
ADD https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/5.0.0/jakarta.servlet-api-5.0.0.jar \
    /tmp/servlet-api.jar

# Copy all webapp content
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# Copy Java source files temporarily
COPY src/main/java /tmp/src

# Compile all Java files
RUN cd /tmp/src && \
    find . -name "*.java" > sources.txt && \
    javac -encoding UTF-8 \
          -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*:/tmp/servlet-api.jar" \
          -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
          @sources.txt && \
    rm -rf /tmp/src /tmp/servlet-api.jar

# Verify what was created
RUN echo "=== Checking ROOT directory ===" && \
    ls -laR /usr/local/tomcat/webapps/ROOT/ | head -50

# Set environment variables
ENV DB_DRIVER=com.mysql.cj.jdbc.Driver

# Expose port
EXPOSE 8080

# Start Tomcat (default CMD from base image)