JSONObject variables;

String city; // City to get the current weather for
String email; // Email to identify yourself to nominatim
String apiKey; // API key for OpenWeatherMap

PFont roboto;
int mainTextSize = 150;

Time time;
Segments segments;
Date date;

Weather weather;

void setup() {
  size(480, 800);
  noCursor();
  frameRate(10);
  
  variables = loadJSONObject("variables.json");
  
  city = variables.getString("city");
  email = variables.getString("email");
  apiKey = variables.getString("apiKey");

  roboto = createFont("roboto.ttf", 32);
  textFont(roboto);

  date = new Date(mainTextSize);
  segments = new Segments();
  time = new Time(mainTextSize);
  weather = new Weather(city, email, apiKey, mainTextSize);
}

void draw() {
  background(0);

  segments.drawSegments(); 

  date.drawDate();
  time.drawTime();
  weather.drawWeather();
}
