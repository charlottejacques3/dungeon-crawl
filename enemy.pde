class Enemy extends GameObject {

  boolean rangeEnemy;
  float willItDrop;
  PImage img;

  Enemy() {
    loc = new PVector(width/2, height/2);
    v = new PVector(0, 0);
    hp = 100;
    roomX = 1;
    roomY = 1;
    size = 75;
    rangeEnemy = true;
    willItDrop = random(0, 10);
    img = giant;
    xp = 1;
  }

  Enemy(int xRoom, int yRoom, float lx, float ly, boolean re, PImage _img, int _xp) {
    loc = new PVector(lx, ly);
    v = new PVector(0, 0);
    roomX = xRoom;
    roomY = yRoom;
    hp = 100;
    size = 75;
    rangeEnemy = re;
    img = _img;
    xp = _xp;
    willItDrop = random(0, 10);
  }

  void show() {
    image(img, loc.x, loc.y, size, size);
    
    //health bar background
    rectMode(CORNER);
    strokeWeight(2);
    stroke(gold);
    fill(black);
    rect(loc.x-50, loc.y - size/1.5, 100, 10);
    
    //health bar
    noStroke();
    fill(green);
    rect(loc.x-50, loc.y + 1 - size/1.5, hp, 8);
    
    rectMode(CENTER);
  }

  void act() {
    super.act();
    
    //be fully in the dungeon
    if (loc.x <= 70+size/2) loc.x = 70+size/2;
    if (loc.x >= width-70-size/2) loc.x = width-70-size/2;
    if (loc.y <= 52.5+size/2) loc.y = 52.5+size/2;
    if (loc.y >= height-52.5-size/2) loc.y = height-52.5-size/2;

    //check for bullets
    int i = 0;
    while (i < myObjects.size()) {
      GameObject o = myObjects.get(i);

      //make the enemy lose lives when shot by bullet
      if (o instanceof RegBullet && colliding(o) && inRoom(o)) {
        hp-= (o.v.mag()*o.size)/20;
        o.hp = 0;
        if (hp <= 0) {
          if (willItDrop >= 4) myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY));
          myHero.xp += xp;
          myObjects.add(new Message("+" + xp, loc.x, loc.y));
          numEnemies--;
        }
      }

      //make the hero lose lives when in range of enemy
      if (o instanceof Hero && rangeEnemy && colliding(o) && myHero.immunTimer >= myHero.immunThreshold && inRoom(o)) {
        myHero.hp --;
        myHero.immunTimer = 0;
        myHero.t = 200;
      }
      i++;
    }
  }
}
