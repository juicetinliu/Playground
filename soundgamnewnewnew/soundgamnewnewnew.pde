//float roomwidth = 600, roomheight = 300;
ArrayList<soundParticle> sounds = new ArrayList<soundParticle>();
ArrayList<PVector> shape = new ArrayList<PVector>();
boolean shapeready = false, clearshape = false, plotpath = false, startgam = false; 
int partnumber = 30;
boolean createsounds = false;
boolean clearsounds = false;
float playerx, playery;
boolean isLeft, isRight, isUp, isDown; 
int playerspeed = 3;
boolean bounceit = true;

void setup(){
  fullScreen();
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  playerx = width/2;
  playery = height/2;
}

void draw(){
  background(0);
  if(isLeft){
    playerx = playerx - playerspeed;
  }
  if(isRight){
    playerx = playerx + playerspeed;
  }
  if(isDown){
    playery = playery + playerspeed;
  }
  if(isUp){
    playery = playery - playerspeed;
  }
  //if(shapeready){
    stroke(255);
    noFill();
    strokeWeight(3);
    for(PVector point:shape){
      ellipse(point.x, point.y, 10,10);
    }    
    beginShape();
    for(PVector point:shape){
      vertex(point.x, point.y);
    }
    endShape(CLOSE);
  //}
  
  stroke(0,255,255);
  noFill();
  strokeWeight(3);
  ellipse(playerx, playery, 10,10);
  
  //if(startgam && shape.size() > 2){
    if(createsounds){
      for(int i = 0; i < partnumber; i++){
        sounds.add(new soundParticle(playerx, playery, radians((360*i)/partnumber), 5,100));
      }
      createsounds = false;
    }

    for(soundParticle soundP:sounds){
      soundP.display();
      boolean done = true;
      if(bounceit){
        while(done){
          done = soundP.bounce(shape);
        }
      }
      soundP.move();
    }
    //if(bounceit){
    //  bounceit = false;
    //}
    //for(int p = 0; p < sounds.size(); p++){
    //  if(sounds.get(p).ageparticle()){
    //    sounds.remove(p);
    //  }
    //}
    //if(sounds.size() == 0){
    //  startgam = false;
    //}
  //}
  
  if(clearshape){
    for(int i = shape.size() - 1; i >= 0; i--){
        shape.remove(i);
    }
    clearshape = false;
  }
  if(clearsounds){
    for(int k = sounds.size() - 1; k >= 0 ; k--){
        sounds.remove(k);
    }
    clearsounds = false;
  }
  
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    bounceit = true;
  } else if (mouseButton == LEFT) {
    shape.add(new PVector(mouseX,mouseY));
  }
}

void keyPressed() {
  if (key == 'x') {
    startgam = true;
    createsounds = true;
  }else if (key == 'c') {
    clearshape = true;
  }else if (key == 'z'){
    clearsounds = true;
  }else{
    setMove(keyCode, true);
  }
}

void keyReleased() {
  if (key != 'x' && key != 'c' && key != 'z') {
    setMove(keyCode, false);
  }
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
 
  case DOWN:
    return isDown = b;
 
  case LEFT:
    return isLeft = b;
 
  case RIGHT:
    return isRight = b;

  case 87:
    return isUp = b;
 
  case 83:
    return isDown = b;
 
  case 65:
    return isLeft = b;
 
  case 68:
    return isRight = b;
    
  default:
    return b;
  }
}
