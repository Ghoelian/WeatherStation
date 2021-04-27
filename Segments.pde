class Segments {
  void drawSegments() {
    int segmentOneHeight = 107;
    int segmentTwoHeight = 267;

    // Draw 3 lines, separating the 3 segments
    stroke(255);
    line(0, segmentOneHeight, width, segmentOneHeight);
    line(0, segmentTwoHeight, width, segmentTwoHeight);
  }
}
