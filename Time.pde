class Time {
  private int textSize;
  
  Time(int textSize) {
    this.textSize = textSize;
  }
  
  void drawTime() {
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
    
    fill(255);
    
    textAlign(LEFT, BOTTOM);
    textSize(this.textSize);
    text(fixedHours + ":" + fixedMinutes, 10, 277);
    
    textAlign(RIGHT, BOTTOM);
    textSize(this.textSize/2);
    text(fixedSeconds, 470, 207);
  }
}
