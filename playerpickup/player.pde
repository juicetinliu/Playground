class player{
  PVector pos;
  PVector vel;
  float velx,vely;
  float speed;
  color pcolor;
  float psize;
  int invlim;
  ArrayList<item> inventory = new ArrayList<item>();
  boolean a1used = false;
  
  player(float speed, color pcolor, float psize, int invlim){
    this.pos = new PVector(0,0);
    this.vel = new PVector(0,0);
    this.speed = speed;
    this.pcolor = pcolor;
    this.psize = psize;
    this.invlim = invlim;
  }
  
  void display(){
    pushMatrix();
    translate(width/2, height/2);
    fill(pcolor);
    stroke(255);
    strokeWeight(1);
    ellipse(pos.x, pos.y, psize, psize);
    text(int(pos.x) + "," + int(pos.y), pos.x+10, pos.y);
    popMatrix();
  }
  
  void move(boolean upkey, boolean downkey, boolean leftkey, boolean rightkey, float frict){
    if(leftkey){
      vel.x = -speed;
    }
    if(rightkey){
      vel.x = speed;
    }
    if(downkey){
      vel.y = speed;
    }
    if(upkey){
      vel.y = -speed;
    }
    pos.x = pos.x + vel.x; 
    pos.y = pos.y + vel.y;
    if(!upkey && !downkey){
      smoothyStop(frict);
    }
    if(!leftkey && !rightkey){
      smoothxStop(frict);
    }
  }
  
  void smoothxStop(float frict) {
    if(this.vel.x < 0.001 && this.vel.x > -0.001){
      this.vel.x = 0;
    }else{
      this.vel.x = this.vel.x * frict;
    }
  }
  void smoothyStop(float frict) {
    if(this.vel.y < 0.001 && this.vel.y > -0.001){
      this.vel.y = 0;
    }else{
      this.vel.y = this.vel.y * frict;
    }
  }
  
  //void abilityscroll(boolean space){
    
  void ability1(boolean a1){
    if(a1 && !a1used){
      stroke(255);
      strokeWeight(3);
      noFill();
      line(pos.x+width/2,pos.y+height/2,mouseX,mouseY);
      if(mousePressed && !p1.inventory.isEmpty()){
        item thisitem = p1.inventory.get(0);
        thisitem.loc = new PVector(mouseX-width/2,mouseY-height/2);
        thisitem.picked = false;
        thisitem.picktime = 50;
        thisitem.animx = thisitem.loc.x;
        thisitem.animy = thisitem.loc.y;
        items.add(thisitem);
        p1.inventory.remove(0);
        a1used = true;
      }
    }else if(!mousePressed){
      a1used = false;
    }
  }
  
  boolean invfull(){
    if(inventory.size() >= invlim){
      return true;
    }else{
      return false;
    }
  }
}
