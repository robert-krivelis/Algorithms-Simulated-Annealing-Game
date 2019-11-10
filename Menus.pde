//This code is literal spaghetti and I'm sorry

float [] rect1, rect2, rect3;
float w = 1200, h = 600;
float []rect4= {w/2, h-50, 200, 80};
float [] rect5, rect6, rect7;
String result = "";

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
  rect(rect4[0], rect4[1], rect4[2], rect4[3]);
  hover_i();
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

void hover_i() { //Changes buttons based on if you are hovering above them or not
  if (overButton(int(rect4))) {
    fill(200);
    rect(rect4[0], rect4[1], rect4[2], rect4[3]);
  }
}

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

void drawmenu() { //Draws menu where you can select different play styles
  background(bg_color);
  fill(255);
  rectMode(CENTER);
  rect(rect1[0], rect1[1], rect1[2], rect1[3]);
  rect(rect2[0], rect2[1], rect2[2], rect2[3]);
  rect(rect3[0], rect3[1], rect3[2], rect3[3]);
  hover();
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("Agency FB Bold", 64));
  textSize(64);
  text("Student Seperation", w/2, 100);
  textFont(createFont("Georgia", 32));
  textSize(32);
  text("1. Seperate kids based on friendships", rect1[0], rect1[1]); //Add difficulties
  text("2. Seperate kids who distract each other", rect2[0], rect2[1]);
  text("3. Customize simulated annealing", rect3[0], rect3[1]);
  drawnames();
}

void hover() { //Changes buttons based on if you are hovering above them or not
  if (overButton(int(rect1))) {
    fill(200);
    rect(rect1[0], rect1[1], rect1[2], rect1[3]);
  } else if (overButton(int(rect2))) {
    fill(200);
    rect(rect2[0], rect2[1], rect2[2], rect2[3]);
  } else if (overButton(int(rect3))) {
    fill(200);
    rect(rect3[0], rect3[1], rect3[2], rect3[3]);
  }
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
  fill(255);
  rectMode(CENTER);
  rect(rect5[0], rect5[1], rect5[2], rect5[3]);
  rect(rect6[0], rect6[1], rect6[2], rect6[3]);
  rect(rect7[0], rect7[1], rect7[2], rect7[3]);
  hover();
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("Agency FB Bold", 64));
  textSize(64);
  text("Select Difficulty", w/2, 100);
  textFont(createFont("Georgia", 32));
  textSize(32);
  text("1. Easy - 15 seconds, 5 nodes", rect5[0], rect5[1]); //Add difficulties
  text("2. Medium - 10 seconds, 10 nodes", rect6[0], rect6[1]);
  text("3. Hard - 10 seconds, 15 nodes", rect7[0], rect7[1]);
  drawnames();
}

void hover_d() { //Changes buttons based on if you are hovering above them or not
  if (overButton(int(rect5))) {
    fill(200);
    rect(rect5[0], rect5[1], rect5[2], rect5[3]);
  } else if (overButton(int(rect6))) {
    fill(200);
    rect(rect6[0], rect6[1], rect6[2], rect6[3]);
  } else if (overButton(int(rect7))) {
    fill(200);
    rect(rect7[0], rect7[1], rect7[2], rect7[3]);
  }
}

void drawnames() {
  textFont(createFont("Georgia", 32));
  textSize(14);
  fill(50);
  textAlign(RIGHT, BOTTOM);
  text("ENCM PROJECT PHASE 1\n LUKE RENAUD - ROBERT KRIVELIS", w-15, h-15);
  rectMode(CORNER);
}

void draw_input_screen() { //Draws very first screen with instructions/story
  background(bg_color);
  rectMode(CENTER);
  fill(255);
  rect(rect4[0], rect4[1], rect4[2], rect4[3]);
  hover_i();
  fill(0);
  textSize(40);
  textAlign(CENTER, CENTER);
  text("Continue", w/2, h-55);
}

void keyPressed() {
  if (result.length()<25) {
    if (false) {
    } else if (key == '2') {
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

void convertinput() {
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
