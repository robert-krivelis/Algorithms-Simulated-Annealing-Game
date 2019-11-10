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

void drawconnections(node [] nodes) {
  /* Input: node []
   Output: lines drawn between each node and the node it is connected to */
  for (int i=0; i<number_of_nodes; i++) {
    fill(0);
    strokeWeight(1);
    for (int j=0; j<nodes[i].connections.size(); j++) {
      line(nodes[i].x, nodes[i].y, nodes[nodes[i].connections.get(j)].x, nodes[nodes[i].connections.get(j)].y);
    }
  }
}
void drawsplit() { //Draws the cut between the two partitions  
  line(midp1, 100, midp1, 500);
  line(midp2, 100, midp2, 500);
}

void drawnodes(node[] nodes) {
  /* Input: node []
   Output: Circle of each node is drawn and it's index number */
  for (int i=0; i<number_of_nodes; i++) {
    fill(nodes[i].col);
    circle(nodes[i].x, nodes[i].y, nodes[i].size);
    fill(0);
    circle(nodes[i].x-nodes[i].size*0.2, nodes[i].y-nodes[i].size*0.25, nodes[i].size*0.1); //Draw happy face
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
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  text("Player", midp1, 70);
  text("Computer", midp2, 70);
  textSize(36);
  textFont(createFont("Georgia", 30));
  text("Can you beat simulated annealing?", screen_x/2, 20);
  textSize(14);
  text("A", midp2-5*textsize, 150);
  text("B", midp2+5*textsize, 150);
  text("A", midp1-5*textsize, 150);
  text("B", midp1+5*textsize, 150);

  text("Net cuts of Player: " +calculatecost(nodes), midp1, 550);
  text("Net cuts of Computer: " +calculatecost(computer_nodes), midp2, 550);
  text("Balance of Player: " +calculatebalance(nodes) + "%", midp1, 570);
  text("Balance of Computer: " +calculatebalance(computer_nodes)+ "%", midp2, 570);
  textSize(24);
  text("Happiness of Player: " + (int)(COST(nodes))+"%", midp1, 520);
  text("Happiness of Computer: " + (int)(COST(computer_nodes))+"%", midp2, 520);
  text("Iterations completed: " + iteration, w/2, h-50);
  //each cut 10 percent
}

void drawimages() {
  tint(255, 55); 
  image(classroom, midp1-250, h/2-80, 250, 230); //Flickers because it's redrawn often
  image(classroom_flipped, midp1, h/2-80, 250, 230);
  tint(255, 125); 
  image(classroom, midp2-250, h/2-80, 250, 230);
  image(classroom_flipped, midp2, h/2-80, 250, 230);
}
