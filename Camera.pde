class GameCamera {
  PVector cameraLocation;
  PVector cameraSize;
  GameCamera(int x, int y, int w, int h) {
    cameraLocation = new PVector(x, y);
    cameraSize = new PVector(w, h);
  }
  void setLocation(int x, int y) {
    cameraLocation = new PVector(x, y);
  }
  void moveLocation(int x, int y) {
    cameraLocation.add(x, y);
  }
  void resize(int w, int h) {
    cameraSize.add(w, h);
  }
  void setSize(int w, int h) {
    cameraSize = new PVector(w, h);
  }
  PVector calculateLocation(float x, float y) {
    PVector result = new PVector(x, y);
    //normalise the camera position
    float cameraX = cameraLocation.x / cameraSize.x;
    float cameraY = cameraLocation.y / cameraSize.y;
    //normalise the object position
    result.x /= cameraSize.x;
    result.y /= cameraSize.y;
    //subtract the object position by the camera position
    result.sub(cameraX, cameraY);
    //multiply coordinates by window dimension
    result.x *= width;
    result.y *= height - 100;
    return result;
  }
  PVector calculateSize(float w, float h) {
    PVector result = new PVector(w / cameraSize.x, h / cameraSize.y);
    result.x *= width;
    result.y *= height - 100;
    return result;
  }
  void drawRect(float x, float y, float w, float h) {
    PVector pos = calculateLocation(x, y);
    PVector size = calculateSize(w, h);
    rect(pos.x, pos.y+100, size.x, size.y);
  }
  void drawImage(PImage img, float x, float y, float w, float h, float ang) {
    PVector pos = calculateLocation(x, y);
    PVector size = calculateSize(w, h);
    pushMatrix();
    translate(pos.x, pos.y+100);
    rotate(ang);
    image(img, 0, 0, size.x, size.y);
    popMatrix();
  }
}
