//Bullet(float x, float y, PVector direction, color c, int s, String t)

class RegBullet extends Bullet {
  RegBullet(PVector _d, color fill, int size, String type) {
    super(myHero.loc.x, myHero.loc.y, _d, fill, size, type);
  }
}

class EnemyBullet extends Bullet {
  EnemyBullet(float x, float y, PVector _d, color fill, int size, String type) {
    super(x, y, _d, fill, size, type);
  }
  
  void act() {
    super.act();
  }
}
