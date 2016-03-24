float c,rot;
int res = 30;

void setup(){
  fullScreen(P3D);
  colorMode(HSB);
  fill(255);
}

void draw(){
  background(0);
  pushStyle();
  stroke(255);
  line(width/2-height/2,0,width/2+height/2,height);
  line(width/2+height/2,0,width/2-height/2,height);
  popStyle();
  
  c = (c+1)%256;
  sphereDetail(res);
  for(int r=0; r!=4; ++r){
    pushMatrix();
    translate(width/2,height/2);
    rotate(r*HALF_PI);
    
    stroke(c,255,255);
    translate(0,-200);
    rotateY(rot);
    sphere(100);
    
    popMatrix();
  }

  if(keyPressed && key == CODED){
    if(keyCode == UP){
      ++res;
    }
    else if(keyCode == DOWN){
      --res;
    }
    else if(keyCode == LEFT){
      rot = (rot + PI/16)%TWO_PI;
    }
    else if(keyCode == RIGHT){
      rot = (rot - PI/16)%TWO_PI;
    }
  }
}