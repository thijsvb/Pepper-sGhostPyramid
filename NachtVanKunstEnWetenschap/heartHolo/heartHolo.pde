import processing.serial.*;

PShape heart;
int IBI;
int BPM;
int Sensor;
boolean beat;
float a = 0;
float hBeat = 0;
float scaler;
Serial port;

void setup() {
  //size(600, 600, P3D);
  fullScreen(P3D);
  port = new Serial(this, Serial.list()[0], 115200);
  port.clear();
  port.bufferUntil('\n');
  heart = loadShape("Heart.OBJ");
  heart.disableStyle();
  heart.rotateY(PI);
  heart.translate(0, -50);
  heart.scale(height/(600/1.45));
  background(0);
  fill(255, 0, 0);
  stroke(255);
}

void draw() {
  background(0);
  translate(width/2, height/2);
  line(-height/2, -height/2, height/2, height/2);
  line(height/2, -height/2, -height/2, height/2);
  directionalLight(255, 255, 255, 0, 0, -1);

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
  a = (a+PI/64)%TWO_PI;
}