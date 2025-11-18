FROM tomcat:10-jdk17

ENV APP=Expense_Splitter_Final
WORKDIR /usr/local/tomcat

# Remove default ROOT and create app structure
RUN rm -rf webapps/ROOT && mkdir -p webapps/$APP/WEB-INF/{classes,lib}

# Copy web resources first
COPY src/main/webapp/ webapps/$APP/

# Download MySQL connector AND Jakarta servlet-api (NOT javax)
RUN curl -fsSL -o webapps/$APP/WEB-INF/lib/mysql-connector-j-8.0.33.jar \
  https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/8.0.33/mysql-connector-j-8.0.33.jar && \
  curl -fsSL -o /tmp/servlet-api.jar \
  https://repo1.maven.org/maven2/jakarta/servlet/jakarta.servlet-api/5.0.0/jakarta.servlet-api-5.0.0.jar

# Copy Java sources
COPY src/main/java/ /tmp/java

# Compile with Jakarta servlet-api on classpath
RUN find /tmp/java -name "*.java" > /tmp/sources.txt && \
    javac -encoding UTF-8 \
      -cp "/usr/local/tomcat/lib/*:webapps/$APP/WEB-INF/lib/*:/tmp/servlet-api.jar" \
      -d webapps/$APP/WEB-INF/classes \
      @/tmp/sources.txt && \
    rm -rf /tmp/java /tmp/sources.txt /tmp/servlet-api.jar

EXPOSE 8080
ENV DB_DRIVER=com.mysql.cj.jdbc.Driver