void game() { //<>//

  //set up game
  drawRoom();
  drawObjects();

  //show darkness
  int d = 0;
  while (d < darkness.size()) {
    darkness.get(d).show();
    d++;
  }

  //mini map
  tint(255);
  image(scroll, 125, 100, 200, 150);
  tint(100);
  miniMap();
  rectMode(CENTER);

  //pause
  if (mouseReleased) mode = PAUSE;

  //text(mouseX, 400, 400);
  fill(red);
  textFont(font);
  textSize(25);
  text("lives: " + myHero.hp, 650, 100);
  text("ammo: " + myHero.ammo, 650, 150);

  //lose game
  if (myHero.hp <= 0 || numEnemies <= 0) mode = GAMEOVER;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void drawRoom() {

  //walls
  background(brown);
  strokeWeight(3);
  stroke(gold);
  line(width, 0, 0, height);
  line(0, 0, width, height);
  rect(width/2, height/2, width-140, height-105); //floor border

  //find which directions have exits
  north = currentMap.get(myHero.roomX, myHero.roomY-1);
  east = currentMap.get(myHero.roomX+1, myHero.roomY);
  south = currentMap.get(myHero.roomX, myHero.roomY+1);
  west = currentMap.get(myHero.roomX-1, myHero.roomY);

  //draw exits
  fill(0);
  if (north != mapBkgd) circle(width/2, 52.5, 100);
  if (east != mapBkgd) circle(width-70, height/2, 100);
  if (south != mapBkgd) circle(width/2, height-52.5, 100);
  if (west != mapBkgd) circle(70, height/2, 100);


  //floor
  image(ground, width/2+1, height/2, width-143, height-108);
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void drawObjects() {

  //show objects
  int i = 0;
  while (i < myObjects.size()) {
    GameObject o = myObjects.get(i);
    if (o.roomX == myHero.roomX && o.roomY == myHero.roomY) { //only run code if in same room as hero
      if (o instanceof Enemy) {
        if (dist(myHero.loc.x, myHero.loc.y, o.loc.x, o.loc.y) < 300) { //only make the enemy act if it is in range of the darkness
          o.show();
          o.act();
        } else o.show();
      } else {
        o.act();
        o.show();
      }
    }

    //remove objects
    if (o.hp <= 0) {
      myObjects.remove(i);
      i--;
    }
    i++;
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void miniMap() {

  //draw map
  pushMatrix();
  translate(75, 50);
  rectMode(CORNER);
  int x = 0;
  int y = 0;
  int size = 10;
  while (y < currentMap.height) {
    noStroke();
    fill(currentMap.get(x, y));
    square(x*size, y*size, size);
    x++;
    if (x > currentMap.width-1) {
      y++;
      x = 0;
    }
  }

  //coloured square
  fill(green);
  stroke(gold);
  strokeWeight(0.5);
  square(myHero.roomX*size, myHero.roomY*size, size);


  popMatrix();
}
