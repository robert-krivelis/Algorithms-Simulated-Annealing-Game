float screen_x = 1200;
float screen_y = 600;
int textsize = 24;
float play_y = screen_y-200;
float play_x = screen_x-200;
float midp1 = screen_x/4;
float midp2 = screen_x*3/4;
int game_started; //For time purposes
color bg_color = #C5F7D9; //Background color kinda like 21D19F
PImage classroom; //Image from https://azpng.com/classroom-clipart-our-we-and-vector-for-clip-art-students-png-13568
PImage classroom_flipped;
float timer;
float [] timer_bar = {screen_x/2, screen_y/2-200, 50, 400};
boolean paused = false; //this is for the pause button
int last_moved = 0;


void drawconnections(node [] nodes) {
  /* Input: node []
   Output: lines drawn between each node and the node it is connected to */
  for (int i=0; i<number_of_nodes; i++) {
    fill(0);
    for (int j=0; j<nodes[i].connections.size(); j++) {
      line(nodes[i].x, nodes[i].y, nodes[nodes[i].connections.get(j)].x, nodes[nodes[i].connections.get(j)].y);
    }
    if (game_modifier ==1) {
      stroke(200, 0, 0);
      for (int j=0; j<nodes[i].anticonnections.size(); j++) {
        line(nodes[i].x, nodes[i].y, nodes[nodes[i].anticonnections.get(j)].x, nodes[nodes[i].anticonnections.get(j)].y);
      }
    }
    stroke(0);
  }
}
void drawsplit() { //Draws the cut between the two partitions  
  line(midp1, 100, midp1, 500);
  line(midp2, 100, midp2, 500);
}

void drawtime() { //Draws red timer bar in the middle of the screen
  rectMode(CORNER);
  fill(255); //12345
  rect(screen_x/2-25, screen_y/2-200, 50, 400);
  fill(230, 50, 50);
  noStroke();
  rect(timer_bar[0]-25, timer_bar[1], timer_bar[2], timer_bar[3]); //Changes the starting point of the bar
  if (timer_bar[1] <screen_y/2-200 + 400) {
    if (!paused) {
      timer_bar[3] = timer_bar[3] - pow((millis()-timer), 0.5)/100*timer_modifier; //Changes the height of the bar
      timer_bar[1] = timer_bar[1] + pow((millis()-timer), 0.5)/100*timer_modifier;
    }
  } else {
    needs_setup = true;
    state = 3; //end of game state
  }
  stroke(0);
}
void draw_end_game_screen() { //Draws the screen once time runs out
  music(1, 0);
  rectMode(CENTER);
  fill(255, 255, 255, 230); //alpha of 230
  rect(screen_x/2, screen_y/2, screen_x-400, screen_y-100);
  textSize(50);
  fill(0);  
  if ((int)(COST(nodes))>=(int)(COST(computer_nodes))) { //if player wins
    text("You win!", screen_x/2, screen_y/2-100);
  } else {//computer wins
    text("Computer wins!", screen_x/2, screen_y/2-100);
  }
  textSize(30);
  text("Your Combined Happiness: " + (int)(COST(nodes))+"%", screen_x/2, screen_y/2-50);
  text("Computer's Combined Happiness: " + (int)(COST(computer_nodes))+"%", screen_x/2, screen_y/2+50);
}

void drawnodes(node[] nodes) {
  /* Input: node []
   Output: Circle of each node is drawn and it's index number */
  for (int i=0; i<number_of_nodes; i++) {
    fill(nodes[i].col);
    circle(nodes[i].x, nodes[i].y, nodes[i].size);
    fill(0);
    circle(nodes[i].x-nodes[i].size*0.2, nodes[i].y-nodes[i].size*0.25, nodes[i].size*0.1); //Draw happy face :)
    circle(nodes[i].x+nodes[i].size*0.2, nodes[i].y-nodes[i].size*0.25, nodes[i].size*0.1);
    noFill();
    arc(nodes[i].x, nodes[i].y, nodes[i].size*0.7, nodes[i].size*0.7, 0, PI);
  }
}


void drawplayarea() { //Draws pink play areas
  background(bg_color);
  rectMode(CENTER);
  fill(255);
  rect(screen_x/4, screen_y/2, screen_x/2-100, play_y);
  fill(255-1/exp(-avg_delta_cost/(T*2.75)), 255-255*exp(-avg_delta_cost/T), 255-255*exp(-avg_delta_cost/T)) ; //Changes color of computer play area based on temp
  rect(screen_x*3/4, screen_y/2, screen_x/2-100, play_y);
  rectMode(CORNER);
}

void drawwords() { //Draws all words on the screen
  fill(0);
  textAlign(CENTER, CENTER);
  textFont(createFont("Agency FB Bold", 40));
  text("Player", midp1, 50);
  text("Simulated Annealing", midp2, 50);
  textFont(createFont("Georgia", 36));
  textSize(14);
  text("A", midp2-5*textsize, 150);
  text("B", midp2+5*textsize, 150);
  text("A", midp1-5*textsize, 150);
  text("B", midp1+5*textsize, 150);
  //Calculate balance is just percentage of nodes that are on the left. 100 - 50-50/50
  textAlign(CENTER, CENTER); 
  text("Net cuts of Player: " +calculatecost(nodes), midp1-125, 550);
  text("Net cuts of Computer: " +calculatecost(computer_nodes), midp2-125, 550);
  text("Happiness of Students: " +(100-calculatecost(nodes)*10)+ "%", midp1-100, 570); //%error is (e-t)/t
  text("Happiness of Students: " +(100-calculatecost(computer_nodes)*10)+ "%", midp2-125, 570); //%error is (e-t)/t
  text("Happiness of Teachers: " +(int)(100-abs((calculatebalance(nodes)-50)/50.0)*100.0)+ "%", midp1-100, 590); //%error is (e-t)/t
  text("Happiness of Teachers: " +(int)(100-abs((calculatebalance(computer_nodes)-50)/50.0)*100.0)+ "%", midp2-125, 590); //%error is (e-t)/t
  text("Iterations completed: " + iteration, midp2+125, h-50);
  text("Current Temperature: " + (nf(100*exp(-avg_delta_cost/T), 1, 2)) + "%", midp2+125, h-30);
  text("Temperature Minimum: " + nf(T_min_p, 1, 2) + "%", midp2+125, h-10);
  text("Time remaining", screen_x/2, screen_y/2+210);
  if (game_modifier == 1) {
    text("Rowdy Students Seperated: " +calculateanticost(nodes), midp1+100, 570);
  }

  textSize(24);
  text("Combined Happiness of Player: " + (int)(COST(nodes))+"%", midp1, 520);
  text("Combined Happiness of Computer: " + (int)(COST(computer_nodes))+"%", midp2, 520);
  //each cut 10 percent
}

void drawimages() { //Draws classroom images during game
  tint(255, 55); 
  image(classroom, midp1-250, h/2-80, 250, 230); 
  image(classroom_flipped, midp1, h/2-80, 250, 230);
  tint(255, 125); 
  image(classroom, midp2-250, h/2-80, 250, 230);
  image(classroom_flipped, midp2, h/2-80, 250, 230);
}
void draw_text_box() { //Draws the text box in the custom input screen and the text on that screen

  rectMode(CENTER);
  fill(200, 202, 202); 
  textSize(30);
  rect(w/2, 60, 500, 40); // x, x-textsize, l, textsize+20
  fill(0);
  //textMode(CORNER);
  textAlign(LEFT, CENTER);

  text (result, w/2-250, 55);
  textAlign(CENTER);
  if (millis()%2==0) {
    line(w/2-249 + result.length()*13, 78, w/2-235+ result.length()*13, 78);
  }
  text ("Enter desired values, seperated by commas", w/2, 120);
  text ("Number of nodes(max 25),\nInitial temperature(max 99),\nMinimum temperature(min 0.0001),\nCooling rate(max 0.999),\nGame mode for regular or rowdy students(0 or 1),\nTime Modifier(0.1<x<1, 1 is fastest)", w/2, 180);
}

void holdnode(node[] nodes) { //For click and dragging nodes
  if (node_locked == true && mouseX<midp1+250-nodes[0].size/2 && mouseX>midp1-250+nodes[0].size/2 ) {//
    nodes[locked_node].x = mouseX;
  }
  if (node_locked == true && mouseY<500-nodes[0].size/2 && mouseY>100+nodes[0].size/2) {
    nodes[locked_node].y = mouseY;
  }
}

void holdpracticenode(node[] nodes) { //For click and dragging practice nodes
  if (node_locked == true && mouseX<w/2+250-nodes[0].size/2 && mouseX>w/2-250+nodes[0].size/2 ) {//
    nodes[locked_node].x = mouseX;
  }
  if (node_locked == true && mouseY<500-nodes[0].size/2 && mouseY>100+nodes[0].size/2) {
    nodes[locked_node].y = mouseY;
  }
}


void draw_state() {  //For drawing the circles in the bottom left to get through menus
  for (int i=0; i<5; i++) {
    fill(0);
    circle(30+30*i, h-20, 15);
  }
  switch (state) { //Depends on which state you're in, where the white circle is drawn
  case 0: //main
    fill(230);
    circle(30, h-20, 14);
    break;

  case -1:
    fill(230);
    circle(90, h-20, 14);
    break;

  case 2:
    fill(230);
    circle(60, h-20, 14);
    break;

  case 4:
    fill(230);
    circle(60, h-20, 14);
    break;

  case 5:
    fill(230);
    circle(120, h-20, 14);
    break;

  case 6:
    fill(230);
    circle(150, h-20, 14);
    break;
  }
}

void drawlastmoved(node [] nodes, int i) { //Draws a red circle around the last moved node in simulated annealing demo
  noFill();
  strokeWeight(3);
  stroke(255, 0, 0);
  circle(nodes[i].x, nodes[i].y, nodes[i].size + 3);
  strokeWeight(1);
  stroke(0);
}
