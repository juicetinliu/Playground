class soundParticle{
  float startx, starty;
  float angle, speed;
  float size;
  int life;
  int maxlife;
  int decaylength;
  ArrayList<PVector> trail = new ArrayList<PVector>();
  float nextx, nexty;
  
  soundParticle(float x, float y, float angle, float speed, float size, int life, int decaylength){
    this.startx = x;
    this.starty = y;
    this.angle = angle;
    this.speed = speed;
    this.size = size;
    this.life = life;
    this.maxlife = life;
    this.decaylength = decaylength;
    trail.add(new PVector(x,y));
    nextx = x + speed*cos(angle);
    nexty = y + speed*sin(angle);
    trail.add(new PVector(nextx,nexty));
  }
  
  void display(){
    strokeWeight(size);
    stroke(255,map(life,0,maxlife,0,255));
    //text(life,trail.get(trail.size()-1).x, trail.get(trail.size()-1).y);
    for(int l = 0; l < trail.size()-1; l++){
      line(trail.get(l).x, trail.get(l).y, trail.get(l+1).x, trail.get(l+1).y);
    }
  }
  
  void move(){
    nextx = trail.get(trail.size()-1).x + speed*cos(angle);
    nexty = trail.get(trail.size()-1).y + speed*sin(angle);
    trail.remove(trail.size()-1);
    trail.add(new PVector(nextx,nexty));
    
  }
  
  boolean ageparticle(){
    life = life - 1;
    if(life < maxlife - decaylength){
      if(dist(trail.get(0).x, trail.get(0).y, trail.get(1).x, trail.get(1).y) < speed){
        trail.remove(0);
      }
      float lastangle = atan2(trail.get(1).y-trail.get(0).y,trail.get(1).x-trail.get(0).x);
      float lastx = trail.get(0).x + speed*cos(lastangle);
      float lasty = trail.get(0).y + speed*sin(lastangle);
      trail.remove(0);
      trail.add(0, new PVector(lastx,lasty));
    }
    if(life <= 0){
      return true;
    }else{
      return false;
    }
  }
  
  void bounce(float x1, float y1, float x2, float y2){
    if(abs(dist(nextx, nexty, x1, y1)) < 10){
        angle = PI + angle;
        trail.remove(trail.size()-1);
        trail.add(new PVector(x1,y1));
        float leftover = speed - dist(nextx, nexty, x1, y1);
        float leftx = nextx + leftover*cos(angle);
        float lefty = nexty + leftover*sin(angle);
        trail.add(new PVector(leftx,lefty));
        //life = 0;
        return;
    }
    float x3 = trail.get(trail.size()-1).x;
    float y3 = trail.get(trail.size()-1).y;
    float x4 = trail.get(trail.size()-1).x + speed*cos(PI + angle);
    float y4 = trail.get(trail.size()-1).y + speed*sin(PI + angle);
    
    float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0){
      return;
    }
    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = ((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
    if (t > 0 && t < 1  && u > 0){
      float bouncex = x1 + t * (x2 - x1);
      float bouncey = y1 + t * (y2 - y1);
      if(abs(dist(nextx, nexty, bouncex, bouncey)) < speed){
        float wallangle = atan2(x2-x1,y1-y2);
        angle = PI + angle + 2*(wallangle - angle);
        trail.remove(trail.size()-1);
        trail.add(new PVector(bouncex,bouncey));
        float leftover = speed - dist(nextx, nexty, bouncex, bouncey);
        float leftx = nextx + leftover*cos(angle);
        float lefty = nexty + leftover*sin(angle);
        trail.add(new PVector(leftx,lefty));
      }
      //ellipse(bouncex, bouncey, 5,5);
    }else{
      return;
    }
  } 
}
