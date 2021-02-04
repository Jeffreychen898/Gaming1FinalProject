int PLAYER_HEALTH = 1000;
int HP_REGEN = 100;
int MP_REGEN = 10;
int PLAYER_MANA = 100;
int MANA_COST = 10;
class Player {
  float health;
  float mana;
  PVector location;
  float angle;
  int whichPlayer;
  int playerSpeed;
  FlameParticleList flameParticleList;
  float spawnFlameParticleCooldown = 1;
  float flameParticleCooldown = 0;
  boolean isDead;
  DeathParticleList deathParticleList;
  PlayerBulletList playerBulletList;
  Player(int whichPlayer, int x, int y, float ang) {
    angle = ang;
    location = new PVector(x, y);
    this.whichPlayer = whichPlayer;
    playerSpeed = 200;
    flameParticleList = new FlameParticleList();
    isDead = false;
    deathParticleList = new DeathParticleList();
    playerBulletList = new PlayerBulletList();
    health = PLAYER_HEALTH;
    mana = PLAYER_MANA;
  }
  void draw(GameCamera c) {
    //draw the flame particle
    flameParticleList.startLoop();
    while (!flameParticleList.endOfData()) {
      flameParticleList.get().render(c);
      flameParticleList.forward();
    }
    flameParticleList.endLoop();
    //draw the bullets
    playerBulletList.startLoop();
    while (!playerBulletList.endOfData()) {
      playerBulletList.get().render(c);
      playerBulletList.forward();
    }
    playerBulletList.endLoop();
    //draw the player
    if (!isDead) {
      PImage image;
      if (whichPlayer == 1) {
        image = player1;
      } else {
        image = player2;
      }
      c.drawImage(image, location.x, location.y, 100, 50, angle);
      //player collision detection
      collisionDetection();
    }
    //draw death particle
    deathParticleList.startLoop();
    while (!deathParticleList.endOfData()) {
      deathParticleList.get().render(c);
      deathParticleList.forward();
    }
    deathParticleList.endLoop();
    //player gets out of camera
    boolean playerInCamera = location.x > c.cameraLocation.x && location.x < c.cameraLocation.x + c.cameraSize.x && location.y > c.cameraLocation.y && location.y < c.cameraLocation.y + c.cameraSize.y;
    if (!playerInCamera) {
      playerDied();
    }
  }
  void playerDied() {
    if (!isDead) {
      isDead = true;
      //draw those particles
      for (int i=0; i<10; i++) {
        DeathParticle newDeathParticle = new DeathParticle((int)location.x, (int)location.y);
        deathParticleList.add(newDeathParticle);
      }
      health = 0;
    }
  }
  void collisionDetection() {
    //find out what tile the player is on
    int tileX = (int)(location.x / TILE_SIZE);
    int tileY = (int)(location.y / TILE_SIZE);
    if (tileX > -1 && tileX < map[0].length && tileY > -1 && tileY < map.length) {
      int whichTile = map[tileY][tileX];
      if (whichTile > 0 && whichTile < 5) {
        playerDied();
      }
    }
    //player loses all health
    if (health <= 0) {
      playerDied();
    }
  }
  void move(boolean moveUp) {
    if (!isDead) {
      if (moveUp) {
        angle -= 5 * deltaTime;
      } else {
        angle += 5 * deltaTime;
      }
    }
  }
  void update(ShooterList shooterList) {
    if (!isDead) {
      health += HP_REGEN * deltaTime;
    }
    mana += MP_REGEN * deltaTime;
    if (health > PLAYER_HEALTH) {
      health = PLAYER_HEALTH;
    }
    if (mana > PLAYER_MANA) {
      mana = PLAYER_MANA;
    }
    if (!isDead) {
      addFlameParticle();
      location.add(cos(angle)*playerSpeed*deltaTime, sin(angle)*playerSpeed*deltaTime);
    }
    updateFlameParticle();
    updateBullets(shooterList);
    updateDeathParticle();
  }
  void updateBullets(ShooterList shooterList) {
    playerBulletList.startLoop();
    while (!playerBulletList.endOfData()) {
      playerBulletList.get().update();
      if (playerBulletList.get().isDead(shooterList)) {
        playerBulletList.remove();
      }
      playerBulletList.forward();
    }
    playerBulletList.endLoop();
  }
  void updateDeathParticle() {
    deathParticleList.startLoop();
    while (!deathParticleList.endOfData()) {
      deathParticleList.get().update();
      if (deathParticleList.get().isDead()) {
        deathParticleList.remove();
      }
      deathParticleList.forward();
    }
    deathParticleList.endLoop();
  }
  void updateFlameParticle() {
    flameParticleList.startLoop();
    while (!flameParticleList.endOfData()) {
      flameParticleList.get().update();
      if (flameParticleList.get().isDead()) {
        flameParticleList.remove();
      }
      flameParticleList.forward();
    }
    flameParticleList.endLoop();
  }
  void addFlameParticle() {
    if (flameParticleCooldown < 0) {
      FlameParticle particle = new FlameParticle((int)(location.x+cos(PI-angle)*50), (int)(location.y-sin(PI-angle)*50), PI-angle);
      flameParticleList.add(particle);
      flameParticleCooldown += spawnFlameParticleCooldown;
    } else {
      flameParticleCooldown -= 100*deltaTime;
    }
  }
  void shoot() {
    PlayerBullet newBullet = new PlayerBullet((int)(location.x+cos(angle)*50), (int)(location.y+sin(angle)*50), angle);
    playerBulletList.add(newBullet);
    mana -= MANA_COST;
  }
  void hit(int hpLost) {
    health -= hpLost;
  }
  float getHp() {
    return health;
  }
}

class PlayerBulletList {
  //track
  PlayerBullet head;
  //loop execution variable
  PlayerBullet current;
  PlayerBullet last;
  PlayerBulletList() {
    head = null;
    endLoop();
  }
  void add(PlayerBullet bullet) {
    bullet.next = head;
    head = bullet;
  }
  void startLoop() {
    current = head;
    last = null;
  }
  void endLoop() {
    current = null;
    last = null;
  }
  void forward() {
    last = current;
    current = current.next;
  }
  PlayerBullet get() {
    return current;
  }
  void remove() {
    if (last != null) {
      last.next = current.next;
    } else {
      head = current.next;
    }
  }
  boolean endOfData() {
    return current == null;
  }
}
class PlayerBullet {
  int damage = 50;
  int playerSpeed = 1000;
  int range = 800;
  PVector location;
  PVector initialLocation;
  float angle;
  PlayerBullet next;
  PlayerBullet(int x, int y, float ang) {
    location = new PVector(x, y);
    initialLocation = new PVector(x, y);
    angle = ang;
  }
  void update() {
    location.add(cos(angle) * playerSpeed * deltaTime, sin(angle) * playerSpeed * deltaTime);
  }
  void render(GameCamera c) {
    c.drawImage(playerBullet, location.x, location.y, 40, 20, angle);
  }
  boolean isDead(ShooterList shooterList) {
    boolean status = false;
    //out of range
    if (dist(initialLocation.x, initialLocation.y, location.x, location.y) > range) {
      status = true;
    }
    //collision with wall
    int bulletIndexX = (int)(location.x / TILE_SIZE);
    int bulletIndexY = (int)(location.y / TILE_SIZE);
    if (bulletIndexX > -1 && bulletIndexX < map[0].length && bulletIndexY > -1 && bulletIndexY < map.length) {
      if (map[bulletIndexY][bulletIndexX] > 0 && map[bulletIndexY][bulletIndexX] < 5) {
        status = true;
      }
    }
    //collision with shooter
    shooterList.startLoop();
    while (!shooterList.endOfData()) {
      Shooter thisShooter = shooterList.get();
      if (dist(location.x, location.y, thisShooter.location.x, thisShooter.location.y) < TILE_SIZE / 2) {
        status = true;
        thisShooter.hit(damage);
      }
      shooterList.forward();
    }
    shooterList.endLoop();
    return status;
  }
}

class FlameParticleList {
  //track
  FlameParticle head;
  //loop execution variable
  FlameParticle current;
  FlameParticle last;
  FlameParticleList() {
    head = null;
    endLoop();
  }
  void add(FlameParticle particle) {
    particle.next = head;
    head = particle;
  }
  void startLoop() {
    current = head;
    last = null;
  }
  boolean endOfData() {
    return current == null;
  }
  void endLoop() {
    current = null;
    last = null;
  }
  void forward() {
    last = current;
    current = current.next;
  }
  FlameParticle get() {
    return current;
  }
  void remove() {
    if (last != null) {
      last.next = current.next;
    } else {
      head = current.next;
    }
  }
}
class FlameParticle {
  PVector location;
  float direction;
  float lifeTime = 1;
  FlameParticle next;
  FlameParticle(int x, int y, float ang) {
    location = new PVector(x, y);
    direction = ang + getRand(-1, 1) * (PI/4);
  }
  void update() {
    location.add(cos(direction)*100*deltaTime, -sin(direction)*100*deltaTime);
    lifeTime -= deltaTime;
  }
  void render(GameCamera c) {
    tint(255, lifeTime*255);
    c.drawImage(fireParticle, location.x, location.y, 20, 20, 0);
    tint(255, 255);
  }
  boolean isDead() {
    return lifeTime < 0;
  }
}
