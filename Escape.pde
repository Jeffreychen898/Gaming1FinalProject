import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
float deltaTime = 0;
int gameState = 0;//0:menu 1:levelSelection 2:play 3:end 4:instruction 5:credits
boolean victory = false;
//state classes
Menu menuState;
LevelSelection levelSelectionState;
Game theGameState;
End endState;
Instruction instructionState;
Credit creditState;

//map
int[][] map;

void setup() {
  fullScreen(P2D);
  minim = new Minim(this);
  ((PGraphicsOpenGL)g).textureSampling(3);
  frameRate(60);
  loadAssets();
  reset();
}
void reset() {
  gameState = 0;
  menuState = new Menu();
  levelSelectionState = new LevelSelection();
  theGameState = new Game();
  endState = new End();
  instructionState = new Instruction();
  creditState = new Credit();
  victory = false;
}
void stopMusic() {
  menuMusic.pause();
  winMusic.pause();
  loseMusic.pause();
  levelSelectionMusic.pause();
  instructionMusic.pause();
  gameMusic.pause();
  creditMusic.pause();
  menuMusic.rewind();
  winMusic.rewind();
  loseMusic.rewind();
  levelSelectionMusic.rewind();
  instructionMusic.rewind();
  gameMusic.rewind();
  creditMusic.rewind();
}
void musicHandler() {
  if (gameState == 0) {
    if (!menuMusic.isPlaying()) {
      menuMusic.rewind();
      menuMusic.play();
    }
  } else if (gameState == 1) {
    if (!levelSelectionMusic.isPlaying()) {
      levelSelectionMusic.rewind();
      levelSelectionMusic.play();
    }
  } else if (gameState == 2) {
    if (!gameMusic.isPlaying()) {
      gameMusic.rewind();
      gameMusic.play();
    }
  } else if (gameState == 3) {
    if (victory) {
      if (!winMusic.isPlaying()) {
        winMusic.rewind();
        winMusic.play();
      }
    } else {
      if (!loseMusic.isPlaying()) {
        loseMusic.rewind();
        loseMusic.play();
      }
    }
  } else if (gameState == 4) {
    if (!instructionMusic.isPlaying()) {
      instructionMusic.rewind();
      instructionMusic.play();
    }
  } else if (gameState == 5) {
    if (!creditMusic.isPlaying()) {
      creditMusic.rewind();
      creditMusic.play();
    }
  }
}
void draw() {
  musicHandler();
  println(frameRate);
  deltaTime = 1.0 / frameRate;
  noStroke();
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(12);
  background(0);
  if (gameState == 0) {
    menuState.update();
  } else if (gameState == 1) {
    levelSelectionState.update();
  } else if (gameState == 2) {
    theGameState.update();
  } else if (gameState == 3) {
    endState.update();
  } else if (gameState == 4) {
    instructionState.update();
  } else if (gameState == 5) {
    creditState.update();
  }
}
void keyPressed() {
  if (gameState == 0) {
    menuState.keyPressed(keyCode);
  } else if (gameState == 1) {
    levelSelectionState.keyPressed(keyCode);
  } else if (gameState == 2) {
    theGameState.keyPressed(keyCode);
  } else if (gameState == 3) {
    endState.keyPressed(keyCode);
  } else if (gameState == 4) {
    instructionState.keyPressed(keyCode);
  } else if (gameState == 5) {
    creditState.keyPressed(keyCode);
  }
}
void keyReleased() {
  if (gameState == 0) {
    menuState.keyReleased(keyCode);
  } else if (gameState == 1) {
    levelSelectionState.keyReleased(keyCode);
  } else if (gameState == 2) {
    theGameState.keyReleased(keyCode);
  } else if (gameState == 3) {
    endState.keyReleased(keyCode);
  } else if (gameState == 4) {
    instructionState.keyReleased(keyCode);
  } else if (gameState == 5) {
    creditState.keyReleased(keyCode);
  }
}
void mousePressed() {
  if (gameState == 0) {
    menuState.mousePressed();
  } else if (gameState == 1) {
    levelSelectionState.mousePressed();
  } else if (gameState == 2) {
    theGameState.mousePressed();
  } else if (gameState == 3) {
    endState.mousePressed();
  } else if (gameState == 4) {
    instructionState.mousePressed();
  } else if (gameState == 5) {
    creditState.mousePressed();
  }
}
void mouseReleased() {
  if (gameState == 0) {
    menuState.mouseReleased();
  } else if (gameState == 1) {
    levelSelectionState.mouseReleased();
  } else if (gameState == 2) {
    theGameState.mouseReleased();
  } else if (gameState == 3) {
    endState.mouseReleased();
  } else if (gameState == 4) {
    instructionState.mouseReleased();
  } else if (gameState == 5) {
    creditState.mouseReleased();
  }
}
float linearInterpolation(float position, float goal, float amount) {
  return position + amount * (goal - position);
}
