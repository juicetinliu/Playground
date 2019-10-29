class soundParticle{
  float startx, starty;
  float angle, len;
  float size;
  ArrayList<PVector> path = new ArrayList<PVector>();
  ArrayList<PVector> displaytrail = new ArrayList<PVector>();
  float lenleft;
  int lastwall = -1;
  int bounces = 0;
  
  soundParticle(float x, float y, float angle, float size, float len){
    this.startx = x;
    this.starty = y;
    this.angle = angle;
    this.size = size;
    path.add(new PVector(x,y));
    float nextx = x + len*cos(angle);
    float nexty = y + len*sin(angle);
    path.add(new PVector(nextx,nexty));
    displaytrail.add(new PVector(x,y));
    this.len = len;
    this.lenleft = len;
    
  }
  
  void display(){
    //strokeWeight(size);
    //stroke(255,120);
    //text(life,trail.get(trail.size()-1).x, trail.get(trail.size()-1).y);
    //for(int l = 0; l < trail.size()-1; l++){
    //  line(trail.get(l).x, trail.get(l).y, trail.get(l+1).x, trail.get(l+1).y);
    //}
    noStroke();
    fill(255,100);
    for(PVector soundtrail:displaytrail){
      ellipse(soundtrail.x,soundtrail.y,size,size);
    }
    //ellipse(path.get(path.size()-2).x,path.get(path.size()-2).y,size,size);
  }
  
  void move(){
    float thisx = path.get(path.size()-1).x;
    float thisy = path.get(path.size()-1).y;
    float nextx = thisx + len*cos(angle);
    float nexty = thisy + len*sin(angle);
    path.clear();
    path.add(new PVector(thisx,thisy));
    path.add(new PVector(nextx,nexty));
    displaytrail.add(new PVector(thisx,thisy));
    lenleft = len;
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
      
      float x3 = path.get(path.size()-2).x;
      float y3 = path.get(path.size()-2).y;
      float x4 = path.get(path.size()-2).x + 10*cos(PI + angle);
      float y4 = path.get(path.size()-2).y + 10*sin(PI + angle);
      
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
      float bouncedist = dist(path.get(path.size()-2).x, path.get(path.size()-2).y, actualbouncex, actualbouncey);
      if(bouncedist < lenleft){
        float x1 = shape.get(wallnumber).x;
        float y1 = shape.get(wallnumber).y;
        float x2 = shape.get((wallnumber+1) % shape.size()).x;
        float y2 = shape.get((wallnumber+1) % shape.size()).y;
        
        float wallangle = atan2(x2-x1,y1-y2);
        angle = PI + angle + 2*(wallangle - angle);
        path.remove(path.size()-1);
        path.add(new PVector(actualbouncex,actualbouncey));
        lenleft = lenleft - bouncedist;
        float leftx = actualbouncex + lenleft*cos(angle);
        float lefty = actualbouncey + lenleft*sin(angle);
        path.add(new PVector(leftx,lefty));
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
