int TILE_SIZE;
class Game {
  float cameraSizeToggle = 0;
  boolean isCameraSizeToggle;
  boolean running;
  boolean started;
  PVector aspectRatio;
  GameCamera c;
  Player player1, player2;
  boolean[] keyHeld = new boolean[4];//W S UP DOWN
  ShooterList shooterList;
  float[] targetHp = new float[2];
  float[] health = new float[2];
  float[] targetMp = new float[2];
  float[] mana = new float[2];
  float cameraX;
  Button pauseButton;
  Button menuButton;
  Button resumeButton;
  Game() {
    running = false;
    started = false;
    TILE_SIZE = 100;
    aspectRatio = new PVector((float)width/(float)(height-100), (float)(height-100)/(float)width);
    c = new GameCamera(0, 0, (int)(1000 * aspectRatio.x), 1000);
    player1 = new Player(1, 100, 333, 0);
    player2 = new Player(2, 100, 666, 0);
    for (int i=0; i<4; i++) {
      keyHeld[i] = false;
    }
    shooterList = new ShooterList();
    targetHp[0] = PLAYER_HEALTH;
    targetHp[1] = PLAYER_HEALTH;
    health[0] = PLAYER_HEALTH;
    health[1] = PLAYER_HEALTH;
    cameraX = 500 * aspectRatio.x;
    isCameraSizeToggle = false;
    pauseButton = new Button("Pause", width / 2, 150, width/12, width/24);
    menuButton = new Button("Menu", width/2, height/2 + 150, 200, 100);
    resumeButton = new Button("Resume", width/2, height/2, 300, 150);
    pauseButton.setFontSize(20);
    resumeButton.setFontSize(35);
    menuButton.setFontSize(20);
  }
  void update() {
    //draw the game
    drawBackground();
    if (running) {
      updateGame();
    }
    renderGame();
    //draw the map
    renderMap(player1.location.x/(map[0].length*TILE_SIZE), player2.location.x/(map[0].length*TILE_SIZE));
    //draw the buttons, hp bar, etc
    rectMode(CORNER);
    fill(0, 200);
    rect(0, 100, width, 100);
    drawPlayer1Health((int)health[0], (int)mana[0]);
    drawPlayer2Health((int)health[1], (int)mana[1]);
    rectMode(CENTER);
    //draw the pause button
    fill(255);
    pauseButton.draw();
    if (started && !running) {
      handlePauseScreen();
    }
  }
  void handlePauseScreen() {
    fill(0, 200);
    rect(width/2, height/2, width, height);
    textSize(100);
    fill(255, 255, 0);
    text("PAUSED", width/2, height/4);
    resumeButton.draw();
    menuButton.draw();
  }
  void drawPlayer2Health(int playerHealth, int playerMana) {
    //draw the container
    fill(0, 255, 0);
    rect(width-48 - width/3 - 4, 123, width/3+4, 59);
    fill(0);
    rect(width-50 - width/3, 125, width/3, 50);
    //draw the health
    float hpBarWidth = ((width/3)/(float)PLAYER_HEALTH)*playerHealth;
    float mpBarWidth = ((width/3)/(float)PLAYER_MANA)*playerMana;
    fill(255, 0, 0);
    rect(width-50-hpBarWidth, 125, hpBarWidth, 50);
    //draw the energy
    fill(255, 255, 0);
    rect(width-50-mpBarWidth, 175, mpBarWidth, 5);
  }
  void drawPlayer1Health(int playerHealth, int playerMana) {
    //draw the container
    fill(0, 0, 255);
    rect(48, 123, width/3+4, 59);
    fill(0);
    rect(50, 125, width/3, 50);
    //draw the health
    fill(255, 0, 0);
    rect(50, 125, ((width/3)/(float)PLAYER_HEALTH)*playerHealth, 50);
    //draw the energy
    fill(255, 255, 0);
    rect(50, 175, ((width/3)/(float)PLAYER_MANA)*playerMana, 5);
  }
  void updateGame() {
    //hp
    targetHp[0] = player1.health;
    targetHp[1] = player2.health;
    health[0] = linearInterpolation(health[0], targetHp[0], 20 * deltaTime);
    health[1] = linearInterpolation(health[1], targetHp[1], 20 * deltaTime);
    if (health[0] < 0) {
      health[0] = 0;
    }
    if (health[1] < 0) {
      health[1] = 0;
    }
    //mp
    targetMp[0] = player1.mana;
    targetMp[1] = player2.mana;
    mana[0] = linearInterpolation(mana[0], targetMp[0], 20 * deltaTime);
    mana[1] = linearInterpolation(mana[1], targetMp[1], 20 * deltaTime);
    if (health[0] < 0) {
      health[0] = 0;
    }
    if (health[1] < 0) {
      health[1] = 0;
    }

    controlCheck();
    //update the shooter
    shooterList.startLoop();
    while (!shooterList.endOfData()) {
      shooterList.get().update(player1, player2);
      if (shooterList.get().isDead()) {
        shooterList.remove();
      }
      shooterList.forward();
    }
    shooterList.endLoop();
    //move the camera
    moveCamera();
    //end
    if (player1.isDead && player2.isDead) {
      stopMusic();
      gameState = 3;
    }
    int endGoal = map[0].length * TILE_SIZE + 200;
    if (player1.location.x > endGoal && player2.location.x > endGoal) {
      stopMusic();
      gameState = 3;
      victory = true;
    }
    if (player1.isDead && player2.location.x > endGoal) {
      stopMusic();
      gameState = 3;
      victory = true;
    }
    if (player2.isDead && player1.location.x > endGoal) {
      stopMusic();
      gameState = 3;
      victory = true;
    }
  }
  void moveCamera() {
    float camX = 0;
    //find the average of the player location
    if (!player1.isDead && !player2.isDead) {
      camX = (player1.location.x + player2.location.x) / 2;
    } else if (player1.isDead) {
      camX = player2.location.x;
    } else if (player2.isDead) {
      camX = player1.location.x;
    }
    if (camX - c.cameraSize.x / 2 < 0) {
      camX = c.cameraSize.x / 2;
    }
    if (isCameraSizeToggle) {
      cameraSizeToggle += deltaTime;
    }
    cameraX = linearInterpolation(cameraX, camX, 5*deltaTime);
    c.setLocation((int)(cameraX - c.cameraSize.x / 2), (int)(500-c.cameraSize.y / 2));
    c.setSize((int)(1000 * aspectRatio.x - pow(sin(cameraSizeToggle), 2) * 200 * aspectRatio.x), (int)(1000 - pow(sin(cameraSizeToggle), 2) * 200));
  }
  void controlCheck() {
    if (keyHeld[0]) {
      player1.move(true);
    }
    if (keyHeld[1]) {
      player1.move(false);
    }
    if (keyHeld[2]) {
      player2.move(true);
    }
    if (keyHeld[3]) {
      player2.move(false);
    }
    player1.update(shooterList);
    player2.update(shooterList);
  }
  void renderGame() {
    isCameraSizeToggle = false;
    //draw the map
    for (int row=0; row<map.length; row++) {
      for (int col=0; col<map[row].length; col++) {
        int tileType = map[row][col];
        if (tileType != 0 && tileType < 5) {
          c.drawImage(tileArray[tileType-1], col*TILE_SIZE + TILE_SIZE/2, row*TILE_SIZE + TILE_SIZE/2, TILE_SIZE, TILE_SIZE, 0);
          //camera zooms in and out
          if (tileType == 3 && col*TILE_SIZE < c.cameraLocation.x + 700 * aspectRatio.x && col*TILE_SIZE > c.cameraLocation.x + 300 * aspectRatio.x) {
            isCameraSizeToggle = true;
          }
        } else if (tileType != 0) {
          int enemyType = tileType - 5;
          Shooter newShooter = new Shooter(enemyType, col*TILE_SIZE + TILE_SIZE/2, row*TILE_SIZE + TILE_SIZE/2);
          shooterList.add(newShooter);
          map[row][col] = 0;
        }
      }
    }
    //draw the goal
    imageMode(CORNER);
    c.drawImage(goal, map[0].length * TILE_SIZE, 0, 200, 1000, 0);
    imageMode(CENTER);
    //draw the character
    player1.draw(c);
    player2.draw(c);
    //draw the enemy
    shooterRender();

    //draw the start instruction text
    if (!started) {
      drawStartInstruction();
    }
  }
  void shooterRender() {
    shooterList.startLoop();
    while (!shooterList.endOfData()) {
      shooterList.get().draw(c);
      shooterList.forward();
    }
    shooterList.endLoop();
  }
  void drawStartInstruction() {
    fill(0, 200);
    rect(width/2, height/2, width/2, height/2);
    fill(255, 255, 0);
    textSize(100);
    text("PRESS ANY KEY\nTO START", width/2, height/2);
  }
  void drawBackground() {
    int backgroundWidth = width;
    int backgroundHeight = height - 100;
    if (backgroundWidth > backgroundHeight * 2) {
      backgroundHeight = backgroundWidth / 2;
    } else {
      backgroundWidth = backgroundHeight * 2;
    }
    image(background, width / 2, (height - 100) / 2 + 100, backgroundWidth, backgroundHeight);
  }
  void renderMap(float player1Position, float player2Position) {
    //draw the map, should be black
    fill(0);
    rect(width/2, 50, width, 100);
    //draw the player position
    fill(0, 0, 255);
    ellipse(player1Position * width, 33, 20, 20);
    fill(0, 255, 0);
    ellipse(player2Position * width, 66, 20, 20);
  }
  void keyPressed(int keyCode) {
    if (!started) {
      running = true;
      started = true;
    }
    if (running && started) {
      if (keyCode == 87) {
        keyHeld[0] = true;
      } else if (keyCode == 83) {
        keyHeld[1] = true;
      } else if (keyCode == 38) {
        keyHeld[2] = true;
      } else if (keyCode == 40) {
        keyHeld[3] = true;
      }
      //shooting...pow pow
      if (keyCode == 32 && player1.mana >= MANA_COST) {
        player1.shoot();
      }
      if (key == '0' && player2.mana >= MANA_COST) {
        player2.shoot();
      }
    }
  }
  void keyReleased(int keyCode) {
    if (keyCode == 87) {
      keyHeld[0] = false;
    } else if (keyCode == 83) {
      keyHeld[1] = false;
    } else if (keyCode == 38) {
      keyHeld[2] = false;
    } else if (keyCode == 40) {
      keyHeld[3] = false;
    }
  }
  void mousePressed() {
    if (pauseButton.hover()) {
      running = false;
    }
    if(started && !running) {
      if(menuButton.hover()) {
        reset();
        stopMusic();
      }
      if(resumeButton.hover()) {
        running = true;
      }
    }
  }
  void mouseReleased() {
  }
}
