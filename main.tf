terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_container" "sonarqube" {
  name  = "sonarqube"
  image = "sonarqube:latest"
  ports {
    internal = 9000
    external = 9000
  }
  env = ["SONAR_JDBC_URL=jdbc:postgresql://url:port/dename?currentSchema=schemaname","SONAR_JDBC_USERNAME=dbuser","SONAR_JDBC_PASSWORD=dbpass"]
  volumes {
    volume_name    = "sonarqube_data"
    container_path = "/opt/sonarqube/data"
  }
  volumes {
    volume_name    = "sonarqube_extensions"
    container_path = "/opt/sonarqube/extensions"
  }
  volumes {
    volume_name    = "sonarqube_logs"
    container_path = "/opt/sonarqube/logs"
  }
}

resource "docker_volume" "sonarqube_data" {
  name = "sonarqube_data"
}

resource "docker_volume" "sonarqube_extensions" {
  name = "sonarqube_extensions"
}

resource "docker_volume" "sonarqube_logs" {
  name = "sonarqube_logs"
}
