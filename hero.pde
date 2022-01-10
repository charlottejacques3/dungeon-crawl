class Hero extends GameObject { //<>//

  float speed;
  Weapon myWeapon;
  int immunThreshold, immunTimer, ammo, t;
  Gif currentAction;

  Hero() {
    super();
    size = 50;
    speed = 5;
    roomX = 1;
    roomY = 1;
    myWeapon = new Weapon();
    immunThreshold = 100;
    immunTimer = 0;
    hp = hpMax = 5;
    currentAction = heroDown;
    ammo = 100;
    xp = 0;
    t = 200;
  }

  void show() {
    //show immunity
    if (immunTimer < immunThreshold) {
      noStroke();
      t-=2;
      fill(lightBlue, t);
      circle(loc.x, loc.y, 100);
    }

    currentAction.show(loc.x, loc.y, size/1.5, size);
  }

  void act() {
    super.act();
    immunTimer++;

    //move with keyboard
    if (downKey) {
      v.y = speed;
      currentAction = heroDown;
    }
    if (upKey) {
      v.y = -speed;
      currentAction = heroUp;
    }
    if (rightKey) {
      v.x = speed;
      currentAction = heroRight;
    }
    if (leftKey) {
      v.x = -speed;
      currentAction = heroLeft;
    }

    if (!upKey && !downKey && !leftKey && !rightKey) v.mult(0.75); //slow down
    if (v.mag() > 8) v.setMag(8); //limit speed

    //move rooms
    //north
    if (north != mapBkgd && loc.y == 52.5 && loc.x >= width/2-50 && loc.x <= width/2+50) {
      roomY--;
      cleanUp();
      loc = new PVector(width/2, height-52.5);
    }
    //east
    else if (east != mapBkgd && loc.x == width-70 && loc.y >= height/2-50 && loc.y <= height/2+50) {
      roomX++;
      cleanUp();
      loc = new PVector(70, height/2);
    }
    //south
    else if (south != mapBkgd && loc.y == height-52.5 && loc.x >= width/2-50 && loc.x <= width/2+50) {
      roomY++;
      cleanUp();
      loc = new PVector(width/2, 52.5);
    }
    //west
    else if (west != mapBkgd && loc.x == 70 && loc.y >= height/2-50 && loc.y <= height/2+50) {
      roomX--;
      cleanUp();
      loc = new PVector(width-70, height/2);
    }

    //shoot weapon
    tint(255);
    myWeapon.update();
    if (spaceKey && ammo > 0) myWeapon.shoot();

    //loop through objects
    int i = 0;
    while (i < myObjects.size()) {
      GameObject o = myObjects.get(i);

      //make hero die when shot by enemy bullets
      if (o instanceof EnemyBullet && colliding(o) && immunTimer >= immunThreshold && inRoom(o)) {
        hp--;
        o.hp = 0;
        immunTimer = 0;
        myHero.t = 200;
      }

      //make hero pick up dropped item
      if (o instanceof DroppedItem && colliding(o) && inRoom(o)) {
        DroppedItem item = (DroppedItem) o;
        item.hp = 0;
        if (item.type == AMMO) ammo+= 5;
        else if (item.type == HEALTH && hp < hpMax) hp++;
        else if (item.type == GUN) myWeapon = item.w;
      }
      i++;
    }
  }
  
  void cleanUp() {
    for (int i = 0; i < myObjects.size(); i++) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Bullet || obj instanceof Message) {
        myObjects.remove(i);
        i--;
      }
    }
  }
}
