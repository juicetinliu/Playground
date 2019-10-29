int spacing = 20;
int w = 2000;
int h = 2000;
int rows = h / spacing;
int cols = w/ spacing;
float[][] terrain = new float[rows][cols];

boolean isLeft, isRight, isUp, isDown, isRise, isFall; 
float playerx, playery, playerz;
float pointerx, pointerz;
float brushsize = 250;
boolean raiseterrain = false, lowerterrain = false, lightson = false;

float tides = 0, tidechange = 11;
float suncoor = 1000;

boolean moveground = false;
float groundplayerx = 500, groundplayerz = 500, groundplayery = 0;

void setup(){
  fullScreen(P3D);
  pixelDensity(displayDensity());
  //frameRate(60);
  smooth();
  playerx = 0;
  playery = -200;
  playerz = 0;
  for (int z = 0; z < cols; z++) {
    for (int x = 0; x < rows; x++) {
      terrain[x][z] = 0;
    }
  }
  float fov = PI/3.0;
  perspective(fov, float(width)/float(height), 0.05, 5000);
}

void draw(){
  background(0);
  if(lightson){
    pointLight(64,64,64, 0, -1000, 0);
    pointLight(64,64,64, 0, -1000, suncoor);
    pointLight(64,64,64, suncoor, -1000, 0);
    pointLight(64,64,64, suncoor, -1000, suncoor);
    //pointLight(255,255,255, playerx, playery, playerz);
  }
  if(moveground){
    movegroundCamera();
  }else{
    moveCamera();
    
    pushMatrix();
    translate(groundplayerx,90+groundplayery,groundplayerz);
    rotateX(PI/2);
    fill(255,0,0);
    strokeWeight(1);
    stroke(0);
    ellipse(0,0,10,10);
    popMatrix();
    
    
    pointerx = playerx+300+((-playery/100)-1)*map((mouseY-height/2),-height/2, height/2, 500, -100);
    pointerz = playerz+((-playery/100)-1)*map((mouseX-width/2),-width/2, width/2, -300, 300);
    
    pushMatrix();
    translate(pointerx,95,pointerz);
    rotateX(PI/2);
    fill(#FFFA6A,128);
    noStroke();
    ellipse(0,0,brushsize,brushsize);
    popMatrix();
  }
  
  
  if(lightson){
    pushMatrix();
    tides = lerp(tides,tidechange, 0.001);
    if(tides > 0){
      tidechange = -2;
    }else if(tides < -1){
      tidechange = 1;
    }
    translate(0,120+tides,0);
    rotateX(PI/2);
    fill(#2767CB,128);
    noStroke();
    rect(0,0,w,h);
    popMatrix();
  }
  
  translate(0,100,0);
  if(lightson){
    noStroke();
  }else{
    noFill();
    stroke(255,50);
    strokeWeight(1);
  }
  
  for (int z = 0; z < cols-1; z++) {
    beginShape(TRIANGLE_STRIP);
        randomSeed(z);
    for (int x = 0; x < rows; x++) {
      int grass = int(random(3));
      if(lightson){
        if(terrain[x][z] < -250){
          fill(255);
        }else if(terrain[x][z] < -200){
          fill(100);
        }else if(terrain[x][z] > 5){
          fill(#5A4B13);
        }else if(terrain[x][z] > 0){
          fill(#4D6701);
        }else{
          if(grass == 2){
            fill(#129519);
          }else if(grass == 1){
            fill(#109318);
          }else{
            fill(#13A01B);
          }
        }
      }
      //if(z%2 == 0){
      //  vertex(x*spacing, terrain[x][z], z*spacing);
      //  vertex(x*spacing+spacing/2, terrain[x][z+1], (z+1)*spacing);
      //}else{
      //  vertex(x*spacing, terrain[x][z+1], (z+1)*spacing);
      //  vertex(x*spacing+spacing/2, terrain[x][z], (z)*spacing);
      ////rect(x*scl, y*scl, scl, scl);
      //}
      vertex(x*spacing, terrain[x][z], z*spacing);
      grass = int(random(3));
      if(lightson){
        if(terrain[x][z] < -250){
          fill(255);
        }else if(terrain[x][z] < -200){
          fill(100);
        }else if(terrain[x][z] > 5){
          fill(#5A4B13);
        }else if(terrain[x][z] > 0){
          fill(#4D6701);
        }else{
          if(grass == 2){
            fill(#129519);
          }else if(grass == 1){
            fill(#109318);
          }else{
            fill(#13A01B);
          }
        }
      }
      vertex(x*spacing, terrain[x][z+1], (z+1)*spacing);
    }
    endShape();
  }
  if (raiseterrain == true){
    raisepoints(pointerx, pointerz);
  }
  if (lowerterrain == true){
    lowerpoints(pointerx, pointerz);
  }
}

void raisepoints(float pointerx, float pointerz){
  //println(int((pointerz - brushsize/2)/spacing));
  //print("(",pointerz, ", ", pointerx,")");
  if(pointerx > brushsize/2 && pointerx < h - brushsize/2 && pointerz > brushsize/2 && pointerz < w - brushsize/2){
    for (int z = int((pointerz - brushsize/2)/spacing); z < int((pointerz + brushsize/2)/spacing); z++) {
      for (int x = int((pointerx - brushsize/2)/spacing); x < int((pointerx + brushsize/2)/spacing); x++) {
        float disttobrush = dist(x,z,int(pointerx/spacing),int(pointerz/spacing));
        if(disttobrush <= brushsize/(2*spacing)){
          float raiseamount = brushsize/(2*spacing)-disttobrush;
          terrain[x][z] = terrain[x][z] - 3*raiseamount;
        }
      }
    }
  }
}
void lowerpoints(float pointerx, float pointerz){
  if(pointerx > brushsize/2 && pointerx < h - brushsize/2 && pointerz > brushsize/2 && pointerz < w - brushsize/2){
    for (int z = int((pointerz - brushsize)/spacing); z < int((pointerz + brushsize/2)/spacing); z++) {
      for (int x = int((pointerx - brushsize)/spacing); x < int((pointerx + brushsize)/spacing); x++) {
        float disttobrush = dist(x,z,int(pointerx/spacing),int(pointerz/spacing));
        if(disttobrush <= brushsize/(2*spacing)){
          float raiseamount = brushsize/(2*spacing)-disttobrush;
          terrain[x][z] = terrain[x][z] + 3*raiseamount;
        }
      }
    }
  }
}

void movegroundCamera(){
  float speed = 0.1;
  float playerroty = map(mouseX,0,width,-PI,PI);
  float playerrotxz = map(mouseY,0,height,PI-0.01,0);
  if(isLeft){
    groundplayerz = groundplayerz + speed*sin(3*PI/2+playerroty);
    groundplayerx = groundplayerx + speed*cos(3*PI/2+playerroty);
  }
  if(isRight){
    groundplayerz = groundplayerz + speed*sin(PI/2+playerroty);
    groundplayerx = groundplayerx + speed*cos(PI/2+playerroty);
  }
  if(isDown){
    groundplayerx = groundplayerx - speed*cos(playerroty);
    groundplayerz = groundplayerz - speed*sin(playerroty);
  }
  if(isUp){
    groundplayerx = groundplayerx + speed*cos(playerroty);
    groundplayerz = groundplayerz + speed*sin(playerroty);
  }
  //if(isRise){
  //  playery = playery - 10;
  //}
  //if(isFall){
  //  playery = playery + 10;
  //}
  int camerax = int(groundplayerx/spacing);
  int cameraz = int(groundplayerz/spacing);
  if(groundplayerx-((camerax+1)*spacing) > -(groundplayerz-(cameraz*spacing))){
    //a : terrain[camerax+1][cameraz+1]
    //b : terrain[camerax+1][cameraz]
    //c : terrain[camerax][cameraz+1]
    float a = (terrain[camerax][cameraz+1]-terrain[camerax+1][cameraz+1])*spacing;
    float b = spacing*spacing;
    float c = spacing*(terrain[camerax+1][cameraz]-terrain[camerax+1][cameraz+1]);
    float d = -(a*(camerax+1)*spacing+b*terrain[camerax+1][cameraz+1]+c*(cameraz+1)*spacing);
    groundplayery = (a*groundplayerx+c*groundplayerz+d)/-b;
  }else{
    //a : terrain[camerax][cameraz]
    //b : terrain[camerax+1][cameraz]
    //c : terrain[camerax][cameraz+1]
    float a = (terrain[camerax+1][cameraz]-terrain[camerax][cameraz])*spacing;
    float b = -spacing*spacing;
    float c = spacing*(terrain[camerax][cameraz+1]-terrain[camerax][cameraz]);
    float d = -(a*camerax*spacing+b*terrain[camerax][cameraz]+c*cameraz*spacing);
    groundplayery = (a*groundplayerx+c*groundplayerz+d)/-b;
  }
  camera(groundplayerx, groundplayery+99.9, groundplayerz, groundplayerx+cos(playerroty)*sin(playerrotxz), groundplayery+99.9+cos(playerrotxz), groundplayerz+sin(playerroty)*sin(playerrotxz), 0,1,0);
}

void moveCamera(){
  if(isLeft){
    playerz = playerz - 10;
  }
  if(isRight){
    playerz = playerz + 10;
  }
  if(isDown){
    playerx = playerx - 10;
  }
  if(isUp){
    playerx = playerx + 10;
  }
  if(isRise){
    playery = playery - 10;
  }
  if(isFall){
    playery = playery + 10;
  }
  
  camera(playerx, playery, playerz, playerx + 1, playery + 1, playerz, 0,1,0);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    raiseterrain = true;
    raisepoints(pointerx, pointerz);
  }else if (mouseButton == RIGHT) {
    lowerterrain = true;
    lowerpoints(pointerx, pointerz);
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    raiseterrain = false;
  }else if (mouseButton == RIGHT) {
    lowerterrain = false;
  }else if (mouseButton == CENTER){
    lightson = !lightson;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  if(e > 0){
    brushsize = brushsize + 20;
  }else{
    brushsize = brushsize - 20;
  }
  if(brushsize < 0){
    brushsize = 0;
  }else if(brushsize > w || brushsize > h){
    brushsize = min(w,h);
  }
}

void keyPressed() {
  if(keyCode == 'X'){
    moveground = !moveground;
  }else if(keyCode == 'Z'){
     lightson = !lightson;
  }else{
    setMove(keyCode, true);
  }
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

  case 87: //w
    return isUp = b;
 
  case 83: //s
    return isDown = b;
 
  case 65: //a
    return isLeft = b;
 
  case 68: //d
    return isRight = b;
    
  case 81: //q
    return isFall = b;
    
  case 69: //e
    return isRise = b;
  
  case 67: //c
    for (int z = 0; z < cols; z++) {
      for (int x = 0; x < rows; x++) {
        terrain[x][z] = 0;
      }
    }

  default:
    return b;
  }
}
