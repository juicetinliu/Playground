import java.awt.AWTException;
import java.awt.Robot;
import java.awt.event.InputEvent;

int xx=0, yy=0;
Robot robby;

void setup()
{
  size(1280, 800);
  try
  {
    robby = new Robot();
  }
  catch (AWTException e)
  {
    println("Robot class not supported by your system!");
    exit();
  }
}

void draw()
{
  background(255);
  float deltx, delty;
  //useless();
  deltx = mouseX-pmouseX;
  delty = mouseY-pmouseY;
  if(mouseX < 50){
    robby.mouseMove(1230, mouseY+44);
    deltx = 0;
  }else if(mouseX > 1230){
    robby.mouseMove(50, mouseY+44);
    deltx = 0;
  }

  if(mouseY < 50){
    robby.mouseMove(mouseX, 694);
    delty = 0;
  }else if(mouseY > 650){
    robby.mouseMove(mouseX, 94);
    delty = 0;
  }
  playerroty = playerroty + radians(deltx);
  fill(0);
  textSize(32);
  text(deltx,25,25);
  text(delty,25,50);
  
}


void useless(){
  //xx = int(random(1280));
  //yy = int(random(500));

  //// Might need to confine to sketch's window...
  if(xx != 403){
    xx = xx + 1;
    if(yy != 161){
      yy = yy + 1;
    }
  }
  robby.mouseMove(xx, yy);
  if(xx == 403 && yy == 161){
    print("clicking");
    robby.mousePress(InputEvent.BUTTON1_MASK);
    robby.delay(75);
    robby.mouseRelease(InputEvent.BUTTON1_MASK);
    robby.delay(75);
  }
}
