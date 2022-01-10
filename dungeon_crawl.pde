//Charlotte Jacques
//Dungeon Crawl Project


//mode variables
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;
int mode = INTRO;

//level variables
int level = 1;
int numEnemies = 0;

//interaction variables
boolean mouseReleased, hadPressed;
boolean upKey, downKey, rightKey, leftKey, spaceKey;

//font variables
PFont font;
int initDungeon = 180;
int initCrawl = 120;
int dungeonSize = 90;
int crawlSize = 70;

//theme
color brown = #6C4545;
color gold = #C68812;
color green = #266451;
color grey = #4D4747;
color red = #FF0000;
color lightBlue = #9EBDC4;
color black = #000000;
color white = #FFFFFF;
PImage ground;
boolean startingGame;
int startCircleSize = 50;

//gif variables
Gif hallway, heroUp, heroDown, heroLeft, heroRight;

//objects
Hero myHero;
ArrayList<GameObject> myObjects;

//darkness variables
ArrayList<Darkness> darkness;
float darknessSize = 5;
float x = darknessSize/2;
float y = darknessSize/2;

//map variables
PImage scroll, currentMap, currentColourMap, map1, map2, colourMap1, colourMap2;
color mapBkgd = #D3BA86 ;
color north, east, south, west;

//button variables
Button introButton, moreHp, moreSpeed, moreDamage, moreAmmo, unPause;

//weapon variables
final int FINGER_THRESH = 10;
final int FINGER_SPEED = 15;
final int FINGER_SIZE = 60;
final int POWER_THRESH = 2;
final int POWER_SPEED = 50;
final int POWER_SIZE = 5;
final int BOMB_THRESH = 40;
final int BOMB_SPEED = 5;
final int BOMB_SIZE = 80;
PImage fingerGun;

//enemy variables
PImage follower, shooter, creator, magician, giant, hacker, dungeonMaster, fireball;

//colour coded map theme
color maroon = #5E241B; //follower in middle
color darkPurple = #361B5E; //2 shooters at opposite corners (and one in the middle?)
color teal = #16849C; //creator in middle
color blue = #1B3C5E; //magician appearing randomly
color dirtBrown = #654A4A; //2 giants at opposite corners (opposite to shooters)
color navy = #0B0A38; //hacker in middle
color lightPurple = #7270E1; //shooter in middle
color oliveGreen = #646910; //2 followers
color orange = #AC680D; //4 giants at corners, just not growing as fast
color pink = #9E00DB; //dungeon master in middle

//dropped item variables
final int AMMO = 0;
final int HEALTH = 1;
final int GUN = 2;
final int POWER = 0;
final int FINGER = 1;
final int BOMB = 2;
Gif ammo, redCross, rifle;


void setup() { //-------------------------------------------------------------------------------------------------------

  //setup
  size(800, 600);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  imageMode(CENTER);

  //font variables
  font = createFont("DeaconFlock.ttf", 100);
  ground = loadImage("new brick ground.jpeg");

  //gif variables
  hallway = new Gif(55, "intro/frame_", "_delay-0.07s.gif", 1);
  heroUp = new Gif (4, "character/up/sprite_", ".png", 1);
  heroDown = new Gif (4, "character/down/sprite_", ".png", 1);
  heroLeft = new Gif (4, "character/left/sprite_", ".png", 1);
  heroRight = new Gif (4, "character/right/sprite_", ".png", 1);

  //objects
  myHero = new Hero();
  myObjects = new ArrayList<GameObject>();
  myObjects.add(myHero);

  //darkness variables
  darkness = new ArrayList<Darkness>();
  int i = 0;
  while (i < (width*height)/(darknessSize*darknessSize)) {
    darkness.add(new Darkness(x, y, darknessSize));
    x+=darknessSize;
    if (x > width-(darknessSize/2)) {
      y+=darknessSize;
      x = darknessSize/2;
    }
    i++;
  }

  //map variables
  scroll = loadImage("maps/map background.png");
  map1 = loadImage("maps/map 1.png");
  colourMap1 = loadImage("maps/map 1 colour.png");
  map2 = loadImage("maps/map 2.png");
  colourMap2 = loadImage("maps/map 2 colour.png");
  currentMap = map1;
  currentColourMap = colourMap1;

  //button variables
  introButton = new Button("open", 503, 426, 50, 3, gold);
  moreHp = new Button("+", width-50, height/5+25, 40, 0.5, green);
  moreSpeed = new Button("+", width-50, height*2/5+25, 40, 0.5, green);
  moreDamage = new Button("+", width-50, height*3/5+25, 40, 0.5, green);
  moreAmmo = new Button("+", width-50, height*4/5+25, 40, 0.5, green);
  unPause = new Button("x", width-50, 25, 75, 1, green);

  //weapon variables
  fingerGun = loadImage("finger gun.png");

  //enemy variables
  shooter = loadImage("enemies/shooter cowboy.png");
  follower = loadImage("enemies/follower.png");
  creator = loadImage("enemies/creator.png");
  magician = loadImage("enemies/magician.png");
  giant = loadImage("enemies/giant.png");
  hacker = loadImage("enemies/hacker.png");
  dungeonMaster = loadImage("enemies/dungeon master.png");
  fireball = loadImage("enemies/fireball.png");

  //dropped item variables
  ammo = new Gif(4, "ammo/pixil-frame-", ".png", 3);
  redCross = new Gif(4, "health/pixil-frame-", ".png", 3);
  rifle = new Gif(4, "rifle/pixil-frame-", ".png", 3);

  loadEnemies();
}

void draw() { //---------------------------------------------------------------------------------------------------------

  //go to modes
  if (mode == INTRO) intro();
  else if (mode == GAME) game();
  else if (mode == PAUSE) pause();
  else if (mode == GAMEOVER) gameover();
  else println("error - mode = " + mode);

  //set up mouseReleased variable
  if (mousePressed) hadPressed = true;
  if (hadPressed && !mousePressed) {
    mouseReleased = true;
    hadPressed = false;
  } else mouseReleased = false;
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

void loadEnemies() {
  rectMode(CORNER);
  int x = 0;
  int y = 0;
  while (y < currentColourMap.height) {
    color roomColour = currentColourMap.get(x, y);

    //add enemies to rooms
    if (roomColour == maroon) {
      myObjects.add(new Follower(x, y, width/2, height/2));
      numEnemies++;
    }
    if (roomColour == darkPurple) {
      myObjects.add(new ShooterCowboy(x, y, width-150, 150));
      myObjects.add(new ShooterCowboy(x, y, 150, height-150));
      numEnemies+=2;
    }
    if (roomColour == blue) {
      int c = 0;
      while (c < 30) {
        myObjects.add(new Magician(x, y));
        numEnemies++;
        c++;
      }
    }
    if (roomColour == teal) {
      myObjects.add(new Creator(x, y, width/2, height/2));
      numEnemies++;
    }
    if (roomColour == dirtBrown) {
      myObjects.add(new Giant(x, y, 150, 150, 5));
      myObjects.add(new Giant(x, y, width-150, height-150, 5));
      numEnemies+=2;
    }
    if (roomColour == navy) {
      myObjects.add(new Hacker(x, y, width/2, height/2));
      numEnemies++;
    }
    if (roomColour == lightPurple) {
      myObjects.add(new ShooterCowboy(x, y, width/2, height/2));
      numEnemies++;
    }
    if (roomColour == oliveGreen) {
      myObjects.add(new Follower(x, y, 150, height/2));
      myObjects.add(new Follower(x, y, width-150, height/2));
      numEnemies+=2;
    }
    if (roomColour == orange) {
      myObjects.add(new Giant(x, y, 150, 150, 2));
      myObjects.add(new Giant(x, y, width-150, height-150, 2)); 
      myObjects.add(new Giant(x, y, width-150, 150, 2));
      myObjects.add(new Giant(x, y, 150, height-150, 2));
      numEnemies+=4;
    }
    if (roomColour == pink) {
      myObjects.add(new DungeonMaster(x, y));
      numEnemies++;
    }

    //go through map
    x++;
    if (x == currentColourMap.width) {
      x = 0;
      y++;
    }
  }
  rectMode(CENTER);
}
