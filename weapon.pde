class Weapon {

  int shotTimer, shotThreshold, bulletSpeed, bulletSize;
  String bulletType;
  color bulletColour;

  //default weapon
  Weapon() {
    shotTimer = 0;
    shotThreshold = 8;
    bulletSpeed = 30;
    bulletSize = 5;
    bulletType = "normal";
    bulletColour = gold;
    
  }

  //custom weapon
  Weapon(int thr, int bsp, int bsi, String type, color fill) {
    shotTimer = 0;
    shotThreshold = thr;
    bulletSpeed = bsp;
    bulletSize = bsi;
    bulletType = type;
    bulletColour = fill;
  }

  void update() {
    shotTimer++;
  }

  void shoot() {
    if (shotTimer >= shotThreshold) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      noStroke();
      myObjects.add(new RegBullet(aimVector, bulletColour, bulletSize, bulletType));
      shotTimer = 0;
      myHero.ammo--;
    }
  }
}
