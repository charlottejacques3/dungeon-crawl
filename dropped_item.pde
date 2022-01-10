class DroppedItem extends GameObject {

  int type; //ammo = 0; health = 1; gun = 2;
  int wType; //power gun = 0; finger gun = 1; bomb = 2;
  Weapon w;
  int itemTimer, itemThreshold;

  DroppedItem(float x, float y, int rx, int ry) {

    //deciding the type of dropped item
    type = int(random(0, 3));
    wType = int(random(0, 3));
    if (wType == 0) w = new PowerGun();
    else if (wType == 1) w = new FingerGun();
    else if (wType == 2) w = new Bomb();

    //other instance variables
    hp = 1;
    loc = new PVector(x, y);
    v = new PVector(0, 0);
    size = 30;
    roomX = rx;
    roomY = ry;
    itemTimer = 0;
    itemThreshold = 250;
  }

  void show() {

    stroke(black);
    strokeWeight(2);

    if (type == AMMO) ammo.show(loc.x, loc.y, 50, 29); //ammo
    else if (type == HEALTH) redCross.show(loc.x, loc.y, 27, 29 ); //health
    else if (type == GUN) rifle.show(loc.x, loc.y, 70, 18); //gun
    else println("error: dropped item type is invalid");
  }

  void act() {

    //disappear after a certain amount of time
    itemTimer++;
    if (itemTimer >= itemThreshold) hp = 0;
  }
}
