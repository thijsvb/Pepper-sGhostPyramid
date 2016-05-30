import processing.serial.*;
import ddf.minim.*;

Minim minim;
AudioPlayer player;

PShape heart;
int IBI;
int BPM, pBPM;
int ABPM = 70;
int people = 1;
int Sensor;
boolean bpmPresent, pbpmPresent;
float a = 0;
float hBeat = 0;
float scaler;
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
  
  textSize(40);
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
  pBPM = BPM;
  if (BPM >= 50 && BPM <= 220 && IBI <= 2000) {
    bpmPresent = true;
  } else {
    bpmPresent = false;
    if(pbpmPresent){
      people++;
      ABPM+=BPM;
    }
  }

  if(!bpmPresent){
    float ibTime = 60000/(ABPM/people);
    if(millis()%ibTime <= 30){
      hBeat = 20;
    }
  }
  
  if(hBeat == 20){
    player.rewind();
    player.play();
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
    shape(heart, 0, 0);
    popMatrix();
    popStyle();
  }

  fill(255);
  if (bpmPresent) {
    text("BPM:\n" + BPM, height/2-200, height/2-100);
  } else {
    text("BPM:\n" + ABPM/people + "\naverage", height/2-220, height/2-100);
  }
  rotate(PI);
  text(people + "\nvisitors", height/2-200, height/2-100);

  a = (a+PI/64)%TWO_PI;
}