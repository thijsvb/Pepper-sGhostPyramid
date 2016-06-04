import processing.serial.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;

PShape heart, hHeart, vHeart;
int IBI;
int BPM, pBPM;
int ABPM = 70;
int people = 1;
int Sensor;
boolean bpmPresent, pbpmPresent;
float a = 0;
float hBeat = 0;
float scaler;
float hScaleX = 1;
float hScaleY = 1;
float hScaleZ = 1;
float vScaleX = 1;
float vScaleY = 1;
float vScaleZ = 0.65;
Serial port;

void setup() {
  //size(600, 600, P3D);
  fullScreen(P3D);

  minim = new Minim(this);
  player = minim.loadFile("Beat.mp3");

  port = new Serial(this, Serial.list()[0], 115200);
  port.clear();
  port.bufferUntil('\n');

  heart = loadShape("Heart.OBJ");
  heart.disableStyle();
  //heart.rotateY(PI);
  heart.translate(0, -50, 50);
  heart.scale(height/(600/1.45));

  hHeart = heart;
  hHeart.scale(hScaleX, hScaleY, hScaleZ);
  vHeart = heart;
  vHeart.scale(vScaleX, vScaleY, vScaleZ);

  textSize(20);
  textAlign(CENTER, CENTER);
  background(0);
}

void draw() {
  background(0);
  fill(255, 0, 0);
  stroke(255);
  translate(width/2, height/2);
  line(-height/2, -height/2, height/2, height/2);
  line(height/2, -height/2, -height/2, height/2);
  directionalLight(255, 255, 255, 0, 0, -1);


  pbpmPresent = bpmPresent;
  if (BPM >= 50 && BPM <= 200 && IBI <= 2000) {
    bpmPresent = true;
  } else {
    bpmPresent = false;
    if (pbpmPresent) {
      people++;
      ABPM+=pBPM;
    }
  }

  /*
  if (!bpmPresent) {
   float ibTime = 60000/(ABPM/people);
   if (millis()%ibTime <= 30) {
   hBeat = 20;
   }
   }
   */

  if (hBeat == 20) {
    if (bpmPresent) {
      player.rewind();
      player.play();
    }
  }
  hBeat--;
  hBeat = max(hBeat, 0);
  if (hBeat > 0) {
    scaler = 1;
  } else {
    scaler = 0.9;
  }

  for (float r=0; r<TWO_PI; r+=HALF_PI) {
    pushMatrix();
    pushStyle();
    rotate(r);
    translate(0, -height/4);
    rotateX(HALF_PI);
    rotateZ(r+a);
    scale(scaler);
    if (r < HALF_PI) {
      shape(vHeart, 0, 0);
    } else if (r < PI) {
      shape(hHeart, 0, 0);
    } else if (r < PI+HALF_PI) {
      shape(vHeart, 0, 0);
    } else if (r < TWO_PI) {
      shape(hHeart, 0, 0);
      ;
    }
    popMatrix();
    popStyle();
  }

  fill(255);
  if (bpmPresent) {
    text("BPM: " + BPM, height/2-200, height/2-50);
  } /*else {
   text("BPM:\n" + constrain(ABPM/people, 50, 130) + "\naverage", height/2-220, height/2-100);
   }*/
  rotate(PI);
  text(people + " visitors", height/2-200, height/2-50);

  a = (a+PI/64)%TWO_PI;
}