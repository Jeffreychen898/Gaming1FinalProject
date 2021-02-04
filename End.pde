class End {
  float defeatTitleDelta;
  float currentFontSize;
  boolean shrink;
  Button creditButton;
  Button menuButton;
  End() {
    currentFontSize = 200;
    shrink = false;
    menuButton = new Button("Menu", width/2, height/2 + 100, width/6, width/12);
    creditButton = new Button("Credit", width/2, height/2 + 100 + width/12, width/6 - 50, width/12 - 50);
    creditButton.setFontSize(30);
    menuButton.setFontSize(40);
    defeatTitleDelta = 0;
  }
  void update() {
    //draw the background
    drawBackground();
    //draw the title + animation
    if(victory) {
      winTitle();
    } else {
      loseTitle();
    }
    //draw the buttons
    updateButtonSize();
    fill(255);
    menuButton.draw();
    creditButton.draw();
  }
  void updateButtonSize() {
    if (menuButton.hover()) {
      int newWidth = (int)linearInterpolation(menuButton.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(menuButton.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(menuButton.fontSize, 30, 10 * deltaTime);
      menuButton.setSize(newWidth, newHeight);
      menuButton.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(menuButton.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(menuButton.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(menuButton.fontSize, 40, 10 * deltaTime);
      menuButton.setSize(newWidth, newHeight);
      menuButton.setFontSize(newTextSize);
    }
    if (creditButton.hover()) {
      int newWidth = (int)linearInterpolation(creditButton.size.x, width/6 - 90, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(creditButton.size.y, width/12 - 70, 10 * deltaTime);
      float newTextSize = linearInterpolation(creditButton.fontSize, 25, 10 * deltaTime);
      creditButton.setSize(newWidth, newHeight);
      creditButton.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(creditButton.size.x, width/6 - 50, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(creditButton.size.y, width/12 - 50, 10 * deltaTime);
      float newTextSize = linearInterpolation(creditButton.fontSize, 30, 10 * deltaTime);
      creditButton.setSize(newWidth, newHeight);
      creditButton.setFontSize(newTextSize);
    }
  }
  void loseTitle() {
    float titleSize = 200;
    titleSize += sin(defeatTitleDelta) * 50;
    fill(255, 0, 0);
    textSize(titleSize);
    text("DEFEAT", width/2, height/4);
    defeatTitleDelta +=  deltaTime;
  }
  void winTitle() {
    if (currentFontSize >= 198) {
      shrink = true;
    } else if (currentFontSize <= 152) {
      shrink = false;
    }
    if (shrink) {
      currentFontSize = linearInterpolation(currentFontSize, 150, 5 * deltaTime);
    } else {
      currentFontSize = linearInterpolation(currentFontSize, 200, 40 * deltaTime);
    }
    fill(0, 255, 0);
    textSize(currentFontSize);
    text("VICTORY", width/2, height/4);
  }
  void drawBackground() {
    int backgroundWidth = width;
    int backgroundHeight = height;
    if (backgroundWidth > backgroundHeight * 2) {
      backgroundHeight = backgroundWidth / 2;
    } else {
      backgroundWidth = backgroundHeight * 2;
    }
    image(background, width/2, height/2, backgroundWidth, backgroundHeight);
  }
  void keyPressed(int keyCode) {
  }
  void keyReleased(int keyCode) {
  }
  void mousePressed() {
  }
  void mouseReleased() {
    if(menuButton.hover()) {
      reset();
      stopMusic();
    }
    if(creditButton.hover()) {
      gameState = 5;
      stopMusic();
    }
  }
}
