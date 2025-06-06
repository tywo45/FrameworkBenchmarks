FROM maven:3.9.7-amazoncorretto-21 AS build
WORKDIR /t-io
COPY pom.xml pom.xml
COPY src src
COPY script script
RUN mvn install -q

#TODO use separate JDK/JRE for the RUN (as the other builds)
WORKDIR /t-io/target/tio-http-server-benchmark

EXPOSE 8080

CMD ["java", "-server", "-Xms1G", "-Xmx4G", "-XX:+UseNUMA", "-XX:+UseParallelGC", "-Dpacket.handler.mode=queue1", "-cp", "/t-io/target/tio-http-server-benchmark/config:/t-io/target/tio-http-server-benchmark/lib/*", "org.tio.http.server.benchmark.TioBenchmarkStarter"]
