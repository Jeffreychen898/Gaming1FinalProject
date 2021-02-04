class Button {
  String buttonText;
  PVector location;
  PVector size;
  float fontSize = 12;
  Button(String text) {
    buttonText = text;
    location = new PVector(0, 0);
    size = new PVector(0, 0);
  }
  Button(String text, int x, int y, int w, int h) {
    buttonText = text;
    location = new PVector(x, y);
    size = new PVector(w, h);
  }
  void setLocation(int x, int y) {
    location = new PVector(x, y);
  }
  void setSize(int w, int h) {
    size = new PVector(w, h);
  }
  boolean hover() {
    float cornerX = location.x - size.x / 2;
    float cornerY = location.y - size.y / 2;
    return mouseX > cornerX && mouseX < cornerX + size.x && mouseY > cornerY && mouseY < cornerY + size.y;
  }
  void setFontSize(float fontSize) {
    this.fontSize = fontSize;
  }
  void draw() {
    image(buttonBanner, location.x, location.y, size.x, size.y);
    textSize((int)fontSize);
    text(buttonText, location.x, location.y);
    textSize(12);
  }
}
