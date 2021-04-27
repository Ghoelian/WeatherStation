class Segments {
  void drawSegments() {
    float segmentOneHeight = (height/3)*0.4;
    float segmentTwoHeight = (height/3)*1;

    // Draw 3 lines, separating the 3 segments
    stroke(255);
    line(0, segmentOneHeight, width, segmentOneHeight);
    line(0, segmentTwoHeight, width, segmentTwoHeight);
  }
}
