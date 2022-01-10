class Darkness {
  
  float x, y, size, t;
  
  Darkness(float _x, float _y, float s) {
    size = s;
    x = _x;
    y = _y;
    t = 0;
  }
  
  void show() {
    t = map(dist(x, y, myHero.loc.x, myHero.loc.y), 0, 300, 0, 255);
    fill(0, t);
    noStroke();
    square(x, y, size);
  }
}
