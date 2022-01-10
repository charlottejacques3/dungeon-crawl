class RadioWave extends GameObject {

  String message;
  Hacker myHacker;

  RadioWave(float x, float y, int rx, int ry, Hacker h) {
    loc = new PVector(x, y);
    size = 75;
    hp = 1;
    roomX = rx;
    roomY = ry;
    myHacker = h;
  }

  void show() {
    stroke(white);
    noFill();
    circle(loc.x, loc.y, size);
  }

  void act() {
    size+=3;
    if (myHacker.hackerRange < size) myHacker.hackerRange = size;

    //disappear when going off the screen
    if (size > 495) {
      hp = 0;
      myHacker.hackerRange-=30; //hacking range is now the size of the next biggest circle
    }
  }
}
