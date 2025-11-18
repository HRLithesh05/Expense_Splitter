FROM tomcat:9-jdk17

ENV APP=Expense_Splitter_Final
WORKDIR /usr/local/tomcat

# Remove default ROOT and create app structure
RUN rm -rf webapps/ROOT && mkdir -p webapps/$APP/WEB-INF/{classes,lib}

# Copy web resources (JSP, CSS, images)
COPY src/main/webapp/ webapps/$APP/

# Download MySQL JDBC driver
RUN curl -fsSL -o webapps/$APP/WEB-INF/lib/mysql-connector-j-8.0.33.jar \
  https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar

# Copy and compile Java sources
COPY src/main/java/ /tmp/java
RUN find /tmp/java -name "*.java" > /tmp/sources.txt && \
    javac -encoding UTF-8 \
      -cp "/usr/local/tomcat/lib/*:webapps/$APP/WEB-INF/lib/*" \
      -d webapps/$APP/WEB-INF/classes \
      @/tmp/sources.txt && \
    rm -rf /tmp/java /tmp/sources.txt

EXPOSE 8080
ENV DB_DRIVER=com.mysql.cj.jdbc.Driver