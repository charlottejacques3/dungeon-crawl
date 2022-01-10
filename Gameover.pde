void gameover() {
  tint(100);
  image(ground, width/2, height/2, width, height);
  fill(gold);
  textFont(font);

  //if lost
  if (myHero.hp <= 0) {
    text("y o u   l o s e", width/2, height/2-75);
    textSize(20);
    text("c l i c k   t o   t r y   a g a i n", width/2, height/2+50);
    text("i f   y o u   d a r e", width/2, height/2+100);
    if (mouseReleased) {
      fullReset();
      partReset();
    }
  }

  //if won level 1
  if (numEnemies <= 0 && level == 1) {
    text("y o u   b e a t   l e v e l   1", width/2, height/2-75);
    textSize(20);
    text("c l i c k   t o   c o n t i n u e", width/2, height/2+50);
    text("i f   y o u   d a r e", width/2, height/2+100);
    if (mouseReleased) {
      level++;
      currentMap = map2;
      currentColourMap = colourMap2;
      partReset();
    }
  }


  //if won level 2 
  if (numEnemies <= 0 && level == 2) {
    text("y o u   b e a t   t h e  g a m e", width/2, height/2-75);
    textSize(20);
    text("c o n g r a t u l a t i o n s", width/2, height/2+50);
    if (mouseReleased) {
      level--;
      currentMap = map1;
      currentColourMap = colourMap1;
      fullReset();
      partReset();
    }
  }
}

void partReset() {
  int i = 0;
  while (i < myObjects.size()) {
    myObjects.remove(i);
  }
  mode = GAME;
  myObjects.add(myHero);
  myHero.hp = 5;
  myHero.ammo = 100;
  myHero.roomX = 1;
  myHero.roomY = 1;
  myHero.loc = new PVector(width/2, height/2);
  myHero.currentAction = heroDown;
  loadEnemies();
  myHero.immunTimer = 1;
}

void fullReset() {
  myHero.xp = 0;
  myHero.myWeapon = new Weapon();
  myHero.speed = 5;
  myHero.hpMax = 5;
  myHero.myWeapon.bulletSpeed = 30;
}
