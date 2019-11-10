float screen_x = 1200;
float screen_y = 600;
int textsize = 24;
float play_y = screen_y-200;
float play_x = screen_x-200;
float midp1 = screen_x/4;
float midp2 = screen_x*3/4;
int game_started; //For time purposes
color bg_color = #88c2c0; //Background color
PImage classroom; //Image from https://azpng.com/classroom-clipart-our-we-and-vector-for-clip-art-students-png-13568
PImage classroom_flipped;
float timer;
float [] timer_bar = {screen_x/2, screen_y/2-200, 50, 400};
float timer_modifier = 0.7; //lower is slower

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

void drawtime() {
  if (T>Tmin) {
    text((millis()-timer)/100.0, 100, 20);// 400 450 480 less than 500
  }
  if (T<=Tmin) {
    text("Computer done", 50, 20);
  }
  rectMode(CORNER);
  noFill();
  rect(screen_x/2-25, screen_y/2-200, 50, 400);
  fill(230, 50, 50);
  noStroke();
  rect(timer_bar[0]-25, timer_bar[1], timer_bar[2], timer_bar[3]); //Changes the starting point of the bar
  if (timer_bar[1] <screen_y/2-200 + 400) {
    timer_bar[3] = timer_bar[3] - pow((millis()-timer), 0.5)/100*timer_modifier; //Changes the height of the bar
    timer_bar[1] = timer_bar[1] + pow((millis()-timer), 0.5)/100*timer_modifier;
  } else {
    needs_setup = true;
    state = 3; //end of game state
  }
  stroke(0);
}
void draw_end_game_screen() {
  rectMode(CENTER);
  fill(255, 255, 255, 200);
  rect(screen_x/2, screen_y/2, screen_x-150, screen_y-100);
  textSize(50);
  fill(0);  
  if ((int)(COST(nodes))>=(int)(COST(computer_nodes))) { //if player wins
    text("You win!" ,screen_x/2, screen_y/2-100);
  }
  else{//computer wins
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
  fill(255, 255-255*exp(-avg_delta_cost/T), 255-255*exp(-avg_delta_cost/T)) ; //Changes color of computer play area based on temp
  rect(screen_x*3/4, screen_y/2, screen_x/2-100, play_y);
  rectMode(CORNER);
}

void drawwords() { //Draws all words on the screen
  textSize(32);
  fill(0);
  textAlign(CENTER, CENTER);
  text("Player", midp1, 70);
  text("Simulated Annealing", midp2, 70);
  textFont(createFont("Georgia", 36));
  text("Make everyone happy!", screen_x/2, 40);
  textSize(14);
  text("A", midp2-5*textsize, 150);
  text("B", midp2+5*textsize, 150);
  text("A", midp1-5*textsize, 150);
  text("B", midp1+5*textsize, 150);
  //Calculate balance is just percentage of nodes that are on the left. 100 - 50-50/50
  textAlign(CENTER, CENTER); 
  text("Net cuts of Player: " +calculatecost(nodes), midp1, 550);
  text("Net cuts of Computer: " +calculatecost(computer_nodes), midp2-125, 550);
  text("Happiness of Students: " +(100-calculatecost(nodes)*10)+ "%", midp1, 570); //%error is (e-t)/t
  text("Happiness of Students: " +(100-calculatecost(computer_nodes)*10)+ "%", midp2-125, 570); //%error is (e-t)/t
  text("Happiness of Teachers: " +(int)(100-abs((calculatebalance(nodes)-50)/50.0)*100.0)+ "%", midp1, 590); //%error is (e-t)/t
  text("Happiness of Teachers: " +(int)(100-abs((calculatebalance(computer_nodes)-50)/50.0)*100.0)+ "%", midp2-125, 590); //%error is (e-t)/t
  text("Iterations completed: " + iteration, midp2+125, h-50);
  text("Current Temperature: " + nf(exp(-avg_delta_cost/T), 1, 2), midp2+125, h-30);
  text("Temperature Minimum: " + nf(T_min_p, 1, 2), midp2+125, h-10);
  text("Time remaining", screen_x/2, screen_y/2+210);

  textSize(24);
  text("Combined Happiness of Player: " + (int)(COST(nodes))+"%", midp1, 520);
  text("Combined Happiness of Computer: " + (int)(COST(computer_nodes))+"%", midp2, 520);
  //each cut 10 percent
}

void drawimages() {
  tint(255, 55); 
  image(classroom, midp1-250, h/2-80, 250, 230); 
  image(classroom_flipped, midp1, h/2-80, 250, 230);
  tint(255, 125); 
  image(classroom, midp2-250, h/2-80, 250, 230);
  image(classroom_flipped, midp2, h/2-80, 250, 230);
}
