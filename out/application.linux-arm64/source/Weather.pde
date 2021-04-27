import http.requests.*;
import com.google.gson.*;

class Weather {
  private String location;
  private String email;
  private String lat;
  private String lon;
  private String apiKey;

  Weather(String location, String email, String apiKey) {
    this.location = location;
    this.email = email;
    this.apiKey = apiKey;
  }

  String getWeather() {
    GetRequest request = new GetRequest(String.format("https://api.openweathermap.org/data/2.5/onecall?lat=%s&lon=%s&appid=%s&units=metric", this.lat, this.lon, this.apiKey));
    request.send();
    
    String result = request.getContent();
    JsonObject resultObj = new JsonParser().parse(result).getAsJsonObject();
    
    JsonObject todayWeather = resultObj.get("current").getAsJsonObject();
    
    System.out.println(todayWeather);
    
    return result;
  }

  void getLocation() {
    GetRequest request = new GetRequest(String.format("https://nominatim.openstreetmap.org/search?city=%s&email=%s&format=geojson", this.location, this.email));
    request.send();
    
    String result = request.getContent();
    JsonObject resultObj = new JsonParser().parse(result).getAsJsonObject();
    
    JsonArray latLon = resultObj.get("features").getAsJsonArray().get(0).getAsJsonObject().get("geometry").getAsJsonObject().get("coordinates").getAsJsonArray();
    this.lat = latLon.get(0).getAsString();
    this.lon = latLon.get(1).getAsString();
  }

  void drawWeather() {
    getLocation();
    getWeather();
  }
}
