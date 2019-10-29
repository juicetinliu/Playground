class item{
  PVector loc;
  float pickrad, itemsize;
  color itemc;
  boolean picked = false;
  int picktime;
  float animx, animy;
  
  item(float locx, float locy, float pickrad, float itemsize, color itemc){
    this.loc = new PVector(locx,locy);
    this.pickrad = pickrad;
    this.itemc = itemc;
    this.itemsize = itemsize;
    animx = loc.x;
    animy = loc.y;
    picktime = 50;
  }
  
  void display(float newx, float newy, float scale, boolean pickupring){
    if(newx < 0 && newy < 0){
      pushMatrix();
      translate(width/2, height/2);
      noStroke();
      fill(itemc);
      ellipse(loc.x, loc.y, itemsize, itemsize);
      if(pickupring){
        stroke(itemc,50);
        strokeWeight(1);
        noFill();
        ellipse(loc.x, loc.y, pickrad, pickrad);
      }
      popMatrix();
    }else{
      noStroke();
      fill(itemc);
      ellipse(newx, newy, itemsize*scale, itemsize*scale);
      if(pickupring){
        stroke(itemc,50);
        strokeWeight(1);
        noFill();
        ellipse(newx, newy, pickrad*scale, pickrad*scale);
      }
    }
  }
  
  boolean pickanimation(PVector player){
    if(picktime > 0){
      animx = lerp(animx, player.x, 0.5);
      animy = lerp(animy, player.y, 0.5);
      
      display(animx+width/2, animy+height/2, picktime/50, false);
      picktime -= 1;
      return false;
    }else{
      return true;
    }
  }
  
  void picked(PVector player){
    if(player.dist(loc) < pickrad/2){
      picked = true;
    }
    //}else{
    //  picked = false;
    //}
  }
  
}
