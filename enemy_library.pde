//super(roomX, roomY, locationX, locationY, die by touching?, image, xp);

class Follower extends Enemy {

  Follower(int roomX, int roomY, float x, float y) {
    super(roomX, roomY, x, y, true, follower, 5);
  }

  void act() {
    super.act();
    v = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    v.setMag(3);
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class ShooterCowboy extends Enemy {

  int shotTimer, shotThreshold;

  ShooterCowboy(int roomX, int roomY, float x, float y) {
    super(roomX, roomY, x, y, false, shooter, 10);
    shotTimer = 0;
    shotThreshold = 10;
  }

  void act() {
    super.act();
    shotTimer++;
    PVector aimShooterBullet = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
    aimShooterBullet.setMag(20);

    //shoot bullet
    if (shotTimer >= shotThreshold) {
      myObjects.add(new EnemyBullet(loc.x, loc.y, aimShooterBullet, red, 5, "normal"));
      shotTimer = 0;
    }
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Creator extends Enemy {

  int spawnTimer, spawnThreshold;

  Creator(int roomX, int roomY, float x, float y) {
    super(roomX, roomY, x, y, false, creator, 10);
    spawnTimer = 0;
    spawnThreshold = 60;
  }

  void act() {
    super.act();
    spawnTimer++;

    //spawn followers
    if (spawnTimer >= spawnThreshold) {
      myObjects.add(new Follower(roomX, roomY, loc.x, loc.y));
      numEnemies++;
      spawnTimer = 0;
    }
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Magician extends Enemy {

  int appearTimer, appearThreshold;
  
  Magician(int roomX, int roomY) {
    super(roomX, roomY, random(70, width-70), random(52.5, height-52.5), true, magician, 5);
    appearTimer = 0;
    appearThreshold = int(random(15, 200));
  }

  void show() {
    if (appearTimer >= appearThreshold) super.show();
  }


  void act() {
    super.act();
    appearTimer++;
    
    //make it not drop in range of hero
    if (dist(loc.x, loc.y, myHero.loc.x, myHero.loc.y) < 100 && appearTimer < appearThreshold) loc = new PVector(random(70, width-70), random(52.5, height-52.5));
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Giant extends Enemy {

  int increaseRate;

  Giant(int roomX, int roomY, float x, float y, int ir) {
    super(roomX, roomY, x, y, true, giant, 5);
    increaseRate = ir;
  }

  void act() {
    super.act();
    size += increaseRate;
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class Hacker extends Enemy {

  int signalTimer, signalThreshold, hackTimer, hackThreshold, hackedItem, hackerRange;

  Hacker(int roomX, int roomY, float x, float y) {
    super(roomX, roomY, x, y, false, hacker, 5);
    signalTimer = 20;
    signalThreshold = 20;
    hackTimer = 0;
    hackThreshold = 50;
    hackedItem = 0; //int(random(0, 2)); //lives = 0; xp = 1
    hackerRange = 75;
  }

  void show() {
    super.show();
    signalTimer++;

    //show radio signals
    if (signalTimer >= signalThreshold) {
      myObjects.add(new RadioWave(loc.x, loc.y, roomX, roomY, this));
      signalTimer = 0;
    }
  }

  void act() {
    super.act();

    //make it hack
    if (dist(loc.x, loc.y, myHero.loc.x, myHero.loc.y) <= hackerRange/2) {
      fill(red);
      text("you've been hacked!", myHero.loc.x, myHero.loc.y+50);
      hackTimer++;
      if (hackTimer >= hackThreshold) {
        if (hackedItem == 0) {
          myObjects.add(new Message("lives - 1", loc.x, loc.y));
          myHero.hp--;
        } else if (hackedItem == 1) {
          myObjects.add(new Message("xp - 1", loc.x, loc.y));
          if (myHero.xp >= 1) myHero.xp--;
        }
        hackTimer = 0;
        hackedItem = int(random(0, 2));
      }
    }

    //get rid of excess radio waves
    if (hp <= 0) {
      int i = 0;
      while (i < myObjects.size()) {
        GameObject o = myObjects.get(i);
        if (o instanceof RadioWave) o.hp = 0;
        i++;
      }
    }
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

class DungeonMaster extends Enemy {

  int moveTimer, moveThreshold, shotTimer, shotThreshold;

  DungeonMaster(int roomX, int roomY) {
    super(roomX, roomY, width/2, height/2, false, dungeonMaster, 30);
    size = 150;
    moveTimer = 0;
    moveThreshold = 10;
    shotTimer = 0;
  }

  void act() {
    super.act();
    shotTimer++;
    PVector aimShooterBullet = new PVector(myHero.loc.x - loc.x, myHero.loc.y - loc.y);
    aimShooterBullet.setMag(20);
    
    //decide on shot threshold based on how many enemies were killed
    if (level == 1) {
      if (numEnemies <= 0) shotThreshold = 2800;
      else shotThreshold = 2800/numEnemies;
    } else if (level == 2) {
      if (numEnemies <= 0) shotThreshold = 1400;
      else shotThreshold = 1400/numEnemies;
    } 
    
    //win game
    if (hp <= 0) numEnemies = 0;

    //when to dodge bullets
    if (moveTimer == 0) {
      int i = 0;
      while (i < myObjects.size()) {
        GameObject o = myObjects.get(i);
        if (o instanceof RegBullet) {
          if (dist(loc.x, loc.y, o.loc.x, o.loc.y) < 300) {
            moveTimer = moveThreshold;
          }
        }
        i++;
      }
    }

    //dodge bullets
    if (moveTimer > 0) {
      if (moveTimer == moveThreshold) {
        v = new PVector(random(-100, 100), random(-100, 100));
        v.setMag(50);
      }
      moveTimer--;
    } else {
      v = new PVector(0, 0);
      moveTimer = 0;
    }

    //shoot fireballs
    if (shotTimer >= shotThreshold) {
      myObjects.add(new EnemyBullet(loc.x, loc.y, aimShooterBullet, red, 80, "fireball"));
      shotTimer = 0;
    }
  }
}
