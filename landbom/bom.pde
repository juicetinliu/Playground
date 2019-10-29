class bom{
  float x,y,z;
  float velx, vely, velz;
  float size;
  float gravity;
  
  bom(float x, float y, float z, float velx, float vely, float velz, float size, float gravity){
    this.x = x;
    this.y = y;
    this.z = z;
    this.velx = velx;
    this.vely = vely;
    this.velz = velz;
    this.size = size;
    this.gravity = gravity;
  }
  
  boolean move(int w, int h, float[][] terrain, float spacing){
    x = x + velx;
    y = y + vely;
    z = z + velz;
    vely = vely + gravity;
    
    int gridx = int(x/spacing);
    int gridz = int(z/spacing);
    float terrainy;
    
    if(z >= w - spacing*2 || z <= spacing*2 || x >= h-spacing*2 || x <= spacing*2){
      return true;
    }else{
      
      if(x-((gridx+1)*spacing) > -(z-(gridz*spacing))){
        //a : terrain[camerax+1][cameraz+1]
        //b : terrain[camerax+1][cameraz]
        //c : terrain[camerax][cameraz+1]
        float a = (terrain[gridx][gridz+1]-terrain[gridx+1][gridz+1])*spacing;
        float b = spacing*spacing;
        float c = spacing*(terrain[gridx+1][gridz]-terrain[gridx+1][gridz+1]);
        float d = -(a*(gridx+1)*spacing+b*terrain[gridx+1][gridz+1]+c*(gridz+1)*spacing);
        terrainy = (a*x+c*z+d)/-b;
      }else{
        //a : terrain[camerax][cameraz]
        //b : terrain[camerax+1][cameraz]
        //c : terrain[camerax][cameraz+1]
        float a = (terrain[gridx+1][gridz]-terrain[gridx][gridz])*spacing;
        float b = -spacing*spacing;
        float c = spacing*(terrain[gridx][gridz+1]-terrain[gridx][gridz]);
        float d = -(a*gridx*spacing+b*terrain[gridx][gridz]+c*gridz*spacing);
        terrainy = (a*x+c*z+d)/-b;
      }
      if(y > terrainy){
        return true;
      }else{
        return false;
      }
    }
    
  }
  
  void display(){
    fill(25);
    noStroke();
    translate(x,y+99.9,z);
    sphere(size);
  }
}
