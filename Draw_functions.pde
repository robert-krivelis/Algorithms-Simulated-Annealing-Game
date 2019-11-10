float screen_x = 1200;
float screen_y = 600;
int textsize = 24;
float play_y = screen_y-200;
float play_x = screen_x-200;
float midp1 = screen_x/4;
float midp2 = screen_x*3/4;

void drawconnections(node [] nodes) {
  for (int i=0; i<nodes.length; i++) {
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
  for (int i=0; i<nodes.length; i++) {
    fill(nodes[i].col);
    circle(nodes[i].x, nodes[i].y, nodes[i].size);
    fill(0);
    text(nodes[i].ID, nodes[i].x, nodes[i].y);
  }
}


void drawplayarea() { //Draws pink play areas
  background(255);
  fill(0+millis()/300, 255-millis()/300, 255) ;
  rectMode(CENTER);
  rect(screen_x/4, screen_y/2, screen_x/2-100, play_y);
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
  textFont(createFont("Georgia", 32));
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
  text("Iterations completed: " + iteration, midp2, 50);
  //each cut 10 percent
}
