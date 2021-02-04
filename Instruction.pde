class Instruction {
  float image1Y;
  float image2Y;
  Button menuButton;
  Button creditButton;
  String[] tabLabels = {"Overview", "Goal", "Death", "HP & Energy", "Controls"};
  int tabOpened;
  //making object move to fulfill requirement
  float spaceshipAngle;
  float moveShip;
  PVector spaceshipLocation;
  
  Instruction() {
    image1Y = 0;
    image2Y = width * (680.0 / 871.0);
    menuButton = new Button("Menu", width / 24 + 20, height - width / 48 - 20, width / 12, width / 24);
    creditButton = new Button("Credit", width - width / 24 - 20, height - width / 48 - 20, width / 12, width / 24);
    menuButton.setFontSize(20);
    creditButton.setFontSize(20);
    tabOpened = 0;
    spaceshipLocation = new PVector(100, height / 2);
    spaceshipAngle = 0;
    moveShip = 0;
  }
  void update() {
    //draw the background
    drawBackground();
    //draw the spaceship moving around
    pushMatrix();
    translate(spaceshipLocation.x, spaceshipLocation.y);
    rotate(spaceshipAngle);
    image(player1, 0, 0, 100, 50);
    popMatrix();
    spaceshipLocation.add(cos(spaceshipAngle) * 400 * deltaTime, sin(spaceshipAngle) * 400 * deltaTime);
    spaceshipAngle = sin(moveShip) * PI/4;
    moveShip += 4 * deltaTime;
    if(spaceshipLocation.x > width) {
      spaceshipLocation.x = 0;
    }
    //draw the tabs
    drawTabs();
    //draw the content
    drawContent();
    //draw the buttons
    buttonHandler();
  }
  void drawBackground() {
    float backgroundWidth = width;
    float backgroundHeight = height;
    if(backgroundWidth > backgroundHeight * 2) {
      backgroundHeight = backgroundWidth / 2;
    } else {
      backgroundWidth = backgroundHeight * 2;
    }
    image(background, width/2, height/2, backgroundWidth, backgroundHeight);
  }
  void buttonHandler() {
    if (menuButton.hover()) {
      int newWidth = (int)linearInterpolation(menuButton.size.x, width / 12 - 20, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(menuButton.size.y, width / 24 - 10, 10 * deltaTime);
      float newTextSize = linearInterpolation(menuButton.fontSize, 15, 10 * deltaTime);
      menuButton.setSize(newWidth, newHeight);
      menuButton.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(menuButton.size.x, width / 12, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(menuButton.size.y, width / 24, 10 * deltaTime);
      float newTextSize = linearInterpolation(menuButton.fontSize, 20, 10 * deltaTime);
      menuButton.setSize(newWidth, newHeight);
      menuButton.setFontSize(newTextSize);
    }

    if (creditButton.hover()) {
      int newWidth = (int)linearInterpolation(creditButton.size.x, width / 12 - 20, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(creditButton.size.y, width / 24 - 10, 10 * deltaTime);
      float newTextSize = linearInterpolation(creditButton.fontSize, 15, 10 * deltaTime);
      creditButton.setSize(newWidth, newHeight);
      creditButton.setFontSize(newTextSize);
    } else {
      int newWidth = (int)linearInterpolation(creditButton.size.x, width / 12, 10 * deltaTime);
      int newHeight = (int)linearInterpolation(creditButton.size.y, width / 24, 10 * deltaTime);
      float newTextSize = linearInterpolation(creditButton.fontSize, 20, 10 * deltaTime);
      creditButton.setSize(newWidth, newHeight);
      creditButton.setFontSize(newTextSize);
    }
    
    fill(255);
    menuButton.draw();
    creditButton.draw();
  }
  void drawTabs() {
    float tabStartingX = width / 2 - 350;
    stroke(0);
    strokeWeight(2);
    textSize(15);
    for(int i=0;i<5;i++) {
      fill(255);
      if(mouseX > tabStartingX + i * 100 - 50 && mouseX < tabStartingX + i * 100 + 50) {
        if(mouseY > height / 2 - 350 && mouseY < height / 2 - 300) {
          fill(255, 255, 200);
        }
      }
      if(tabOpened == i) {
        fill(255, 255, 0);
      }
      rect(tabStartingX + i * 100, height / 2 - 325, 100, 50);
      fill(0);
      text(tabLabels[i], tabStartingX + i * 100, height / 2 - 325);
    }
    noStroke();
  }
  void drawContent() {
    PImage contentImage = OverviewTab;
    if(tabOpened == 1) {
      contentImage = GoalTab;
    } else if(tabOpened == 2) {
      contentImage = DeathTab;
    } else if(tabOpened == 3) {
      contentImage = HpTab;
    } else if(tabOpened == 4) {
      contentImage = ControlTab;
    }
    image(contentImage, width/2, height/2, 800, 600);
  }
  void keyPressed(int keyCode) {
  }
  void keyReleased(int keyCode) {
  }
  void mousePressed() {
    float tabStartingX = width / 2 - 350;
    for(int i=0;i<5;i++) {
      if(mouseX > tabStartingX + i * 100 - 50 && mouseX < tabStartingX + i * 100 + 50) {
        if(mouseY > height / 2 - 350 && mouseY < height / 2 - 300) {
          tabOpened = i;
        }
      }
    }
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
