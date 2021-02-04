class DeathParticleList {
  //track
  DeathParticle head;
  //loop execution variable
  DeathParticle current;
  DeathParticle last;
  DeathParticleList() {
    head = null;
    endLoop();
  }
  void add(DeathParticle particle) {
    particle.next = head;
    head = particle;
  }
  void startLoop() {
    current = head;
    last = null;
  }
  void endLoop() {
    current = null;
    last = null;
  }
  boolean endOfData() {
    return current == null;
  }
  void forward() {
    last = current;
    current = current.next;
  }
  DeathParticle get() {
    return current;
  }
  void remove() {
    if(last != null) {
      last.next = current.next;
    } else {
      head = current.next;
    }
  }
}
class DeathParticle {
  PVector location;
  PVector velocity;
  float lifeTime;
  DeathParticle next;
  DeathParticle(int x, int y) {
    location = new PVector(x, y);
    velocity = new PVector(getRand(-200, 200), getRand(-600, -300));
    lifeTime = 1;
  }
  void update() {
    lifeTime -= deltaTime;
    velocity.y += 1000 * deltaTime;
    location.add(velocity.copy().mult(deltaTime));
  }
  void render(GameCamera c) {
    tint(255, lifeTime*255);
    c.drawImage(deathParticle, location.x, location.y, 20, 20, 0.0);
    tint(255, 255);
  }
  boolean isDead() {
    return lifeTime < 0;
  }
}
