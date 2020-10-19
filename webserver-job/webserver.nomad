job "webserver" {
  datacenters = ["dc1"]

  group "webservers" {
    task "server" {
      driver = "docker"

      config {
        image = "hashicorp/http-echo"

        args = [
          "-listen",
          ":5678",
          "-text",
          "hello world",
        ]
      }

      resources {
        network {
          mbits = 10

          port "http" {
            static = "5678"
          }
        }
      }
    }
  }
}