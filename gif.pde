class Gif {

  int gifLength, frame, frameRateTimer, frameRateThreshold;
  PImage[] gif;

  //basic full-screen gif
  Gif(int nf, String fileStart, String fileEnd, int fr) {
    gifLength = nf;
    gif = new PImage[gifLength];
    int i = 0;
    while (i < gifLength) {
      if (i > 9) gif[i] = loadImage(fileStart + i + fileEnd);
      else gif[i] = loadImage(fileStart + "0" + i + fileEnd);
      i++;
    }
    frame = 0;
    frameRateTimer = 0;
    frameRateThreshold = fr;
  }

  void show() {
    image(gif[frame], width/2, height/2, width, height);
    frameRateTimer++;
    if (frameRateTimer >= frameRateThreshold) {
      frame++;
      frameRateTimer = 0;
    }
    if (frame >= gifLength) frame = 54;
  }

  void show(float x, float y, float w, float h) {
    image(gif[frame], x, y, w, h);
    frameRateTimer++;
    if (frameRateTimer >= frameRateThreshold) {
      frame++;
      frameRateTimer = 0;
    }
    if (frame >= gifLength) frame = 0;
  }
}
