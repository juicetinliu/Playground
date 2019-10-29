int scl = 10;
int w = 4000;
int h = 2000;
int cols = w / scl;
int rows = h/ scl;
boolean isLeft, isRight, isUp, isDown; 
float playerx, playery, playerz;

float flying = 0;
float shiny = 0;
float[][] terrain = new float[cols][rows];

void setup() {
  fullScreen(P3D);
  noiseSeed(1953);
  playerx = 0;
  playery = 0;
  playerz = 1000;
  float yoff = 0;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -100, 100);
      xoff += 0.03;
    }
    yoff += 0.03;
  }
  
}


void draw() {


  pointLight(255,255,255, playerx, playery, playerz);
  

  moveCamera();

  background(0);

  

  translate(0,100,0);
  
  noStroke();
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      if(terrain[x][y] < -70){
        fill(255);
      }else if(terrain[x][y] > 10){
        fill(#48C0FF);
      }else{
        fill(#71D37B);
      }
      vertex(x*scl, terrain[x][y], y*scl);
      vertex(x*scl, terrain[x][y+1], (y+1)*scl);
      //rect(x*scl, y*scl, scl, scl);
    }
    endShape();
  }
  fill(0,0,255);
  translate(0,10,0);
  rotateX(PI/2);
  rect(0,0,w,h);
}

void moveCamera(){
  if(isLeft){
    playerz = playerz - 1;
  }
  if(isRight){
    playerz = playerz + 1;
  }
  if(isDown){
    playerx = playerx - 1;
  }
  if(isUp){
    playerx = playerx + 1;
  }
  playery = map((height/2 - mouseY)*10,4000,-3990,50,-500);
  camera(playerx, playery, playerz, playerx + 2, playery + 1, playerz, 0,1,0);
}

void keyPressed() {
  setMove(keyCode, true);
}
 
void keyReleased() {
  setMove(keyCode, false);
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
