#!/usr/bin/env bash
docker run -it --rm --name my-maven-project -v "$HOME/.m2":/root/.m2  -v "$(pwd)/docker/settings.xml":/root/.m2/settings.xml -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.5.4-jdk-8 mvn clean package -DskipTests
cd docker;
docker-compose up
