boolean isLeft, isRight, isUp, isDown; 
float playerx, playery, playerz;
float playerrotxz, playerroty, playerrotz;
float deltx;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
Robot robby;

void setup() {
  fullScreen(P3D); 
  pixelDensity(displayDensity());
  frameRate(60);

  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
  playerx = 0;
  playery = 0;
  playerz = 0;
  playerrotxz = 0;
  playerroty = 0;
  playerrotz = 0;
  //noCursor();
  
  float fov = PI/3.0;
  float cameraZ = (height/2.0) / tan(fov/2.0);
  float nearClippingDistance = 0.01; // default is cameraZ/10.0
  perspective(fov, float(width)/float(height), nearClippingDistance, cameraZ*10.0);
}

void draw(){
  background(#BBDEFA,255); 
  
  
  moveCamera();
  
  stroke(0);
  strokeWeight(1);
  fill(255,255,0,128);
  box(100,100,100);
  pushMatrix();
  translate(100,-3,100);
  box(50,50,50);
  popMatrix();
  rotateX(PI/2);
  translate(0,0,-50);
  fill(#05980F);
  rect(-500,-500,1000,1000);
  //rect(0,0,50,50);
  hud();
}

void moveCamera(){
  if(isLeft){
    playerz = playerz + 5*sin(3*PI/2+playerroty);
    playerx = playerx + 5*cos(3*PI/2+playerroty);
  }
  if(isRight){
    playerz = playerz + 5*sin(PI/2+playerroty);
    playerx = playerx + 5*cos(PI/2+playerroty);
  }
  if(isDown){
    playerz = playerz + 5*sin(PI+playerroty);
    playerx = playerx + 5*cos(PI+playerroty);
  }
  if(isUp){
    playerz = playerz + 5*sin(playerroty);
    playerx = playerx + 5*cos(playerroty);
  }
  
  mousemovement();
  
  //playerroty = map(mouseX,0,width,0,2*PI);
  playerroty = playerroty + radians(deltx/5);
  playerrotxz = map(mouseY,0,height,PI-0.01,0);
  print(playerx);
  print(',');
  print(playery);
  print(',');
  print(playerz);
  print("||");
  println(playerroty);
  camera(playerx, playery, playerz, playerx+cos(playerroty)*sin(playerrotxz), playery+cos(playerrotxz), playerz+sin(playerroty)*sin(playerrotxz), 0,1,0);
}

void mousemovement(){
  deltx = mouseX - pmouseX;
  if(mouseX < 50){
    robby.mouseMove(width-100, mouseY);
  }else if(mouseX > width-50){
    robby.mouseMove(100, mouseY);
  }
  deltx = deltx % (width-150);
}

void hud(){
  //---- HUD
  camera(); 
  noLights();
   
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
   
  stroke(#FF2C2F,100);
  strokeWeight(6);
  noFill();
  ellipse(width/2,height/2,20,20);
  noStroke();
   
  // prepare to return to 3D 
  hint(ENABLE_DEPTH_TEST);
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
