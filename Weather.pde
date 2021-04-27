import http.requests.*;
import com.google.gson.*;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

class Weather {
  private String location;
  private String email;
  private String lat;
  private String lon;
  private String apiKey;
  private String lastWeather;
  private String lastIcon;

  private int textSize;
  private int lastTemp;
  private int iconX = 0;
  private int iconY = 370;
  private int iconWidthHeight = width;

  private long lastWeatherTimestamp = 0;

  private LocalDateTime lastWeatherTime;

  private Map<String, PImage> icons;

  Weather(String location, String email, String apiKey, int textSize) {
    this.icons = new HashMap<String, PImage>();

    this.location = location;
    this.email = email;
    this.apiKey = apiKey;

    this.textSize = textSize;

    this.getLocation();
  }

  void getWeather() {
    long now = Instant.ofEpochSecond(0L).until(Instant.now(), ChronoUnit.SECONDS);

    if (lastWeatherTimestamp == 0 || (now - lastWeatherTimestamp) > 600) {
      GetRequest request = new GetRequest(String.format("https://api.openweathermap.org/data/2.5/onecall?lat=%s&lon=%s&appid=%s&units=metric", this.lat, this.lon, this.apiKey));
      request.send();

      String result = request.getContent();
      JsonObject resultObj = JsonParser.parseString(result).getAsJsonObject();

      JsonObject todayWeather = resultObj.get("current").getAsJsonObject();

      this.lastWeather = todayWeather.get("weather").getAsJsonArray().get(0).getAsJsonObject().get("main").getAsString();
      this.lastTemp = todayWeather.get("temp").getAsInt();
      this.lastIcon = todayWeather.get("weather").getAsJsonArray().get(0).getAsJsonObject().get("icon").getAsString();

      this.lastWeatherTime = LocalDateTime.ofInstant(Instant.now(), ZoneId.systemDefault());
      this.lastWeatherTimestamp = Instant.ofEpochSecond(0L).until(Instant.now(), ChronoUnit.SECONDS);
    }
  }

  private void getLocation() {
    GetRequest request = new GetRequest(String.format("https://nominatim.openstreetmap.org/search?city=%s&email=%s&format=geojson", this.location, this.email));
    request.send();

    String result = request.getContent();
    JsonObject resultObj = JsonParser.parseString(result).getAsJsonObject();

    JsonArray latLon = resultObj.get("features").getAsJsonArray().get(0).getAsJsonObject().get("geometry").getAsJsonObject().get("coordinates").getAsJsonArray();

    this.lat = latLon.get(1).getAsString();
    this.lon = latLon.get(0).getAsString();
  }

  void drawIcon(String code) {
    if (this.icons.get(code) == null) {
      PImage image = loadImage(String.format("icons/%s.png", code));

      this.icons.put(code, image);
    }

    image(this.icons.get(code), iconX, iconY, iconWidthHeight, iconWidthHeight);
  }

  void drawWeather() {
    getWeather();

    fill(255);
    textAlign(CENTER, TOP);

    textSize(this.textSize);
    text(String.format("%s°C", this.lastTemp), width/2, 255);

    textSize(this.textSize/2);
    text(this.lastWeather, width/2, 400);

    drawIcon(this.lastIcon);

    textSize(this.textSize/4);
    textAlign(CENTER, BOTTOM);

    int hours = this.lastWeatherTime.getHour();
    int minutes =  this.lastWeatherTime.getMinute();
    
    String fixedHours;
    String fixedMinutes;
    
    if (hours < 10) {
      fixedHours = "0" + Integer.toString(hours);
    } else {
      fixedHours = Integer.toString(hours);
    }

    if (minutes < 10) {
      fixedMinutes = "0" + Integer.toString(minutes);
    } else {
      fixedMinutes = Integer.toString(minutes);
    }
    
    text(String.format("%s:%s", fixedHours, fixedMinutes), width/2, 785);
  }
}
