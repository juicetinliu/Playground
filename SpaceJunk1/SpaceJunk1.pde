boolean isLeft, isRight, isUp, isDown; 
float playerx, playery, playerz;
float playerrotxz, playerroty, playerrotz;
float deltx;
import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;
Robot robby;

int limit = 100;
Planet[] planets = new Planet[limit];

float playerspeed = 100;

void setup() {
  randomSeed(0);
  size(1280, 700, P3D); 
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
  noCursor();
  
  for (int i = 0; i < planets.length; i++){
    planets[i] = new Planet(random(-100000,100000),random(-100000,100000),random(-100000,100000), random(200,1000), int(random(0,255)), int(random(0,255)), int(random(0,255)));
  }
}

void draw(){
  background(0); 
  fill(200);
  // Raise overall light in scene 
  pointLight(255,255,255,playerx,playery,playerz);
  ambientLight(255,255,255);
  
  moveCamera();
  
    // Draw cubes
  for (int i = 0; i < planets.length; i++){
    if(dist(playerx, playery, playerz, planets[i].x, planets[i].y, planets[i].z) < 10000){
      planets[i].drawPlanet();
    }
  }
  
  //fill(255);
  //rect(0,0,1000,1000);
  hud();
}

void moveCamera(){
  if(isLeft){
    playerz = playerz + playerspeed*sin(3*PI/2+playerroty);
    playerx = playerx + playerspeed*cos(3*PI/2+playerroty);
  }
  if(isRight){
    playerz = playerz + playerspeed*sin(PI/2+playerroty);
    playerx = playerx + playerspeed*cos(PI/2+playerroty);
  }
  if(isDown){
    playerz = playerz - playerspeed*sin(playerroty)*sin(playerrotxz);
    playerx = playerx - playerspeed*cos(playerroty)*sin(playerrotxz);
    playery = playery - playerspeed*cos(playerrotxz);
  }
  if(isUp){
    playerz = playerz + playerspeed*sin(playerroty)*sin(playerrotxz);
    playerx = playerx + playerspeed*cos(playerroty)*sin(playerrotxz);
    playery = playery + playerspeed*cos(playerrotxz);
  }
  mousemovement();
  
  //playerroty = map(mouseX,0,width,0,2*PI);
  playerroty = playerroty + radians(deltx/5);
  playerrotxz = map(mouseY,0,height,PI,0);
  camera(playerx, playery, playerz, playerx+cos(playerroty)*sin(playerrotxz), playery+cos(playerrotxz), playerz+sin(playerroty)*sin(playerrotxz), 0,1,0);
}

void mousemovement(){
  deltx = mouseX - pmouseX;
  if(mouseX < 50){
    robby.mouseMove(width-50, mouseY+44);
  }else if(mouseX > width-50){
    robby.mouseMove(50, mouseY+44);
  }
  deltx = deltx % (width-100);
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
  line(0,height-mouseY,400,height-mouseY);
  line(width-400, height-mouseY, width, height-mouseY);
  noFill();
  ellipse(width/2,height/2,20,20);
  
  strokeWeight(1);
  stroke(#C4C3E3);
  fill(#020043);
  rect(10,10,200,200);
  fill(255);
  float hudpx = map(playerx,-100000,100000,210,10);
  float hudpz = map(playerz,-100000,100000,210,10);
  float hudpy = map(playery,-100000,100000,2,6);
  ellipse(hudpx,hudpz,hudpy,hudpy);
  
  pushMatrix();
  translate(hudpx,hudpz);
  rotate(playerroty-PI/2);
  noStroke();
  fill(255,100);
  triangle(0,0,-3,-7,3,-7);
  popMatrix();
  
  for (int i = 0; i < planets.length; i++){
    if(dist(planets[i].x,planets[i].y,planets[i].z,playerx,playery,playerz) < (planets[i].radius + 5000)){
      textSize(32);
      fill(255);
      text("Planet", 20, 250);
      text(i, 120, 250);
    }
    if(abs(planets[i].y - playery) < 5000){
      stroke(255);
      fill(planets[i].r,planets[i].g,planets[i].b);
      float planethudy = map(abs(planets[i].y-playery),0,5000,6,0);
      float planethudx = map(planets[i].x,-100000,100000,210,10);
      float planethudz = map(planets[i].z,-100000,100000,210,10);
      float planethudsize = map(planets[i].radius, 200,1000,0,4);
      ellipse(planethudx, planethudz,planethudy+planethudsize,planethudy+planethudsize);
    }
  }
  
  
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
