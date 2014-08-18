/*
 * Yishi Xie
 * cloudSky
 * 2014
 */

// ArrayList to store many sky colors
ArrayList<Integer> skyTop_yx = new ArrayList<Integer>();
ArrayList<Integer> skyBtm_yx = new ArrayList<Integer>();

//import the minim library
import ddf.minim.*;
Minim minim;
AudioPlayer sound1_yx, sound2_yx, sound3_yx, sound4_yx, sound5_yx;
PImage cloud1_yx, cloud2_yx, cloud3_yx, cloud4_yx, cloud5_yx;

int cloud1_yxX_yx, cloud2_yxX_yx, cloud3_yxX_yx, cloud4_yxX_yx, cloud5_yxX_yx;
int cloud1_yxY_yx, cloud2_yxY_yx, cloud3_yxY_yx, cloud4_yxY_yx, cloud5_yxY_yx;
int cloud1_yxDelay_yx = 20;
int cloud2_yxDelay_yx = 80;
int cloud3_yxDelay_yx = 150;
int cloud4_yxDelay_yx = 90;
int cloud5_yxDelay_yx = 200;

void setup() {
  size(1360, 768);

  skyTop_yx.add(color(#67e4ff));//1
  skyBtm_yx.add(color(#59a5f3));
  skyTop_yx.add(color(#6db5ff));//2
  skyBtm_yx.add(color(#447cea));
  skyTop_yx.add(color(#6d96ff));//3
  skyBtm_yx.add(color(#4558e7));
  skyTop_yx.add(color(#6d88ff));//4
  skyBtm_yx.add(color(#493de6));
  skyTop_yx.add(color(#305fe4));//5
  skyBtm_yx.add(color(#e7cf00));
  skyTop_yx.add(color(#4d5db8));//6
  skyBtm_yx.add(color(#f0b230));
  skyTop_yx.add(color(#4b42c0));//7
  skyBtm_yx.add(color(#ff9732));
  skyTop_yx.add(color(#4255c0));//8
  skyBtm_yx.add(color(#ff9732));
  skyTop_yx.add(color(#835897));//9
  skyBtm_yx.add(color(#ff7c34));
  skyTop_yx.add(color(#7d266c));//10
  skyBtm_yx.add(color(#ff662b));
  skyTop_yx.add(color(#4d267d));//11
  skyBtm_yx.add(color(#f5664a));
  skyTop_yx.add(color(#231074));//12
  skyBtm_yx.add(color(#f03e1b));

  // This last pair will be just outside the right edge of the screen
  skyTop_yx.add(color(#000f5b));//13
  skyBtm_yx.add(color(#e83c00));

  // load cloud images
  cloud1_yx=loadImage("cloud1_yx.png");
  cloud2_yx=loadImage("cloud2_yx.png");
  cloud3_yx=loadImage("cloud3_yx.png");
  cloud4_yx=loadImage("cloud4_yx.png");
  cloud5_yx=loadImage("cloud5_yx.png");

  // initialize cloud positions
  cloud1_yxX_yx = - cloud1_yx.width;
  cloud1_yxY_yx = int(random(0, height/5));
  cloud2_yxX_yx = - cloud2_yx.width;
  cloud2_yxY_yx = int(random(height/4, 2*(height/5)));
  cloud3_yxX_yx = - cloud3_yx.width;
  cloud3_yxY_yx = int(random(2*(height/5), 2*(height/4)));
  cloud4_yxX_yx = - cloud4_yx.width;
  cloud4_yxY_yx = int(random(2*(height/4), 4*(height/5)));
  cloud5_yxY_yx = int(random(3*(height/5), height));

  // minim load files from the data directory
  minim = new Minim (this);
  sound1_yx = minim.loadFile("sound1_yx.mp3");
  sound2_yx = minim.loadFile("sound2_yx.mp3");
  sound3_yx = minim.loadFile("sound3_yx.mp3");
  sound4_yx = minim.loadFile("sound4_yx.mp3");
  sound5_yx = minim.loadFile("sound5_yx.mp3");
}

void draw() {
  // Draw the gradient background
  drawSmoothGradient();

  // Draw clouds
  drawClouds();
}


/* Modified from Processing Examples - Linear Gradient */
/* http://processing.org/examples/lineargradient.html  */
void drawGradient(color colorTop, color colorBottom) {
  noFill();
  for (int i = 0; i <= height; i++) {
    float interpolateVertical = map(i, 0, height, 0, 1);
    color c = lerpColor(colorTop, colorBottom, interpolateVertical);
    stroke(c);
    line(0, i, width, i);
  }
}

/* two more mappings to make it smooth */
void drawSmoothGradient() {
  noFill(); 

  int numberOfColors = skyTop_yx.size() - 1; // so colorRgt below will not run out of range
  int sectionWidth = width / numberOfColors;
  // int mouseXinSection = 700 / sectionWidth;
  int mouseXinSection = mouseX / sectionWidth;

  for (int i = 0; i <= height; i++) {
    float interpolateVertical = map(i, 0, height, 0, 1);

    // Since sometimes the program crashes if the mouse
    // moves out of screen on the right, we will wrap the
    // lerpColor part in a "try catch",
    //   - http://wiki.processing.org/w/Exceptions
    // We will initialize the colors before the try.

    color colorLft = lerpColor(skyTop_yx.get(0), 
    skyBtm_yx.get(0), 
    interpolateVertical);

    color colorRgt = lerpColor(skyTop_yx.get(1), 
    skyBtm_yx.get(1), 
    interpolateVertical);

    try {
      colorLft = lerpColor(skyTop_yx.get(mouseXinSection), 
      skyBtm_yx.get(mouseXinSection), 
      interpolateVertical);

      colorRgt = lerpColor(skyTop_yx.get(mouseXinSection + 1), 
      skyBtm_yx.get(mouseXinSection + 1), 
      interpolateVertical);
    } 
    catch (Exception e) {
      // error! but we'll do nothing
    }

    // float interpolateHorizontal = map(700 % sectionWidth, 0, sectionWidth, 0, 1);
    float interpolateHorizontal = map(mouseX % sectionWidth, 0, sectionWidth, 0, 1);

    color c = lerpColor(colorLft, colorRgt, interpolateHorizontal);
    stroke(c);
    line(0, i, width, i);
  }
}

void drawClouds() {
  tint(255, 220); // cloud transparency

  // draw cloud1_yx
  if (cloud1_yxDelay_yx > 0) {
    cloud1_yxDelay_yx--;
  } 
  else if (cloud1_yxX_yx <= (width + cloud1_yx.width)) {
    image(cloud1_yx, cloud1_yxX_yx, cloud1_yxY_yx);
    cloud1_yxX_yx += 12;
  } 
  else {
    cloud1_yxX_yx = - cloud1_yx.width;
    cloud1_yxY_yx = int(random(0, height/5));
  }

  // draw cloud2_yx
  if (cloud2_yxDelay_yx > 0) {
    cloud2_yxDelay_yx--;
  } 
  else if (cloud2_yxX_yx <= (width + cloud2_yx.width)) {
    image(cloud2_yx, cloud2_yxX_yx, cloud2_yxY_yx);
    cloud2_yxX_yx += 16;
  } 
  else {
    cloud2_yxX_yx = - cloud2_yx.width;
    cloud2_yxY_yx = int(random(height/4, 2*(height/5)));
  }

  // draw cloud3_yx
  if (cloud3_yxDelay_yx > 0) {
    cloud3_yxDelay_yx--;
  } 
  else if (cloud3_yxX_yx <= (width + cloud3_yx.width)) {
    image(cloud3_yx, cloud3_yxX_yx, cloud3_yxY_yx);
    cloud3_yxX_yx += 10;
  } 
  else {
    cloud3_yxX_yx = - cloud3_yx.width;
    cloud3_yxY_yx = int(random(2*(height/5), 2*(height/4)));
  }


  // draw cloud4_yx
  if (cloud4_yxDelay_yx > 0) {
    cloud4_yxDelay_yx--;
  } 
  else if (cloud4_yxX_yx <= (width + cloud4_yx.width)) {
    image(cloud4_yx, cloud4_yxX_yx, cloud4_yxY_yx);
    cloud4_yxX_yx += 15;
  } 
  else {
    cloud4_yxX_yx = - cloud4_yx.width;
    cloud4_yxY_yx = int(random(2*(height/4), 4*(height/5)));
  }

  // draw cloud5_yx
  if (cloud5_yxDelay_yx > 0) {
    cloud5_yxDelay_yx--;
  } 
  else if (cloud5_yxX_yx <= (width + cloud5_yx.width)) {
    image(cloud5_yx, cloud5_yxX_yx, cloud5_yxY_yx);
    cloud5_yxX_yx += 12;
  } 
  else {
    cloud5_yxX_yx = - cloud5_yx.width;
    cloud5_yxY_yx = int(random(3*(height/5), height));
  }
}


/* When the mouse touches a cloud, redraw the cloud somewhere else */
void mouseMoved() {
  if (mouseX >= cloud1_yxX_yx && mouseX<= (cloud1_yx.width + cloud1_yxX_yx))
  {
    if (mouseY >= cloud1_yxY_yx && mouseY <= (cloud1_yx.height + cloud1_yxY_yx))
    {
      cloud1_yxX_yx = - cloud1_yx.width;
      cloud1_yxY_yx = int(random(0, height/5));
      cloud1_yxDelay_yx = 20;
      sound1_yx.play(0);
      // play(0) plays from 0 second (beginning) of the soundtrack
      // we don't need rewind().
      // rewind() rewinds to beginning, but does not stop playback
    }
  }


  if (mouseX >= cloud2_yxX_yx && mouseX<= (cloud2_yx.width + cloud2_yxX_yx))
  {
    if (mouseY >= cloud2_yxY_yx && mouseY <= (cloud2_yx.height + cloud2_yxY_yx))
    {
      cloud2_yxX_yx = - cloud2_yx.width;
      cloud2_yxY_yx = int(random(height/4, 2*(height/5)));
      cloud2_yxDelay_yx = 25;
      sound2_yx.play(0);
    }
  }

  if (mouseX >= cloud3_yxX_yx && mouseX<= (cloud3_yx.width + cloud3_yxX_yx))
  {
    if (mouseY >= cloud3_yxY_yx && mouseY <= (cloud3_yx.height + cloud3_yxY_yx))
    {
      cloud3_yxX_yx = - cloud3_yx.width;
      cloud3_yxY_yx = int(random(2*(height/5), 2*(height/4)));
      cloud3_yxDelay_yx = 40;
      sound3_yx.play(0);
    }
  }

  if (mouseX >= cloud4_yxX_yx && mouseX<= (cloud4_yx.width + cloud4_yxX_yx))
  {
    if (mouseY >= cloud4_yxY_yx && mouseY <= (cloud4_yx.height + cloud4_yxY_yx))
    {
      cloud4_yxX_yx = - cloud4_yx.width;
      cloud4_yxY_yx = int(random(2*(height/4), 4*(height/5)));
      cloud4_yxDelay_yx = 5;
      sound4_yx.play(0);
    }
  }

  if (mouseX >= cloud5_yxX_yx && mouseX<= (cloud5_yx.width + cloud5_yxX_yx))
  {
    if (mouseY >= cloud5_yxY_yx && mouseY <= (cloud5_yx.height + cloud5_yxY_yx))
    {
      cloud5_yxX_yx = - cloud5_yx.width;
      cloud5_yxY_yx = int(random(3*(height/5), height));
      cloud5_yxDelay_yx = 60;
      sound5_yx.play(0);
    }
  }
}

void stop() {
  sound1_yx.close();
  sound2_yx.close();
  sound3_yx.close();
  sound4_yx.close();
  sound5_yx.close();
  minim.stop();
  super.stop();
}

