class Time {
  void drawTime(int textSize) {
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
    text(fixedHours + ":" + fixedMinutes, 10, (height/3)*1.04);
    
    textAlign(RIGHT, BOTTOM);
    textSize(textSize/2);
    text(fixedSeconds, (width)-10, (height/3)*0.97);
  }
}
