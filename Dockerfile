# Use Tomcat 10 with JDK 17 as base image
FROM tomcat:10-jdk17

# Set working directory
WORKDIR /usr/local/tomcat

# Remove default Tomcat webapps
RUN rm -rf webapps/*

# Create ROOT webapp directory structure
RUN mkdir -p webapps/ROOT/WEB-INF/classes \
             webapps/ROOT/WEB-INF/lib

# Download MySQL JDBC driver
ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar \
    webapps/ROOT/WEB-INF/lib/mysql-connector-j-8.0.33.jar

# Download Jakarta Servlet API for compilation
ADD https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/5.0.0/jakarta.servlet-api-5.0.0.jar \
    /tmp/jakarta.servlet-api-5.0.0.jar

# Copy custom server.xml to disable shutdown port
COPY server.xml conf/server.xml

# Copy webapp files (JSP, HTML, CSS, JS)
COPY src/main/webapp/ webapps/ROOT/

# Copy Java source files for compilation
COPY src/main/java /tmp/java-src

# Compile Java classes with proper classpath
RUN cd /tmp/java-src && \
    find . -name "*.java" -type f > /tmp/sources.txt && \
    javac -encoding UTF-8 \
          -source 17 \
          -target 17 \
          -cp "/usr/local/tomcat/lib/*:/usr/local/tomcat/webapps/ROOT/WEB-INF/lib/*:/tmp/jakarta.servlet-api-5.0.0.jar" \
          -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
          @/tmp/sources.txt && \
    echo "=== Compilation successful ===" && \
    echo "=== Compiled classes ===" && \
    find /usr/local/tomcat/webapps/ROOT/WEB-INF/classes -type f && \
    rm -rf /tmp/java-src /tmp/jakarta.servlet-api-5.0.0.jar /tmp/sources.txt

# Set default environment variable for DB driver
ENV DB_DRIVER=com.mysql.cj.jdbc.Driver

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]