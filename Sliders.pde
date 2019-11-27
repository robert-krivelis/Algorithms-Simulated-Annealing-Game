// array to hold all sliders
//Using sliders created from a forum post: https://forum.processing.org/two/discussion/6783/making-a-slider
int instancenum = 10;
Test[] instances =  new Test[instancenum]; 
for (int i = 0; i<instancenum; i++){
 intances[i].x =  
}
void mouseReleased() {

  //unlock
  if (state==4) {
    for (Test t : instances)
    {
      t.lock = false;
    }
  }
}

class Test {
  //class vars
  float x;
  float y;
  float w, h;
  float initialY;
  boolean lock = false;

  //constructors

  //default
  Test () {
  }

  Test (float _x, float _y, float _w, float _h) {

    x=_x;
    y=_y;
    initialY = y;
    w=_w;
    h=_h;
  }


  void run() {

    // bad practice have all stuff done in one method...
    float lowerY = height - h - initialY - 50;

    // map value to change color..
    float value = map(y, initialY, lowerY, 120, 255);

    // map value to display
    float value2 = map(value, 120, 255, 100, 0);

    //set color as it changes
    color c = color(value);
    fill(c);
    rectMode(CORNER);
    // draw base line
    noStroke();
    rect(x, initialY, 4, lowerY);
    stroke(0);
    // draw knob
    fill(200);
    rect(x, y, w, h);

    // display text
    fill(0);
    textSize(12);
    text(int(value2) +"%", x+20, y+15);

    //get mouseInput and map it
    float my = constrain(mouseY, initialY, height - h - initialY );
    if (lock) y = my;
  }

  // is mouse ove knob?
  boolean isOver()
  {
    return (x+w >= mouseX) && (mouseX >= x) && (y+h >= mouseY) && (mouseY >= y);
  }
}


//end of class
