class Button {
  boolean clicked, pressed, mouseOver;
  float x, y, s, textDivider;
  String text;
  color tactileColour;

  Button(String _text, float _x, float _y, float _s, float td, color tc) {
    text = _text;
    x = _x;
    y = _y;
    s = _s;
    textDivider = td;
    tactileColour = tc;
  }

  void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);

    //see if mouse is over
    if (dist(x, y, mouseX, mouseY) <= s) mouseOver = true;
    else mouseOver = false;

    //tactile
    if (mouseOver) fill(tactileColour);
    else fill(0);

    //text
    textSize(s/textDivider);
    text(text, x, y);

    //button
    noFill();
    circle(x, y, s);
  }
}
