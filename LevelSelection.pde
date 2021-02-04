class LevelSelection {
  float timePassed;
  Button level1, level2, level3, startPage, credit;
  LevelSelection() {
    timePassed = 0;
    level1 = new Button("Level 1", 0, 0, width / 6, width / 12);
    level2 = new Button("Level 2", 0, 0, width / 6, width / 12);
    level3 = new Button("Level 3", 0, 0, width / 6, width / 12);
    startPage = new Button("Menu", 0, 0, width / 12, width / 24);
    credit = new Button("Credit", 0, 0, width / 12, width / 24);
    level1.setFontSize(40);
    level2.setFontSize(40);
    level3.setFontSize(40);
    startPage.setFontSize(20);
    credit.setFontSize(20);
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
    int level1ButtonX = width / 2 - width / 6 - 50;
    int level2ButtonX = width / 2;
    int level3ButtonX = width / 2 + width / 6 + 50;
    level1.setLocation(level1ButtonX, buttonY);
    level2.setLocation(level2ButtonX, buttonY);
    level3.setLocation(level3ButtonX, buttonY);
    startPage.setLocation(width / 24 + 20, height - width / 48 - 20);
    credit.setLocation(width - width / 24 - 20, height - width / 48 - 20);
    fill(255);
    level1.draw();
    level2.draw();
    level3.draw();
    startPage.draw();
    credit.draw();

    if (level1.hover()) {
      int newWidth = (int)linearInterpolation(level1.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(level1.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(level1.fontSize, 30, 10 * deltaTime);
      level1.setSize(newWidth, newHeight);
      level1.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(level1.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(level1.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(level1.fontSize, 40, 10 * deltaTime);
      level1.setSize(newWidth, newHeight);
      level1.setFontSize(newTextSize);
    }

    if (level2.hover()) {
      int newWidth = (int)linearInterpolation(level2.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(level2.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(level2.fontSize, 30, 10 * deltaTime);
      level2.setSize(newWidth, newHeight);
      level2.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(level2.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(level2.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(level2.fontSize, 40, 10 * deltaTime);
      level2.setSize(newWidth, newHeight);
      level2.setFontSize(newTextSize);
    }

    if (level3.hover()) {
      int newWidth = (int)linearInterpolation(level3.size.x, width / 6 - 40, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(level3.size.y, width / 12 - 20, 10 * deltaTime);
      float newTextSize = linearInterpolation(level3.fontSize, 30, 10 * deltaTime);
      level3.setSize(newWidth, newHeight);
      level3.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(level3.size.x, width / 6, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(level3.size.y, width / 12, 10 * deltaTime);
      float newTextSize = linearInterpolation(level3.fontSize, 40, 10 * deltaTime);
      level3.setSize(newWidth, newHeight);
      level3.setFontSize(newTextSize);
    }

    if (startPage.hover()) {
      int newWidth = (int)linearInterpolation(startPage.size.x, width / 12 - 20, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(startPage.size.y, width / 24 - 10, 10 * deltaTime);
      float newTextSize = linearInterpolation(startPage.fontSize, 15, 10 * deltaTime);
      startPage.setSize(newWidth, newHeight);
      startPage.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(startPage.size.x, width / 12, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(startPage.size.y, width / 24, 10 * deltaTime);
      float newTextSize = linearInterpolation(startPage.fontSize, 20, 10 * deltaTime);
      startPage.setSize(newWidth, newHeight);
      startPage.setFontSize(newTextSize);
    }

    if (credit.hover()) {
      int newWidth = (int)linearInterpolation(credit.size.x, width / 12 - 20, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(credit.size.y, width / 24 - 10, 10 * deltaTime);
      float newTextSize = linearInterpolation(credit.fontSize, 15, 10 * deltaTime);
      credit.setSize(newWidth, newHeight);
      credit.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(credit.size.x, width / 12, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(credit.size.y, width / 24, 10 * deltaTime);
      float newTextSize = linearInterpolation(credit.fontSize, 20, 10 * deltaTime);
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
    if (level1.hover() || level2.hover() || level3.hover()) {
      if(level1.hover()) {
        map = mapCopy(map1);
      } else if(level2.hover()) {
        map = mapCopy(map2);
      } else if(level3.hover()) {
        map = mapCopy(map3);
      }
      gameState = 2;
      stopMusic();
    } else if (startPage.hover()) {
      gameState = 0;
      stopMusic();
    } else if (credit.hover()) {
      gameState = 5;
      stopMusic();
    }
  }
  int[][] mapCopy(int[][] currentCopy) {
    int[][] copyOfMap = new int[currentCopy.length][currentCopy[0].length];
    for(int i=0;i<currentCopy.length;i++) {
      int[] eachRow = new int[currentCopy[0].length];
      for(int j=0;j<currentCopy[i].length;j++) {
        eachRow[j] = currentCopy[i][j];
      }
      copyOfMap[i] = eachRow;
    }
    return copyOfMap;
  }
}
