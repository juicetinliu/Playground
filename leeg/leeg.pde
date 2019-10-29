float playerx, playery;
float playerspeed = 2;
float nextcoorx, nextcoory;
boolean playerreached = true;
boolean qpressed, wpressed, epressed, rpressed;

void setup(){
  fullScreen();
  pixelDensity(displayDensity());
  frameRate(60);
  playerx = width/2;
  playery = height/2;
  nextcoorx = playerx;
  nextcoory = playery;
  
}

void draw(){
  background(255);
  abilityBar();
  fill(#86C9FF);
  if (mousePressed && (mouseButton == RIGHT)) {
    fill(255);
    nextcoorx = mouseX;
    nextcoory = mouseY;
    playerreached = false;
  }
  stroke(0);
  ellipse(playerx, playery, 20,20);
  movePlayer();
  useAbilities();
}

void useAbilities(){
  textSize(26); 
  if(qpressed){
    if(qaim()){
      text("USED Q", playerx, playery);
    }
  }else if(wpressed){
    if(waim()){
      text("USED W", playerx, playery);
    }
  }else if(epressed){
    if(eaim()){
      text("USED E", playerx, playery);
    }
  }else if(rpressed){
    if(raim()){
      text("USED R", playerx, playery);
    }
  }
}

boolean qaim(){
  boolean useq = false;
  if (mousePressed && (mouseButton == LEFT)) {
    useq = true;
  }
  return useq;
}

boolean waim(){
  boolean usew = false;
  if (mousePressed && (mouseButton == LEFT)) {
    usew = true;
  }
  return usew;
}

boolean eaim(){
  boolean usee = false;
  if (mousePressed && (mouseButton == LEFT)) {
    usee = true;
  }
  return usee;
}

boolean raim(){
  boolean user = false;
  if (mousePressed && (mouseButton == LEFT)) {
    user = true;
  }
  return user;
}


void abilityBar(){
  stroke(0);
  strokeWeight(1);
  fill(255);
  rect(width/2-250, height-100, 500, 100);
  for(int i = 0; i < 4; i++){
    fill(255);
    if(qpressed && i == 0){
      fill(128);
    }
    if(wpressed && i == 1){
      fill(128);
    }
    if(epressed && i == 2){
      fill(128);
    }
    if(rpressed && i == 3){
      fill(128);
    }
    rect(width/2-240+90*i, height-90, 80 ,80);
  }
}

void movePlayer(){
  if(!playerreached){
    ellipse(nextcoorx, nextcoory,5,5);
    float deltx = nextcoorx - playerx;
    float delty = nextcoory - playery;
    float anglemove = atan2(delty,deltx);
    playerx = playerx + playerspeed*cos(anglemove);
    playery = playery + playerspeed*sin(anglemove);
    if(dist(playerx,playery,nextcoorx,nextcoory)<playerspeed){
      playerx = nextcoorx;
      playery = nextcoory;
      playerreached = true;
    }
  }
}

void keyPressed() {
  setMove(keyCode, true);
}
 
void keyReleased() {
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case 81:
    return qpressed = b;
 
  case 87:
    return wpressed = b;
 
  case 69:
    return epressed = b;
 
  case 82:
    return rpressed = b;
    
  default:
    return b;
  }
}
