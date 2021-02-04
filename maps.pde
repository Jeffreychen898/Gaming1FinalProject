int map1Cols = 100;
int[][] map1 = new int[10][map1Cols];
PImage map1Img;

int map2Cols = 130;
int[][] map2 = new int[10][map2Cols];
PImage map2Img;

int map3Cols = 400;
int[][] map3 = new int[10][map3Cols];
PImage map3Img;
void readMap() {
  map1Img = loadImage("Sprites/Level1.png");
  for(int i=0;i<10;i++) {
    for(int j=0;j<map1Cols;j++) {
      color pixelColor = map1Img.get(j, i);
      if(red(pixelColor) == 0 && green(pixelColor) == 0 && blue(pixelColor) == 255) {
        map1[i][j] = 1;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 255 && blue(pixelColor) == 0) {
        map1[i][j] = 2;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 0 && blue(pixelColor) == 0) {
        map1[i][j] = 3;
      } else 
      if(red(pixelColor) == 0 && green(pixelColor) == 255 && blue(pixelColor) == 0) {
        map1[i][j] = 4;
      } else 
      if(red(pixelColor) == 0 && green(pixelColor) == 0 && blue(pixelColor) == 0) {
        map1[i][j] = 5;
      } else 
      if(red(pixelColor) == 100 && green(pixelColor) == 100 && blue(pixelColor) == 100) {
        map1[i][j] = 6;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 255 && blue(pixelColor) == 255) {
        map1[i][j] = 7;
      } else {
        map1[i][j] = 0;
      }
    }
  }
  
  map2Img = loadImage("Sprites/Level2.png");
  for(int i=0;i<10;i++) {
    for(int j=0;j<map2Cols;j++) {
      color pixelColor = map2Img.get(j, i);
      if(red(pixelColor) == 0 && green(pixelColor) == 0 && blue(pixelColor) == 255) {
        map2[i][j] = 1;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 255 && blue(pixelColor) == 0) {
        map2[i][j] = 2;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 0 && blue(pixelColor) == 0) {
        map2[i][j] = 3;
      } else 
      if(red(pixelColor) == 0 && green(pixelColor) == 255 && blue(pixelColor) == 0) {
        map2[i][j] = 4;
      } else 
      if(red(pixelColor) == 0 && green(pixelColor) == 0 && blue(pixelColor) == 0) {
        map2[i][j] = 5;
      } else 
      if(red(pixelColor) == 100 && green(pixelColor) == 100 && blue(pixelColor) == 100) {
        map2[i][j] = 6;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 255 && blue(pixelColor) == 255) {
        map2[i][j] = 7;
      } else {
        map2[i][j] = 0;
      }
    }
  }
  
  map3Img = loadImage("Sprites/Level3.png");
  for(int i=0;i<10;i++) {
    for(int j=0;j<map3Cols;j++) {
      color pixelColor = map3Img.get(j, i);
      if(red(pixelColor) == 0 && green(pixelColor) == 0 && blue(pixelColor) == 255) {
        map3[i][j] = 1;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 255 && blue(pixelColor) == 0) {
        map3[i][j] = 2;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 0 && blue(pixelColor) == 0) {
        map3[i][j] = 3;
      } else 
      if(red(pixelColor) == 0 && green(pixelColor) == 255 && blue(pixelColor) == 0) {
        map3[i][j] = 4;
      } else 
      if(red(pixelColor) == 0 && green(pixelColor) == 0 && blue(pixelColor) == 0) {
        map3[i][j] = 5;
      } else 
      if(red(pixelColor) == 100 && green(pixelColor) == 100 && blue(pixelColor) == 100) {
        map3[i][j] = 6;
      } else 
      if(red(pixelColor) == 255 && green(pixelColor) == 255 && blue(pixelColor) == 255) {
        map3[i][j] = 7;
      } else {
        map3[i][j] = 0;
      }
    }
  }
}
