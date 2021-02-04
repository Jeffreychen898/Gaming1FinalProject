class ShooterList {
  //track
  Shooter head;
  //loop execution variable
  Shooter current;
  Shooter last;
  ShooterList() {
    head = null;
    endLoop();
  }
  void add(Shooter shooter) {
    shooter.next = head;
    head = shooter;
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
  Shooter get() {
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
class Shooter {
  boolean inRange;
  ShooterBulletList bulletList;
  float health;
  float targetHealth;
  PVector location;
  int enemyType;
  float angle;
  float visualRange = 1000;
  int maxHP = 300;
  float shootingCooldown;
  int maxShootingCooldown;
  boolean canPierce;
  Shooter next;
  Shooter(int type, int x, int y) {
    inRange = false;
    canPierce = false;
    enemyType = type;
    location = new PVector(x, y);
    health = maxHP;
    targetHealth = maxHP;
    bulletList = new ShooterBulletList();
    if (type == 0) {
      maxShootingCooldown = 5;
    } else if (type == 1) {
      maxShootingCooldown = 5;
    } else {
      maxShootingCooldown = 5;
      canPierce = true;
    }
    shootingCooldown = 0;
  }
  void draw(GameCamera c) {
    //draw the bullets
    bulletList.startLoop();
    while (!bulletList.endOfData()) {
      bulletList.get().draw(c);
      bulletList.forward();
    }
    bulletList.endLoop();
    //draw the shooter
    c.drawImage(shooterArray[enemyType], location.x, location.y, TILE_SIZE, TILE_SIZE, angle);
    //draw the hp bar
    fill(0);
    c.drawRect(location.x, location.y + TILE_SIZE / 2 + 10, TILE_SIZE-8, 12);
    fill(255, 0, 0);
    float hpBarWidth = (TILE_SIZE - 10) / (float)maxHP * health;
    rectMode(CORNER);
    c.drawRect(location.x - (TILE_SIZE - 10) / 2, location.y + TILE_SIZE / 2 + 5, hpBarWidth, 10);
    rectMode(CENTER);
  }
  void update(Player player1, Player player2) {
    bulletList.startLoop();
    while (!bulletList.endOfData()) {
      bulletList.get().update();
      if (bulletList.get().isDead(player1, player2)) {
        bulletList.remove();
      }
      bulletList.forward();
    }
    bulletList.endLoop();
    health = linearInterpolation(health, targetHealth, 40*deltaTime);
    PVector targetLocation = new PVector(location.x+cos(angle), location.y+sin(angle));//points to where it last left off
    float distFromP1 = dist(player1.location.x, player1.location.y, location.x, location.y);
    float distFromP2 = dist(player2.location.x, player2.location.y, location.x, location.y);
    if (!player1.isDead && distFromP1 < visualRange) {
      inRange = true;
    } else if (!player2.isDead && distFromP2 < visualRange) {
      inRange = true;
    } else {
      inRange = false;
    }
    if (player1.isDead) {
      if (!player2.isDead) {
        targetLocation = player2.location.copy();
      }
    } else if (player2.isDead) {
      if (!player1.isDead) {
        targetLocation = player1.location.copy();
      }
    } else {
      if (distFromP1 < distFromP2) {
        targetLocation = player1.location.copy();
      } else {
        targetLocation = player2.location.copy();
      }
    }
    if (dist(targetLocation.x, targetLocation.y, location.x, location.y) < visualRange) {
      angle = atan2(targetLocation.y - location.y, targetLocation.x - location.x);
    }
    if (inRange) {
      if (shootingCooldown < 0) {
        shoot();
        shootingCooldown = maxShootingCooldown;
      } else {
        shootingCooldown -= 10 * deltaTime;
      }
    }
  }
  void shoot() {
    ShooterBullet bullet = new ShooterBullet(location.x, location.y, angle, canPierce, enemyType);
    bulletList.add(bullet);
  }
  void hit(int damage) {
    targetHealth -= damage;
  }
  boolean isDead() {
    return targetHealth <= 0;
  }
}
class ShooterBulletList {
  //tracker
  ShooterBullet head;
  //loop execution tracker
  ShooterBullet current, last;
  ShooterBulletList() {
    head = null;
    endLoop();
  }
  void add(ShooterBullet bullet) {
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
  ShooterBullet get() {
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
class ShooterBullet {
  PVector location;
  PVector initialLocation;
  float angle;
  int speed;
  int damage;
  boolean pierce;
  PImage image;
  ShooterBullet next;
  int range = 800;
  ShooterBullet(float x, float y, float ang, boolean pierce, int imageIndex) {
    location = new PVector(x, y);
    initialLocation = new PVector(x, y);
    angle = ang;
    this.pierce = pierce;
    image = shooterBulletArray[imageIndex];
    if (imageIndex == 0) {
      speed = 200;
      damage = 100;
    } else if (imageIndex == 1) {
      speed = 1000;
      damage = 100;
    } else {
      speed = 400;
      damage = 100;
    }
  }
  void update() {
    location.add(cos(angle) * speed * deltaTime, sin(angle) * speed * deltaTime);
  }
  boolean isDead(Player player1, Player player2) {
    boolean status = false;
    //collision with player
    if (dist(player1.location.x, player1.location.y, location.x, location.y) < 50) {
      player1.hit(damage);
      status = true;
    }
    if (dist(player2.location.x, player2.location.y, location.x, location.y) < 50) {
      player2.hit(damage);
      status = true;
    }
    //out of range
    if (dist(initialLocation.x, initialLocation.y, location.x, location.y) > 800) {
      status = true;
    }
    //collision with wall
    int bulletIndexX = (int)(location.x / TILE_SIZE);
    int bulletIndexY = (int)(location.y / TILE_SIZE);
    if (bulletIndexX > -1 && bulletIndexX < map[0].length && bulletIndexY > -1 && bulletIndexY < map.length && !pierce) {
      if (map[bulletIndexY][bulletIndexX] > 0 && map[bulletIndexY][bulletIndexX] < 5) {
        status = true;
      }
    }
    return status;
  }
  void draw(GameCamera c) {
    c.drawImage(image, location.x, location.y, 30, 30, angle);
  }
}
