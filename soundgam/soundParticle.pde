class soundParticle{
  float x, y;
  float angle, speed;
  float size;
  int life;
  int traildecay;
  int maxlife;
  ArrayList<PVector> trail = new ArrayList<PVector>();
  
  soundParticle(float x, float y, float angle, float speed, float size, int life, int traildecay){
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.speed = speed;
    this.size = size;
    this.life = life;
    this.maxlife = life;
    this.traildecay = traildecay;
    trail.add(new PVector(x,y));
  }
  
  void display(){
    noStroke();
    fill(255,map(life,0,maxlife,0,255));
    for(PVector trailpart:trail){
      ellipse(trailpart.x,trailpart.y,size,size);
    }
  }
  
  void move(){
    if(speed > 1){
      for(int j = 1; j < speed; j++){
        float spacingx = x + j*cos(angle);
        float spacingy = y + j*sin(angle);
        trail.add(new PVector(spacingx, spacingy));
      }
    }
    x = x + speed*cos(angle);
    y = y + speed*sin(angle);
    trail.add(new PVector(x,y));
    
    if(trail.size() > traildecay){
      for(int i = 0; i < trail.size()-traildecay; i++){
        trail.remove(0);
      }
    }
  }
  
  boolean ageparticle(){
    life = life - 1;
    if(life == 0){
      return true;
    }else{
      return false;
    }
  }
  
  void bounce(float wallp1x, float wallp1y, float wallp2x, float wallp2y){
    float slopebax = wallp2x-wallp1x;
    float slopebay = wallp2y-wallp1y;
    
    float m = slopebay/slopebax;
     
    float n = tan(angle);
    float c = wallp1y - wallp1x*m;
    float d = y - x*n;
    float bouncex = (-c + d)/(m - n);
    float bouncey = (d*m - c*n)/(m - n);
    if(abs(slopebax) < 1){
      bouncex = (wallp2x+wallp1x)/2;
      bouncey = n*bouncex + d;
      if(dist(x,y,bouncex,bouncey) <= speed && bouncex < max(wallp1x,wallp2x)+1 && bouncex > min(wallp1x,wallp2x)-1 && bouncey < max(wallp1y,wallp2y) && bouncey > min(wallp1y,wallp2y)){
        angle = PI + angle - 2*(angle);
      }
    }else{
        
      //stroke(255,0,0);
      //fill(255,0,0);
      //ellipse(bouncex,bouncey,10,10);
  
      //line(x,y,x+10*speed*cos(angle),y+10*speed*sin(angle));
      float wallangle = atan2(wallp2x-wallp1x,wallp1y-wallp2y);
      //line(bouncex,bouncey,bouncex+10*cos(wallangle),bouncey+10*sin(wallangle));
      //float tobounce = atan2((bouncey-y),(bouncex-x));
      //stroke(255,0,0);
      //line(bouncex,bouncey,bouncex+20*cos(tobounce),bouncey+20*sin(tobounce));
      //if(tobounce%(2*PI) > angle - 10 && tobounce%(2*PI) < angle + 10){
      //  stroke(255);
      //  line(bouncex,bouncey, x, y);
      if(dist(x,y,bouncex,bouncey) <= speed && bouncex < max(wallp1x,wallp2x) && bouncex > min(wallp1x,wallp2x) && bouncey < max(wallp1y,wallp2y) && bouncey > min(wallp1y,wallp2y)){
        angle = PI + angle + 2*(wallangle - angle);
      }
    }
  } 
}
