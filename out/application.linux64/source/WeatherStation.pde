PFont roboto;
Time time = new Time();
Segments segments = new Segments();
Date date = new Date();

// TODO: Get these details from .env file
Weather weather = new Weather("City", "Email", "API Key");

int mainTextSize = 150;

void setup() {
  size(480, 800);

  roboto = createFont("roboto.ttf", 32);
  textFont(roboto);
  weather.drawWeather();
}

void draw() {
  background(0);
  
  segments.drawSegments(); 
  
  date.drawDate(mainTextSize);
  time.drawTime(mainTextSize);
}
