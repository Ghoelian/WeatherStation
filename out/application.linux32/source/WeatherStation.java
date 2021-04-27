import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.time.LocalDate; 
import http.requests.*; 
import com.google.gson.*; 

import com.google.gson.*; 
import com.google.gson.stream.*; 
import com.google.gson.reflect.*; 
import com.google.gson.internal.*; 
import com.google.gson.internal.reflect.*; 
import com.google.gson.internal.bind.*; 
import com.google.gson.internal.bind.util.*; 
import com.google.gson.annotations.*; 
import okhttp3.*; 
import okhttp3.internal.http1.*; 
import okhttp3.internal.proxy.*; 
import okhttp3.internal.cache.*; 
import okhttp3.internal.connection.*; 
import okhttp3.internal.platform.*; 
import okhttp3.internal.platform.android.*; 
import okhttp3.internal.io.*; 
import okhttp3.internal.*; 
import okhttp3.internal.cache2.*; 
import okhttp3.internal.http2.*; 
import okhttp3.internal.tls.*; 
import okhttp3.internal.http.*; 
import okhttp3.internal.concurrent.*; 
import okhttp3.internal.authenticator.*; 
import okhttp3.internal.publicsuffix.*; 
import okhttp3.internal.ws.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class WeatherStation extends PApplet {

PFont roboto;
Time time = new Time();
Segments segments = new Segments();
Date date = new Date();

// TODO: Get these details from .env file
Weather weather = new Weather("City", "Email", "API Key");

int mainTextSize = 150;

public void setup() {
  

  roboto = createFont("roboto.ttf", 32);
  textFont(roboto);
  weather.drawWeather();
}

public void draw() {
  background(0);
  
  segments.drawSegments(); 
  
  date.drawDate(mainTextSize);
  time.drawTime(mainTextSize);
}


class Date {
  public void drawDate(int textSize) {
    int day = day();
    int month = month();

    String fixedDay;
    String fixedMonth;
    String dayOfWeek = LocalDate.now().getDayOfWeek().name();
    
    if (day < 10) {
      fixedDay = "0" + Integer.toString(day);
    } else {
      fixedDay = Integer.toString(day);
    }

    if (month < 10) {
      fixedMonth = "0" + Integer.toString(month);
    } else {
      fixedMonth = Integer.toString(month);
    }

    if (dayOfWeek.length() > 3) {
      dayOfWeek = dayOfWeek.substring(0, 3);
    }

    textAlign(LEFT, TOP);
    textSize(textSize/1.75f);
    text(dayOfWeek + ",", 10, 0);
    
    textAlign(RIGHT, TOP);
    text(fixedDay + "/" + fixedMonth, (width)-10, 0);
  }
}
class Segments {
  public void drawSegments() {
    float segmentOneHeight = (height/3)*0.4f;
    float segmentTwoHeight = (height/3)*1;

    // Draw 3 lines, separating the 3 segments
    stroke(255);
    line(0, segmentOneHeight, width, segmentOneHeight);
    line(0, segmentTwoHeight, width, segmentTwoHeight);
  }
}
class Time {
  public void drawTime(int textSize) {
    //Draw time in the 2nd segment.
    int hours = hour();
    int minutes = minute();
    int seconds = second();
    
    String fixedHours;
    String fixedMinutes;
    String fixedSeconds;

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

    if (seconds < 10) {
      fixedSeconds = "0" + Integer.toString(seconds);
    } else {
      fixedSeconds = Integer.toString(seconds);
    }
    
    textAlign(LEFT, BOTTOM);
    textSize(textSize);
    text(fixedHours + ":" + fixedMinutes, 10, (height/3)*1.04f);
    
    textAlign(RIGHT, BOTTOM);
    textSize(textSize/2);
    text(fixedSeconds, (width)-10, (height/3)*0.97f);
  }
}



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

  public String getWeather() {
    GetRequest request = new GetRequest(String.format("https://api.openweathermap.org/data/2.5/onecall?lat=%s&lon=%s&appid=%s&units=metric", this.lat, this.lon, this.apiKey));
    request.send();
    
    String result = request.getContent();
    JsonObject resultObj = new JsonParser().parse(result).getAsJsonObject();
    
    JsonObject todayWeather = resultObj.get("current").getAsJsonObject();
    
    System.out.println(todayWeather);
    
    return result;
  }

  public void getLocation() {
    GetRequest request = new GetRequest(String.format("https://nominatim.openstreetmap.org/search?city=%s&email=%s&format=geojson", this.location, this.email));
    request.send();
    
    String result = request.getContent();
    JsonObject resultObj = new JsonParser().parse(result).getAsJsonObject();
    
    JsonArray latLon = resultObj.get("features").getAsJsonArray().get(0).getAsJsonObject().get("geometry").getAsJsonObject().get("coordinates").getAsJsonArray();
    this.lat = latLon.get(0).getAsString();
    this.lon = latLon.get(1).getAsString();
  }

  public void drawWeather() {
    getLocation();
    getWeather();
  }
}
  public void settings() {  size(480, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "WeatherStation" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
