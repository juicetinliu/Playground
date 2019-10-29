class player{
  float x,y,z;
  float directionxz, directiony;
  float speed;
  float life;
  float maxlife;
  float deltx;
  
  player(float x, float y, float z, float directionxz, float directiony, float speed, float life){
    this.x = x;
    this.y = y;
    this.z = z;
    this.directionxz = directionxz;
    this.directiony = directiony;
    this.speed = speed;
    this.life = life;
    this.maxlife = life;
  }
  
  void updateplayer(boolean forward, boolean backward, boolean left, boolean right, float spacing, float[][] terrain){
    noCursor();
    mousemovement();
    directiony = directiony + radians(deltx/5);
    directionxz = map(mouseY,0,height,PI-0.01,0);
    if(left){
      z = z + speed*sin(3*PI/2+directiony);
      x = x + speed*cos(3*PI/2+directiony);
    }
    if(right){
      z = z + speed*sin(PI/2+directiony);
      x = x + speed*cos(PI/2+directiony);
    }
    if(backward){
      x = x - speed*cos(directiony);
      z = z - speed*sin(directiony);
    }
    if(forward){
      x = x + speed*cos(directiony);
      z = z + speed*sin(directiony);
    }
    
    int camerax = int(x/spacing);
    int cameraz = int(z/spacing);
    if(x-((camerax+1)*spacing) > -(z-(cameraz*spacing))){
      //a : terrain[camerax+1][cameraz+1]
      //b : terrain[camerax+1][cameraz]
      //c : terrain[camerax][cameraz+1]
      float a = (terrain[camerax][cameraz+1]-terrain[camerax+1][cameraz+1])*spacing;
      float b = spacing*spacing;
      float c = spacing*(terrain[camerax+1][cameraz]-terrain[camerax+1][cameraz+1]);
      float d = -(a*(camerax+1)*spacing+b*terrain[camerax+1][cameraz+1]+c*(cameraz+1)*spacing);
      y = (a*x+c*z+d)/-b;
    }else{
      //a : terrain[camerax][cameraz]
      //b : terrain[camerax+1][cameraz]
      //c : terrain[camerax][cameraz+1]
      float a = (terrain[camerax+1][cameraz]-terrain[camerax][cameraz])*spacing;
      float b = -spacing*spacing;
      float c = spacing*(terrain[camerax][cameraz+1]-terrain[camerax][cameraz]);
      float d = -(a*camerax*spacing+b*terrain[camerax][cameraz]+c*cameraz*spacing);
      y = (a*x+c*z+d)/-b;
    }
    camera(x, y+99.9, z, x+cos(directiony)*sin(directionxz), y+99.9+cos(directionxz), z+sin(directiony)*sin(directionxz), 0,1,0);
  }
  
  void terrainmap(color playercolor){
    pushMatrix();
    translate(x,99.9+y,z);
    rotateX(PI/2);
    fill(playercolor);
    strokeWeight(1);
    stroke(0);
    ellipse(0,0,10,10);
    for(int i = 0; i < 100; i++){
      translate(0,0,0.01*i);
      stroke(playercolor,128*(100-i)/100);
      strokeWeight(2);
      noFill();
      ellipse(0,0,10,10);
    }
    popMatrix();
    
    stroke(playercolor);
    strokeWeight(2);
    float viewline = 100;
    line(x,y+99.9,z,x+viewline*cos(directiony)*sin(directionxz), y+99.9+viewline*cos(directionxz), z+viewline*sin(directiony)*sin(directionxz));
  }
  
  void hudmap(color playercolor, float hudx, float hudy, float hudw, float hudh, float size){
    fill(playercolor);
    noStroke();
    float hudpx = map(z,0,w,hudx,hudx+hudw);
    float hudpy = map(x,0,h,hudy+hudh,hudy);
    float trisin = sin(directiony);
    float tricos = cos(directiony);
    triangle(hudpx+(size*1.6)*trisin,hudpy-(size*1.6)*tricos,hudpx+size*tricos,hudpy+size*trisin,hudpx-size*tricos,hudpy-size*trisin);
    //line(hudx,hudy,hudx+hudsize*sin(playerroty),hudy-hudsize*cos(playerroty));
    fill(playercolor);
    ellipse(hudpx,hudpy,size*2,size*2);
  }
  
  void hudmaplife(){
    stroke(0);
    strokeWeight(5);
    noFill();
    rect(width/2-250,50,500,50);
    noStroke();
    fill(255,0,0);
    rect(width/2-249,51,map(life,0,maxlife,0,498),48);
    
    fill(255);
    textAlign(CENTER);
    textSize(26);
    text(int(life),width/2,85);
  }
  
  boolean damageplayer(float damage){
    life = life - damage;
    if(life <= 0){
      return true;
    }else{
      return false;
    }
  }
  void mousemovement(){
    deltx = mouseX - pmouseX;
    if(mouseX < 100){
      robby.mouseMove(width-150, mouseY);
    }else if(mouseX > width-100){
      robby.mouseMove(150, mouseY);
    }
    deltx = deltx % (width-250);
  }
}
