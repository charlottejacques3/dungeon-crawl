class Message extends GameObject {
  
  String message;
  int disappearTimer, disappearThreshold;
  
  Message(String m, float x, float y) {
    message = m;
    loc = new PVector(x, y);
    disappearTimer = 0;
    disappearThreshold = 50;
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
  }
  
  void show() {
    textAlign(CENTER, CENTER);
    textSize(30);
    fill(white, 255-disappearTimer*5);
    text(message, loc.x, loc.y);
  }
  
  void act() {
    loc.y--;
    disappearTimer++;
    if (disappearTimer >= disappearThreshold) hp = 0;
    
  }
}
