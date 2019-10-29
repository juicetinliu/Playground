float frict = 0.9;
boolean isLeft, isRight, isUp, isDown; 
boolean is1;

player p1;
item firsti;
ArrayList<item> items = new ArrayList<item>();
//color hudcolor = color(0);
PVector camerapos = new PVector(0,0);

int pxoffset = 0;
int pyoffset = 0;

void setup() {
  fullScreen(OPENGL);
  hint(DISABLE_OPTIMIZED_STROKE); //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  p1 = new player(2, color(0,255,255),15,16);
  
  randomSeed(2);
  for(int i = 0; i < 20; i++){
    items.add(new item(random(-450,450), random(-300,250), 100, 20, color(random(255),random(255),random(255))));
  }
}

void draw() {
  background(0);
    
  //playground(,50);
  //playground(p1.pos, isUp,isDown,isLeft,isRight,50, 1);
  for(int n = items.size() - 1; n >= 0; n--){
    item thisitem = items.get(n);
    thisitem.picked(p1.pos);
    if(!thisitem.picked){
      thisitem.display(-1,-1,1, true);
    }else{
      if(!p1.invfull()){
        boolean doneanimation = thisitem.pickanimation(p1.pos);
        //hudcolor = thisitem.itemc;
        if(doneanimation){
          p1.inventory.add(thisitem);
          items.remove(n);
        }
      }else{
        thisitem.display(-1,-1,1, true);
      }
    }
  }
  
  p1.display();
  p1.move(isUp,isDown,isLeft,isRight,frict);
  p1.ability1(is1);
  cameraview(p1.pos, 0.1);
  hud();
  
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
    
  case 49:
    return is1 = b;
    
  default:
    return b;
  }
}
