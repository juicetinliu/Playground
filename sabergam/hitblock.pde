class hitblock{
  float x, y;
  float hitangle;
  float size;
  color blockcolor = #FF0000;
  
  hitblock(float x, float y, float hitangle, float size){
    this.x = x;
    this.y = y;
    this.hitangle = hitangle;
    this.size = size;
  }
  
  void display(){
    strokeWeight(2);
    stroke(#FFFFFF);
    fill(blockcolor,150);
    pushMatrix();
    translate(x,y);
    rotate(hitangle);
    rect(-size/2,-size/2,size,size,size/10,size/10,size/10,size/10);
    fill(#FFFFFF,158);
    triangle((5*size-size)/10,(5*size-size)/10,size/10,0,(5*size-size)/10,(size-5*size)/10);
    popMatrix();
  }
  
  void destroy(){
    blockcolor = #00FF00;
    display();
  }
    
  
  boolean hit(){
    //if(mouseX < x + size/2 && mouseX > x - size/2 && mouseY < y + size/2 && mouseY > y - size/2){
    //  float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
    //  if(mouseY != pmouseY && mouseX != pmouseX && mouseang < PI + radians(30) && mouseang > PI - radians(30)){
    //    stroke(255);
    //    strokeWeight(3);
    //    fill(255,128);
    //    ellipse(mouseX,mouseY,50,50);
    //    return true;
    //  }else{
    //    return false;
    //  }
    //}else{
    //  return false;
    //}
    
    
    if(mouseX == pmouseX && mouseY == pmouseY){
      return false;
    }else{
      float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
      text(mouseang, mouseX+10, mouseY+10);
      if(hitangle == 0 || hitangle == PI/2 || hitangle == PI || hitangle == PI*3/2 ){
        if(mouseX < x + size/2 && mouseX > x - size/2 && mouseY > y - size/2 && mouseY < y + size/2){
          if(hitangle == 0){
            if(pmouseX > x + size/2){
              if(mouseang <= PI && mouseang > PI - radians(30) || mouseang >= -PI && mouseang < -PI + radians(30)){
                return true;
              }else{
                return false;
              }
            }else{
              return false;
            }
          }else if(hitangle == PI/2){
            if(pmouseY > y + size/2){
              if(mouseang <= -PI/2 + radians(30) && mouseang >= -PI/2 - radians(30)){
                return true;
              }else{
                return false;
              }
            }else{
              return false;
            }
          }else if(hitangle == PI){
            if(pmouseX < x - size/2){
              if(mouseang <= radians(30) && mouseang >= -radians(30)){
                return true;
              }else{
                return false;
              }
            }else{
              return false;
            }
          }else if(hitangle == PI*3/2){
            if(pmouseY < y - size/2){
              if(mouseang <= PI/2 + radians(30) && mouseang >= PI/2 - radians(30)){
                return true;
              }else{
                return false;
              }
            }else{
              return false;
            }
          }else{
            return false;
          }
        }else{
          return false;
        }
      }else{
        if(mouseY < y-x*tan(hitangle)+mouseX*tan(hitangle) + size/(2*cos(hitangle)) && mouseY > y-x*tan(hitangle)+mouseX*tan(hitangle) - size/(2*cos(hitangle))){
          if(mouseY > x/tan(hitangle) + y - mouseX/tan(hitangle) - size/(2*sin(hitangle)) && mouseY < x/tan(hitangle) + y - mouseX/tan(hitangle) + size/(2*sin(hitangle))){
          //if(pmouseX > x + size/2){
          //  if(mouseang < PI && mouseang > PI - radians(30) || mouseang > -PI && mouseang < -PI + radians(30)){
              return true;
          //  }else{
          //    return false;
          //  }
          //}else{
          //  return false;
          //}
          }else{
            return false;
          }
        }else{
          return false;
        }
      }
    }
  }
    
}
