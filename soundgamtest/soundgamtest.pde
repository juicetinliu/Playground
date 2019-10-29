float roomwidth = 600, roomheight = 300;
ArrayList<soundParticle> sounds = new ArrayList<soundParticle>();
ArrayList<PVector> shape = new ArrayList<PVector>();
boolean shapeready = false, clearshape = false, plotpath = false, startgam = false; 
int partnumber = 30;
boolean createsounds = true;
float playerx, playery;
boolean isLeft, isRight, isUp, isDown; 
int playerspeed = 3;

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
  if(shapeready){
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
  }
  
  stroke(0,255,255);
  noFill();
  strokeWeight(3);
  ellipse(playerx, playery, 10,10);
  
  if(startgam && shape.size() > 2){
    if(createsounds){
      for(int i = 0; i < partnumber; i++){
      sounds.add(new soundParticle(playerx, playery, radians((360*i)/partnumber), 3,5,100,30));
      }
      createsounds = false;
    }
    
    for(soundParticle soundP:sounds){
      for(int i = 0; i < shape.size()-1; i++){
        soundP.bounce(shape.get(i).x,shape.get(i).y,shape.get(i+1).x,shape.get(i+1).y);
      }
      soundP.bounce(shape.get(shape.size()-1).x,shape.get(shape.size()-1).y,shape.get(0).x,shape.get(0).y);
      soundP.display();
      soundP.move();
    }
    for(int p = 0; p < sounds.size(); p++){
      if(sounds.get(p).ageparticle()){
        sounds.remove(p);
      }
    }
    if(sounds.size() == 0){
      startgam = false;
    }
  }
  if(clearshape){
    for(int i = shape.size() - 1; i >= 0; i--){
        shape.remove(i);
    }
    for(int k = sounds.size() - 1; k >= 0 ; k--){
        sounds.remove(k);
    }
    clearshape = false;
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    shapeready = !shapeready;
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
  }else{
    setMove(keyCode, true);
  }
}

void keyReleased() {
  if (key != 'x' && key != 'c') {
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
