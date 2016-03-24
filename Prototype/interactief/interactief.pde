import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

Arduino arduino;

float c, rot;

void setup(){
  fullScreen(P3D);
  colorMode(HSB);
  fill(255);
  stroke(255);
  strokeWeight(2);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(60);
  
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(0,Arduino.INPUT);
}

void draw(){
  background(0);
  pushStyle();
  strokeWeight(1);
  line(width/2-height/2,0,width/2+height/2,height);
  line(width/2+height/2,0,width/2-height/2,height);
  popStyle();
  
  c = map(arduino.analogRead(0),0,1024,0,256);
  //c = map(mouseX,0,width,0,256);
  fill(c,255,255);
  for(int r=0; r!=4; ++r){
    pushMatrix();
    translate(width/2,height/2);
    rotate(r*HALF_PI);
    
    translate(0,-200);
    rotateY(rot);
    rotateX(PI/4);
    rotateZ(PI/4);
    box(100);
    
    popMatrix();
  }
  
  rot = (rot + PI/64) % TWO_PI;
}