class Menu {
  float timePassed;
  Button play, instruction, credit;
  Menu() {
    timePassed = 0;
    play = new Button("Play", 0, 0, width / 6, width / 12);
    instruction = new Button("Instructions", 0, 0, width / 6, width / 12);
    credit = new Button("Credit", 0, 0, width / 6, width / 12);
    play.setFontSize(40);
    instruction.setFontSize(40);
    credit.setFontSize(40);
  }
  void update() {
    timePassed += 5.0 * deltaTime;
    //draw the background
    drawBackground();
    //draw the title
    drawTitle();
    //draw the buttons
    drawButton();
  }
  void drawButton() {
    int buttonY = height / 2 + 200;
    int playButtonX = width / 2;
    int instructionButtonX = width / 2 - width / 6 - 50;
    int creditButtonX = width /2 + width / 6 + 50;
    play.setLocation(playButtonX, buttonY);
    instruction.setLocation(instructionButtonX, buttonY);
    credit.setLocation(creditButtonX, buttonY);
    fill(255);
    play.draw();
    instruction.draw();
    credit.draw();

    if (play.hover()) {
      int newWidth = (int)linearInterpolation(play.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(play.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(play.fontSize, 30, 10 * deltaTime);
      play.setSize(newWidth, newHeight);
      play.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(play.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(play.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(play.fontSize, 40, 10 * deltaTime);
      play.setSize(newWidth, newHeight);
      play.setFontSize(newTextSize);
    }

    if (instruction.hover()) {
      int newWidth = (int)linearInterpolation(instruction.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(instruction.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(instruction.fontSize, 30, 10 * deltaTime);
      instruction.setSize(newWidth, newHeight);
      instruction.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(instruction.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(instruction.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(instruction.fontSize, 40, 10 * deltaTime);
      instruction.setSize(newWidth, newHeight);
      instruction.setFontSize(newTextSize);
    }

    if (credit.hover()) {
      int newWidth = (int)linearInterpolation(credit.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(credit.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(credit.fontSize, 30, 10 * deltaTime);
      credit.setSize(newWidth, newHeight);
      credit.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(credit.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(credit.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(credit.fontSize, 40, 10 * deltaTime);
      credit.setSize(newWidth, newHeight);
      credit.setFontSize(newTextSize);
    }
  }
  void drawTitle() {
    float titleWidth = width / 2 + sin(timePassed) * 20;
    float titleHeight = width / 4 + sin(timePassed) * 10;
    image(title, width / 2, titleHeight / 2 + 100, titleWidth, titleHeight);
  }
  void drawBackground() {
    int backgroundWidth = width;
    int backgroundHeight = height;
    if (backgroundWidth > backgroundHeight * 2) {
      backgroundHeight = backgroundWidth / 2;
    } else {
      backgroundWidth = backgroundHeight * 2;
    }
    image(background, width / 2, height / 2, backgroundWidth, backgroundHeight);
  }
  void keyPressed(int code) {
  }
  void keyReleased(int code) {
  }
  void mousePressed() {
  }
  void mouseReleased() {
    if (play.hover()) {
      gameState = 1;
      stopMusic();
    } else if (instruction.hover()) {
      gameState = 4;
      stopMusic();
    } else if (credit.hover()) {
      gameState = 5;
      stopMusic();
    }
  }
}
