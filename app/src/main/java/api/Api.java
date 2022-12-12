package api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.CrossOrigin;

@SpringBootApplication
@RestController
@RequestMapping(path="/api", produces="application/json")
@CrossOrigin(origins="https://3000-omenking-mongodbatlasgc-skjji64264b.ws-us78.gitpod.io")

public class Api{
  @RequestMapping("/activities/home")
  public String home() {
    return "Hello Docker World";
  }

  public static void main(String[] args) {
    SpringApplication.run(Api.class, args);
  }

}