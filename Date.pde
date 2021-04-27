import java.time.LocalDate;

class Date {
  private int textSize;
  
  Date (int textSize) {
    this.textSize = textSize;
  }
  
  void drawDate() {
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
    
    fill(255);

    textAlign(LEFT, TOP);
    textSize(this.textSize/1.75);
    text(dayOfWeek, 10, 5);
    
    textAlign(RIGHT, TOP);
    text(fixedDay + "/" + fixedMonth, 470, 5);
  }
}
