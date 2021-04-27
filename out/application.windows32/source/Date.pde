import java.time.LocalDate;

class Date {
  void drawDate(int textSize) {
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
    textSize(textSize/1.75);
    text(dayOfWeek + ",", 10, 0);
    
    textAlign(RIGHT, TOP);
    text(fixedDay + "/" + fixedMonth, (width)-10, 0);
  }
}
