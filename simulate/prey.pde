class prey{
  float x,y;
  float dir;
  float speed;
  float age;
  char state; //0 - wandering || 1 - thirsty || 2 - drinking ||
  float sight;
  int tilex, tiley;
  float water;
  float food;
  
  prey(float x, float y, float dir, float speed, float sight){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = speed;
    this.age = 0;
    this.state = '0';
    this.sight = sight;
    this.water = 100;
    this.food = 100;
  }
  
  void move(){
    switch(state){
      case '0':
        dir = (dir + radians(random(-15,15)) + avoidwater(tilesize,cols,rows, terrain, height1,-1))%(2*PI);
        x = x + speed*cos(dir);
        y = y + speed*sin(dir);
        
        if(water < 50){
          state = '1';
        }
        water -= 0.1;
        break;
      case '1':
        dir = (dir + radians(random(-15,15)) + avoidwater(tilesize,cols,rows, terrain, height1,1))%(2*PI);
        x = x + speed*cos(dir);
        y = y + speed*sin(dir);
        water -= 0.1;
        if(terrain[tilex][tiley] > height1){
          state = '2';
        }
        break;
        
      case '2':
        if(water >= 99){
          state = '0';
        }else{
          water += 1;
        }
        break;
        
      default:
        dir = dir + radians(random(-15,15));
        x = x + speed*cos(dir);
        y = y + speed*sin(dir);
        break;
    }
    setcurrenttile(tilesize,cols,rows);
    fill(255);
    text(state,500,20);
  }
  
  void setcurrenttile(int tilesize, int cols, int rows){
    tilex = int((x - width/2)/tilesize + cols/2);
    tiley = int((y - height/2)/tilesize + rows/2);
    //fill(255,0,0,128);
    //rect(width/2+(tilex-cols/2)*tilesize, height/2+(tiley-rows/2)*tilesize, tilesize, tilesize);
  }
  
  float avoidwater(int tilesize, int cols, int rows, float[][] terrain, float height1, int avoid){
    float deflectangle = 0;
    int watertileno = 0;
    PVector deflectvector = new PVector(0,0);
    int tilesight = int(sight/(2*tilesize))+1;
    for(int i = tilex - tilesight; i < tilex + tilesight; i++){
      for(int j = tiley - tilesight; j < tiley + tilesight; j++){
        float disttowater = dist(x,y,width/2+(i-cols/2+0.5)*tilesize,height/2+(j-rows/2+0.5)*tilesize);
        if(disttowater < sight/2+tilesize){
          if(i >= 0 && i < cols && j >= 0 && j < rows){
            if(terrain[i][j] > height1){
              PVector vectortowater = new PVector(width/2+(i-cols/2+0.5)*tilesize-x,height/2+(j-rows/2+0.5)*tilesize-y);
              float vectormag = map(vectortowater.mag(),0,sight/2+tilesize,sight/2+tilesize,0);
              vectortowater.setMag(vectormag);
              deflectvector.add(vectortowater);
              watertileno += 1;
              if(avoid == 1){
                fill(0,255,0,128);
              }else{
                fill(255,0,0,128);
              }
              noStroke();
              rect(width/2+(i-cols/2)*tilesize, height/2+(j-rows/2)*tilesize, tilesize, tilesize);
            }
          }
        }
      }
    }
    if(watertileno > 0){
      PVector movementvector = PVector.fromAngle(dir).setMag(speed*15);
      deflectvector.div(200).limit(sight/2);
      deflectvector.mult(avoid);
      if(avoid == 1){
        deflectvector.mult(map(water,0,50,50,0));
      }
      stroke(0);
      //line(x,y,x+deflectvector.x,y+deflectvector.y);
      //line(x,y,x+movementvector.x,y+movementvector.y);
      deflectvector.add(movementvector);
      deflectangle = deflectvector.heading()-dir;
    }

    return deflectangle;
  }
  
  void display(){
    pushMatrix();
    translate(x,y);
    rotate(dir);
    stroke(0);
    line(0,0,5,0);
    fill(255);
    ellipse(0,0,5+age,5+age);
    fill(#FCF219,128);
    noStroke();
    ellipse(0,0,sight,sight);
    popMatrix();
    
    stroke(255);
    fill(0);
    rect(50,20,200,20);
    fill(#61DEEA);
    rect(50,20,map(water,0,100,0,200),20);
    
    stroke(255);
    fill(0);
    rect(50,60,200,20);
    fill(#FAF09A);
    rect(50,60,map(food,0,100,0,200),20);
  }
}
