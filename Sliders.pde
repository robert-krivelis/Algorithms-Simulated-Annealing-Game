// array to hold all sliders
//Using sliders created from a forum post: https://forum.processing.org/two/discussion/6783/making-a-slider
int instancenum = 2;
Test[] instances =  new Test[instancenum]; 
String nodetext, temptext;

//for (int i = 0; i<instancenum; i++){
// intances[i].x =  
//}
void mouseReleased() {

  //unlock
  if (state==4) {
    String[] templist = split(result, ',');
    int i = 0;
    for (Test t : instances)
    {
      t.lock = false;
    }
    result = ""; // i"m tired, please find a better way 
    result += nodetext;
    result += ',';
    result += temptext;
    result += ',';
    i=2;
    while (i<6) {
      result += templist[i];
      result += ',';
      i++;
    }
  }
  if (state==1) { 
    check_y_collisions(nodes);
    node_locked = false;
    if (nodes[locked_node].x>midp1) {
      nodes[locked_node].partition = 'b';
    }
    if (nodes[locked_node].x<midp1) {
      nodes[locked_node].partition = 'a';
    }
  }
  else if (state==5) {
    check_y_collisions(practice_nodes);
    node_locked = false;
    if (practice_nodes[locked_node].x>w/2) {
      practice_nodes[locked_node].partition = 'b';
    }
    if (practice_nodes[locked_node].x<w/2) {
      practice_nodes[locked_node].partition = 'a';
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
  int ID;


  //constructors

  //default
  Test () {
  }

  Test (float _x, float _y, float _w, float _h, int _ID) {

    x=_x;
    y=_y;
    initialY = y;
    w=_w;
    h=_h;
    ID = _ID;
  }


  void run() {
    int maptop, mapbot; 
    maptop = mapbot = 0;
    textSize(12);
    fill(0);
    if (ID == 0) {
      maptop = 25; // for nodes the highest num is 25 
      mapbot = 1;
      text("Nodes", x+20, initialY-20);
    } else if (ID == 1) {
      maptop = 99; //for temp the highest number is 99
      mapbot = 0;
      text("Initial \n  temp", x+20, initialY-20);
    }


    // bad practice have all stuff done in one method...
    float lowerY = height - h - initialY; // size of window - h - initial Y

    // map value to change color..
    float value = map(y, initialY, lowerY, 120, 255);

    // map value to display
    float value2 = map(value, 120, 255, maptop, mapbot);
    if (ID == 0) {
      nodetext = str((int) value2); //I hate that this works, but it does for removing numbers after the decimal
    } else if (ID == 1) {
      temptext = str((int) value2);
    }

    //set color as it changes
    color c = color(value);
    fill(c);
    rectMode(CORNER);
    // draw base line
    noStroke();
    lowerY -= initialY;
    rect(x, initialY, 4, lowerY + h);
    stroke(0);
    // draw knob
    fill(200);
    rect(x, y, w, h);

    // display text
    fill(0);
    textSize(12);
    text(int(value2), x+20, y+15);

    //get mouseInput and map it
    float my = constrain(mouseY, initialY, height - h - initialY );
    if (lock) y = my;
  }

  // is mouse over knob?
  boolean isOver()
  {
    return (x+w >= mouseX) && (mouseX >= x) && (y+h >= mouseY) && (mouseY >= y);
  }
}


//end of class
