class Credit {
  Button menuBtn, instructionsBtn;
  CreditParticles head;
  float particleOrigin;
  Credit() {
    menuBtn = new Button("Menu", width / 24 + 20, height - width / 48 - 20, width / 12, width / 24);
    instructionsBtn = new Button("Instruction", width - width / 24 - 20, height - width / 48 - 20, width / 12, width / 24);
    menuBtn.setFontSize(20);
    instructionsBtn.setFontSize(20);
    particleOrigin = 0;
    head = null;
  }
  void update() {
    addParticles();
    //draw the background image
    drawBackgroundImage();
    //write the credits
    writeCredits();
    //handle the particles
    particleHandler();
    //handle the buttons
    buttonHandler();
  }
  void addParticles() {
    CreditParticles newParticle = new CreditParticles(width/2 + cos(particleOrigin) * 400, height/2 + sin(particleOrigin) * 400);
    newParticle.next = head;
    head = newParticle;
  }
  void particleHandler() {
    CreditParticles current = head;
    CreditParticles previous = null;
    while(current != null) {
      current.update();
      current.draw();
      if(current.isDead()) {
        if(previous == null) {
          head = current.next;
        } else {
          previous.next = current.next;
        }
      }
      
      previous = current;
      current = current.next;
    }
    particleOrigin += 0.5 * deltaTime;
  }
  void buttonHandler() {
    if (menuBtn.hover()) {
      int newWidth = (int)linearInterpolation(menuBtn.size.x, width / 12 - 20, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(menuBtn.size.y, width / 24 - 10, 10 * deltaTime);
      float newTextSize = linearInterpolation(menuBtn.fontSize, 15, 10 * deltaTime);
      menuBtn.setSize(newWidth, newHeight);
      menuBtn.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(menuBtn.size.x, width / 12, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(menuBtn.size.y, width / 24, 10 * deltaTime);
      float newTextSize = linearInterpolation(menuBtn.fontSize, 20, 10 * deltaTime);
      menuBtn.setSize(newWidth, newHeight);
      menuBtn.setFontSize(newTextSize);
    }

    if (instructionsBtn.hover()) {
      int newWidth = (int)linearInterpolation(instructionsBtn.size.x, width / 12 - 20, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(instructionsBtn.size.y, width / 24 - 10, 10 * deltaTime);
      float newTextSize = linearInterpolation(instructionsBtn.fontSize, 15, 10 * deltaTime);
      instructionsBtn.setSize(newWidth, newHeight);
      instructionsBtn.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(instructionsBtn.size.x, width / 12, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(instructionsBtn.size.y, width / 24, 10 * deltaTime);
      float newTextSize = linearInterpolation(instructionsBtn.fontSize, 20, 10 * deltaTime);
      instructionsBtn.setSize(newWidth, newHeight);
      instructionsBtn.setFontSize(newTextSize);
    }
    
    fill(0, 100);
    rect(width/2, menuBtn.location.y, width, width / 24 + 2 * (width / 48 - 20));
    fill(255);
    menuBtn.draw();
    instructionsBtn.draw();
  }
  void writeCredits() {
    fill(0, 200);
    rect(width/2, height/2, width/2, height/2);
    fill(255);
    textSize(100);
    text("Credits:\nJeffrey Chen\n:)", width/2, height/2);
  }
  void drawBackgroundImage() {
    int imageWidth = width;
    int imageHeight = height;
    if(imageWidth > imageHeight * 2) {
      imageHeight = imageWidth / 2;
    } else {
      imageWidth = imageHeight * 2;
    }
    image(background, width/2, height/2, imageWidth, imageHeight);
  }
  void keyPressed(int keyCode) {
  }
  void keyReleased(int keyCode) {
  }
  void mousePressed() {
  }
  void mouseReleased() {
    if(menuBtn.hover()) {
      reset();
      stopMusic();
    }
    if(instructionsBtn.hover()) {
      gameState = 4;
      stopMusic();
    }
  }
}
class CreditParticles {
  PVector location;
  PVector velocity;
  float size;
  CreditParticles next;
  CreditParticles(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(getRand(-50, 50), getRand(-100, 100));
    size = 20;
  }
  void update() {
    location.add(velocity.copy().mult(deltaTime));
    size -= 10 * deltaTime;
    size = max(size, 0);
  }
  void draw() {
    fill(255, 255, 0);
    rect(location.x, location.y, size, size);
  }
  boolean isDead() {
    return size <= 0;
  }
}
