class Planet {
  float radius;
  float x,y,z;
  int r,g,b;
  Planet(float x, float y, float z, float rad, int r, int g, int b){
    this.radius = rad;
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  void drawPlanet(){
    pushMatrix();
    translate(x,y,z);
    noStroke();
    fill(r,g,b);
    sphere(radius);
    popMatrix();
  }
  
}
