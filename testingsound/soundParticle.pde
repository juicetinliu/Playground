class soundParticle{
  float startx, starty;
  float angle, len;
  float size;
  ArrayList<PVector> trail = new ArrayList<PVector>();
  float nextx, nexty, lenleft;
  int lastwall = -1;
  int bounces = 0;
  
  soundParticle(float x, float y, float angle, float size, float len){
    this.startx = x;
    this.starty = y;
    this.angle = angle;
    this.size = size;
    trail.add(new PVector(x,y));
    nextx = x + len*cos(angle);
    nexty = y + len*sin(angle);
    trail.add(new PVector(nextx,nexty));
    this.lenleft = len;
  }
  
  void display(){
    strokeWeight(size);
    stroke(255,120);
    //text(life,trail.get(trail.size()-1).x, trail.get(trail.size()-1).y);
    for(int l = 0; l < trail.size()-1; l++){
      line(trail.get(l).x, trail.get(l).y, trail.get(l+1).x, trail.get(l+1).y);
    }
  }
  
  boolean bounce(ArrayList<PVector> shape){
    float bestbounce = width;
    int wallnumber = -1;
    float actualbouncex = 0, actualbouncey = 0;
    for(int s = 0; s < shape.size(); s++){
      float x1 = shape.get(s).x;
      float y1 = shape.get(s).y;
      float x2 = shape.get((s+1) % shape.size()).x;
      float y2 = shape.get((s+1) % shape.size()).y;
      
      float x3 = trail.get(trail.size()-2).x;
      float y3 = trail.get(trail.size()-2).y;
      float x4 = trail.get(trail.size()-2).x + 10*cos(PI + angle);
      float y4 = trail.get(trail.size()-2).y + 10*sin(PI + angle);
      
      float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
      if (den != 0){
        float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
        float u = ((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
        if (t > 0 && t < 1 && u > 0){
          float bouncex = x1 + t * (x2 - x1);
          float bouncey = y1 + t * (y2 - y1);
          float disttobounce = dist(bouncex,bouncey, x3, y3);
          if(disttobounce < lenleft){
            if(disttobounce < bestbounce && lastwall != s){
              bestbounce = disttobounce;
              actualbouncex = bouncex;
              actualbouncey = bouncey;
              wallnumber = s;
            }
          }
        }
      }
    }
    if(wallnumber != -1  && lastwall != wallnumber){
      float bouncedist = dist(trail.get(trail.size()-2).x, trail.get(trail.size()-2).y, actualbouncex, actualbouncey);
      if(bouncedist < lenleft){
        float x1 = shape.get(wallnumber).x;
        float y1 = shape.get(wallnumber).y;
        float x2 = shape.get((wallnumber+1) % shape.size()).x;
        float y2 = shape.get((wallnumber+1) % shape.size()).y;
        
        float wallangle = atan2(x2-x1,y1-y2);
        angle = PI + angle + 2*(wallangle - angle);
        trail.remove(trail.size()-1);
        trail.add(new PVector(actualbouncex,actualbouncey));
        lenleft = lenleft - bouncedist;
        float leftx = actualbouncex + lenleft*cos(angle);
        float lefty = actualbouncey + lenleft*sin(angle);
        trail.add(new PVector(leftx,lefty));
        //ellipse(actualbouncex, actualbouncey, 5,5);
      }
      lastwall = wallnumber;
      //bounces = bounces + 1;
      return true;
    }else{
      return false;
    }
  } 
}
