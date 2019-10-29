class xploshn{
  float x,y,z;
  float size;
  float duration;
  xploshn(float x, float y, float z, float size, float duration){
    this.x = x;
    this.y = y;
    this.z = z;
    this.size = size;
    this.duration = duration;
  }
    
  boolean xplod(){
    duration = duration - 1;
    if(duration <= 0){
      return false;
    }else{
      return true;
    }
  }
}
