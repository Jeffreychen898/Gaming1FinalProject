PImage background, buttonBanner;
PImage title;
PImage tiles, shooters, player1, player2;
PImage[] tileArray = new PImage[4];
PImage[] shooterArray = new PImage[3];
PImage fireParticle, deathParticle;
PImage playerBullet, shooterBullet;
PImage[] shooterBulletArray = new PImage[3];
PImage goal;
PImage OverviewTab, GoalTab, HpTab, DeathTab, ControlTab;

AudioPlayer menuMusic;
AudioPlayer winMusic;
AudioPlayer loseMusic;
AudioPlayer levelSelectionMusic;
AudioPlayer instructionMusic;
AudioPlayer gameMusic;
AudioPlayer creditMusic;
void loadImages() {
  background = loadImage("Sprites/GameBackground.png");
  buttonBanner = loadImage("Sprites/ButtonBanner.png");
  title = loadImage("Sprites/GameTitle.png");
  tiles = loadImage("Sprites/Tiles.png");
  for (int i=0; i<4; i++) {
    tileArray[i] = tiles.get(i*16, 0, 16, 16);
  }
  player1 = loadImage("Sprites/player1.png");
  player2 = loadImage("Sprites/player2.png");
  shooters = loadImage("Sprites/Shooters.png");
  for (int i=0; i<3; i++) {
    shooterArray[i] = shooters.get(i*16, 0, 16, 16);
  }
  fireParticle = loadImage("Sprites/FireParticle.png");
  deathParticle = loadImage("Sprites/DeathParticle.png");
  playerBullet = loadImage("Sprites/PlayerBullet.png");
  shooterBullet = loadImage("Sprites/ShooterBullet.png");
  for (int i=0; i<3; i++) {
    shooterBulletArray[i] = shooterBullet.get(i*8, 0, 8, 8);
  }
  goal = loadImage("Sprites/goal.png");
  OverviewTab = loadImage("Sprites/OverviewTab.png");
  GoalTab = loadImage("Sprites/GoalTab.png");
  HpTab = loadImage("Sprites/HpTab.png");
  DeathTab = loadImage("Sprites/DeathTab.png");
  ControlTab = loadImage("Sprites/ControlTab.png");
}
void loadAudio() {
  menuMusic = minim.loadFile("Audio/MenuMusic.wav");
  winMusic = minim.loadFile("Audio/WinMusic.wav");
  loseMusic = minim.loadFile("Audio/LoseMusic.wav");
  levelSelectionMusic = minim.loadFile("Audio/LevelSelectionMusic.wav");
  instructionMusic = minim.loadFile("Audio/InstructionMusic.wav");
  gameMusic = minim.loadFile("Audio/GameMusic.wav");
  creditMusic = minim.loadFile("Audio/CreditMusic.wav");
}
void loadAssets() {
  readMap();
  loadImages();
  loadAudio();
}
