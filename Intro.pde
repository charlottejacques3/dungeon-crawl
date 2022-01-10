void intro() {
  
  //show gif
  hallway.show();

  //title
  fill(0, 0, 0);
  textFont(font);

  if (hallway.frame >= 54) {
    introText();

    //button to start game
    noFill();
    noStroke();
    introButton.show();
    if (introButton.mouseOver && mouseReleased) startingGame = true;
    if (startingGame == true) {
      fill(0);
      circle(503, 426, startCircleSize);
      startCircleSize+=70;
      if (startCircleSize > 1350) mode = GAME;
    }
  }
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void introText() {
  pushMatrix();
  textSize(initDungeon);
  if (initDungeon <= dungeonSize) initDungeon = dungeonSize;
  initDungeon-=10;
  translate(width/2, height/2-50);
  rotate(radians(-20));
  text("DUNGEON", 0, 0);
  popMatrix();

  if (initDungeon <= dungeonSize) {
    textSize(initCrawl);
    initCrawl-=4;
    pushMatrix();
    if (initCrawl <= crawlSize) initCrawl = crawlSize;
    textSize(crawlSize);
    translate(width/2, height/2+50);
    rotate(radians(30));
    text("CRAWL", 0, 0);
    popMatrix();
  }
}
