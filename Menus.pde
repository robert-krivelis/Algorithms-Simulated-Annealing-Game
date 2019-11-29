//This code is literal spaghetti and I'm sorry

//These are all global rectangles.
float [] rect1, rect2, rect3;
float w = 1200, h = 600;
float []rect4= {w/2, h-50, 200, 80, 7};
float []rect5 ={0, 0, 0, 0};
float []rect6 ={0, 0, 0, 0};
float []rect7={0, 0, 0, 0};
float []rect8= {w/2, h-60, 70, 35, 7};
float []rect9= {w/2, h-20, 70, 35, 7};
String result;

boolean overButton(int dimensions[]) {
  /* Input: int [] of a rectangle
   Return Value: True or False of if the mouse is placed on the rectangle */
  if (mouseX >= dimensions[0]-dimensions[2]/2 && mouseX <= dimensions[0] + dimensions[2]/2 && 
    mouseY >= dimensions[1]-dimensions[3]/2 && mouseY <= dimensions[1]+dimensions[3]/2) 
    return true;
  else 
  return false;
}

void instruction_screen() { //Sets up very first screen with instructions/story
  background(bg_color);
}

void draw_instruction_screen() { //Draws very first screen with instructions/story
  background(bg_color);
  rectMode(CENTER);
  fill(255);
  rect(rect4[0], rect4[1], rect4[2], rect4[3], brad);
  hover();
  fill(0);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Continue", w/2, h-55);

  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("Agency FB Bold", 64));
  textSize(40);
  text("Student Seperation Instructions", w/2, 50);
  textFont(createFont("Georgia", 32));
  textSize(20);
  text("You are an overworked teacher in Calgary.\n\nAdministration has hired an additional teacher to teach half of your class.\n\nYou are given the task of seperating your students into two equally sized classrooms while\nnot breaking up the strong friendships that have formed in your classroom over the years.\n\nCan you sort your kids better than the computer does before the deadline hits?\n\nMake students happy by grouping them with their friends!\nMake teachers happy by having equally sized classrooms!\nGet the best overall score before the timer runs out!", w/2, h/2-20);
  if (game_modifier ==1) {
    fill(175, 0, 0);
    text("Some students distract the whole class when paired together, so keep them apart to get the most happiness!", w/2, h-120);
  }
  drawnames();
}

//***Hover functions used for changing colours of buttons when hovered over with the mouse.

color hovercol = #FFCF9C ;
int hovrad = 3;
void hover() { //Changes buttons based on if you are hovering above them or not
  fill(hovercol);
  if (overButton(int(rect4)) && (state == 3 || state == 4|| state == 5|| state == 6|| state == -1)) {
    rect(rect4[0], rect4[1], rect4[2], rect4[3], hovrad);
  } else if (overButton(int(rect1)) && (state == 2 || state == 0)) {
    rect(rect1[0], rect1[1], rect1[2], rect1[3], hovrad);
  } else if (overButton(int(rect2)) && (state == 2 || state == 0)) {
    rect(rect2[0], rect2[1], rect2[2], rect2[3], hovrad);
  } else if (overButton(int(rect3)) && (state == 2 || state == 0)) {
    rect(rect3[0], rect3[1], rect3[2], rect3[3], hovrad);
  } else if (overButton(int(rect5)) && (state == 2 || state == 0)) {
    rect(rect5[0], rect5[1], rect5[2], rect5[3], hovrad);
  } else if (overButton(int(rect6)) && (state == 2 || state == 0)) {
    rect(rect6[0], rect6[1], rect6[2], rect6[3], hovrad);
  } else if (overButton(int(rect7)) && (state == 2 || state == 0)) {
    rect(rect7[0], rect7[1], rect7[2], rect7[3], hovrad);
  } else if (overButton(int(rect8)) && (state == 1)) {//pause
    if (paused) {
      fill(#9FC6DD);
      rect(rect8[0], rect8[1], rect8[2], rect8[3], hovrad);
      fill(0);
      textSize(14);
      text("Unpause", rect8[0], rect8[1]);
    } else {
      rect(rect8[0], rect8[1], rect8[2], rect8[3], hovrad);
      fill(0);
      textSize(18);
      text("Pause", rect8[0], rect8[1]);
    }
  } else if (overButton(int(rect9)) && (state == 1)) {//finish
    rect(rect9[0], rect9[1], rect9[2], rect9[3], hovrad);
  }
}

int brad = 7;
void setupselectionmenu() { //Sets up menu where you can select different play styles
  rect1 = new float[4];
  rect2 = new float[4];
  rect3 = new float[4];
  rect1[0] = w/2;
  rect1[1] = h*2/5;
  rect1[2] = w*0.7;
  rect1[3] = h*0.15; 

  rect2[0] = w/2;
  rect2[1] = h*3/5;
  rect2[2] = w*0.7;
  rect2[3] = h*0.15; 

  rect3[0] = w/2;
  rect3[1] = h*4/5;
  rect3[2] = w*0.7;
  rect3[3] = h*0.15;
}
color buttoncol = #FEFFE8;
void drawmenu() { //Draws menu where you can select different play styles
  background(bg_color);
  fill(buttoncol );
  rectMode(CENTER);
  rect(rect1[0], rect1[1], rect1[2], rect1[3], brad);
  rect(rect2[0], rect2[1], rect2[2], rect2[3], brad);
  rect(rect3[0], rect3[1], rect3[2], rect3[3], brad);
  hover();
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("Agency FB Bold", 64));
  textSize(80);
  fill(255);
  text("Student Separation", w/2 + 3, 100 + 3);
  fill(0);
  text("Student Separation", w/2, 100);
  textFont(createFont("Georgia", 32));
  textSize(32);
  text("1. Seperate kids based on friendships", rect1[0], rect1[1]); //Add difficulties
  text("2. Seperate kids who distract each other", rect2[0], rect2[1]);
  text("3. Customize simulated annealing", rect3[0], rect3[1]);
  drawnames();
}



void setupselectionmenu_d() { //Sets up difficulty menu
  rect5 = new float[4];
  rect6 = new float[4];
  rect7 = new float[4];
  rect5[0] = w/2;
  rect5[1] = h*2/5;
  rect5[2] = w*0.7;
  rect5[3] = h*0.15; 
  rect6[0] = w/2;
  rect6[1] = h*3/5;
  rect6[2] = w*0.7;
  rect6[3] = h*0.15; 
  rect7[0] = w/2;
  rect7[1] = h*4/5;
  rect7[2] = w*0.7;
  rect7[3] = h*0.15;
}
void drawmenu_d() { //Draws difficulty menu
  background(bg_color);
  fill(buttoncol);
  rectMode(CENTER);
  rect(rect5[0], rect5[1], rect5[2], rect5[3], brad);
  rect(rect6[0], rect6[1], rect6[2], rect6[3], brad);
  rect(rect7[0], rect7[1], rect7[2], rect7[3], brad);
  hover();
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("Agency FB Bold", 64));
  textSize(64);
  text("Select Difficulty", w/2, 100);
  textFont(createFont("Georgia", 32));
  textSize(32);
  text("1. Easy", rect5[0], rect5[1]); //Add difficulties
  text("2. Medium", rect6[0], rect6[1]);
  text("3. Hard", rect7[0], rect7[1]);
  drawnames();
}



void drawnames() { //Draws our names! We did this
  textFont(createFont("Georgia", 32));
  textSize(14);
  fill(50);
  textAlign(RIGHT, BOTTOM);
  text("ENCM PROJECT PHASE 2\n LUKE RENAUD - ROBERT KRIVELIS", w-15, h-15);
  rectMode(CORNER);
}

void draw_input_screen() { //Draws very first screen with instructions/story
  background(bg_color);
  rectMode(CENTER);
  fill(buttoncol);
  rect(rect4[0], rect4[1], rect4[2], rect4[3], brad);
  hover();
  fill(0);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Start", w/2, h-55);
}

void keyPressed() { //Checks for key presses for the input custom settings screen
  if (result.length()<25) {
    if (false) {
    } else if (key == '2') { //rob pls, why does this start with 2?
      result +='2';
    } else if (key == '1') {
      result +='1';
    } else if (key == '3') {
      result +='3';
    } else if (key == '4') {
      result +='4';
    } else if (key == '5') {
      result +='5';
    } else if (key == '6') {
      result +='6';
    } else if (key == '7') {
      result +='7';
    } else if (key == '8') {
      result +='8';
    } else if (key == '9') {
      result +='9';
    } else if (key == '0') {
      result +='0';
    } else if (key == ',') {
      result +=',';
    } else if (key == '.') {
      result +='.';
    } else if (key == BACKSPACE) {
      if (result.length()>0) {
        result = result.substring(0, result.length()-1);
      }
    } else if (key == ENTER) { //continue
      result +=',';
      convertinput();
      state = 1;
      needs_setup = true;
    }
  }
}

void convertinput() { //Converts string in the text box of custom game setup to usable game values
  int comma_index = 0;
  String temp;
  for (int i=0; i<6; i++) {
    comma_index=0;
    while (result.charAt(comma_index) != ',' || result.charAt(comma_index) != result.charAt(result.length()-1)) {
      comma_index++;
    }
    temp = result.substring(0, comma_index);
    result = result.substring(comma_index+1);
    switch (i) {
    case 0:
      number_of_nodes = int(temp);
      break;
    case 1:
      T_initial_p = float(temp); //Initial temperature for simulated annealing
      break;
    case 2:
      T_min_p = float(temp); //Minimum temperature for simulated annealing
      break;
    case 3:
      cooling_rate = float(temp); //How fast the temperature lowers, lower = faster. 
    case 4:
      game_modifier = int(temp);
      break;
    case 5:
      timer_modifier = float(temp); //lower is slower
    }
  }
}
color pauscol = #FFC53A;
void drawpause() { //this is the pause button

  fill(pauscol);
  rectMode(CENTER);
  rect(rect8[0], rect8[1], rect8[2], rect8[3], 7);
  hover();
  fill(0);
  textSize(18);
  text("Pause", rect8[0], rect8[1]);

  if (paused) {
    fill(#78A1BB);
    rect(rect8[0], rect8[1], rect8[2], rect8[3], hovrad);
    fill(0);
    textSize(14);
    text("Unpause", rect8[0], rect8[1]);
  }
}

void drawfinish() { //this is the restart button

  fill(pauscol);
  rectMode(CENTER);
  rect(rect9[0], rect9[1], rect9[2], rect9[3], 7);
  hover();
  fill(0);
  textSize(18);
  text("Finish", rect9[0], rect9[1]);
}
void draw_practice() { //INSTRUCTIONS SCREEN TO PRACTICE
  background(bg_color);
  imageMode(CENTER);
  //image(instructions_pic, w/2, h/2-100, 506, 450); 
  imageMode(CORNER);
  rectMode(CENTER);
  fill(buttoncol);
  rect(rect4[0], rect4[1], rect4[2], rect4[3]);
  hover();
  fill(0);
  textFont(createFont("Georgia", 40));
  textAlign(CENTER, CENTER);
  text("Continue", w/2, h-55);

  textFont(createFont("Agency FB Bold", 60));
  text("Practice moving students!", w/2, 55);
  //DRAWS PLAY AREA
  rectMode(CENTER);
  fill(255);
  rect(screen_x/2, screen_y/2, screen_x/2-100, play_y);
  rectMode(CORNER);
  //DRAWS LETTERS AND LINE
  fill(0);
  textFont(createFont("Georgia", 36));
  text("A", w/2-5*textsize, 150);
  text("B", w/2+5*textsize, 150);
  line(w/2, 100, w/2, 500);
  textSize(20);
  if (calculatecost(practice_nodes)==1) {
    fill(200, 25, 25);
  } else if (calculatecost(practice_nodes)==0) {
    fill(25, 100, 25);
  }
  text("Broken Connections: " + calculatecost(practice_nodes), 150, h/2+50);
  if ((int)(100-abs((calculatebalance(practice_nodes)-50)/50.0)*100.0)==0) {
    fill(200, 25, 25);
  } else if ((int)(100-abs((calculatebalance(practice_nodes)-50)/50.0)*100.0)==100) {
    fill(25, 100, 25);
  }
  text("Balance: " +(int)(100-abs((calculatebalance(practice_nodes)-50)/50.0)*100.0)+ "%", 150, h/2-50);
  //DRAWS NODES TO PRACTICE ON
  drawconnections(practice_nodes);
  drawnodes(practice_nodes);
}

//TO DO: INSTRUCTIONS SCREEN TO WATCH SIM ANNEALING
void draw_sim_demo() {
  background(bg_color);
  imageMode(CENTER);
  //image(instructions_pic, w/2, h/2-100, 506, 450); 
  imageMode(CORNER);
  rectMode(CENTER);
  fill(buttoncol);
  rect(rect4[0], rect4[1], rect4[2], rect4[3]);
  hover();
  fill(0);
  textFont(createFont("Georgia", 20));
  textAlign(CENTER, CENTER);
  text("Try to beat\nSimulated Annealing!", w/2, h-55);

  textFont(createFont("Agency FB Bold", 60));
  text("Watch how simulated annealing works!", w/2, 55);
  //DRAWS PLAY AREA
  rectMode(CENTER);
  fill(255);
  rect(screen_x/2, screen_y/2, screen_x/2-100, play_y);
  rectMode(CORNER);
  //DRAWS LETTERS AND LINE
  fill(0);
  textFont(createFont("Georgia", 36));
  text("A", w/2-5*textsize, 150);
  text("B", w/2+5*textsize, 150);
  line(w/2, 100, w/2, 500);
  drawconnections(sim_nodes);
  drawnodes(sim_nodes);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("Score: " + (int)(COST(sim_nodes))+"%", w/2 + 400, h/2-50);
  textSize(20);
  text("Iteration: " + iteration, w/2 + 400, h/2);
  text("Watch the red circle to see which \nmove was just taken.\n\n If temperature is high, a \nmove is more likely to be taken. \n\nWhen temperature is low, more\niterations happen\nwithout moving a node.", w/2 - 425, h/2);
  text("Current Temperature: " + (nf(100*exp(-avg_delta_cost/T), 1, 2)) + "%", w/2+ 400, h/2+30);
  text("Temperature Minimum: " + nf(T_min_p, 1, 2) + "%", w/2 +400, h/2+60);
}
