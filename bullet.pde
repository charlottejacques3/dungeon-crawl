class Bullet extends GameObject {

  String type;

  Bullet(float x, float y, PVector direction, color c, int s, String t) {
    hp = 1;
    size = s;
    fill = c;
    v = direction;
    loc = new PVector(x, y);
    type = t;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
  }

  void show() {
    if (type == "normal") {
      fill(fill);
      noStroke();
      circle(loc.x, loc.y, size);
    } else if (type == "finger gun") {
      image(fingerGun, loc.x, loc.y, size, size);
    } else if (type == "fireball") {
      image(fireball, loc.x, loc.y, size, size);
    }
  }

  void act() {
    super.act();
    
    //disappear when going off the screen
    if (loc.x <= 70 || loc.x >= width-70 || loc.y <= 52.5 || loc.y >= height-52.5) hp = 0;
  }
}
