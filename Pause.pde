void pause() {

  //background
  fill(gold, 50);
  noStroke();
  rect(width/2, height/2, width, height);

  //text
  fill(black);
  textFont(font);
  textAlign(LEFT);
  textSize(75);
  text("MAX LIVES: " + myHero.hpMax, 50, height/5+50);
  text("SPEED: " + myHero.speed, 50, height*2/5+50);
  text("DAMAGE: " + ((myHero.myWeapon.bulletSpeed*myHero.myWeapon.bulletSize)/20)+1, 50, height*3/5+50);
  text("AMMO: " + myHero.ammo, 50, height*4/5+50);

  //buttons
  moreHp.show();
  moreSpeed.show();
  moreDamage.show();
  moreAmmo.show();
  unPause.show();
  if (mouseReleased && myHero.xp >= 5) {
    if (moreHp.mouseOver) {
      myHero.hpMax++;
      myHero.xp-=5;
    }
    if (moreSpeed.mouseOver) {
      myHero.speed+=0.5;
      myHero.xp-=5;
    }
    if (moreDamage.mouseOver) {
      myHero.myWeapon.bulletSpeed+=2;
      myHero.xp-=5;
    }
    if (moreAmmo.mouseOver) {
      myHero.ammo+=10;
      myHero.xp-=5;
    }
  }

  if (mouseReleased && unPause.mouseOver) mode = GAME;

  //current xp title
  textAlign(CENTER);
  textFont(font);
  fill(green);
  text(myHero.xp + " XP", width/2, 75);
}
