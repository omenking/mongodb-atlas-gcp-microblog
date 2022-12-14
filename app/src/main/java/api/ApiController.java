package api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@CrossOrigin(
  origins= "*", 
  maxAge = 3600, 
  exposedHeaders = {
    "Access-Control-Allow-Origin",
    "Access-Control-Allow-Credentials",
    "X-Get-Header"
  },
  allowedHeaders = {
    "Authorization", 
    "Origin",
    "Requestor-Type"
  }
)
@RestController
@RequestMapping(path="/api", produces="application/json")
public class ApiController{
  @RequestMapping(method = RequestMethod.GET, path = "/activities/home")
  public String home() {
    return "home data";
  }
  @RequestMapping(method = RequestMethod.GET, path = "/activities/search")
  public String search() {
    return "search data";
  }
  @RequestMapping(method = RequestMethod.POST, path = "/activities")
  public String create() {
    return "create data";
  }
  public static void main(String[] args) {
    SpringApplication.run(ApiController.class, args);
  }

}