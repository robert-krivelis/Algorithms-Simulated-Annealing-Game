void mousePressed() { //Checks if you clicked on a node and moves it
  for (int i=0; i<nodes.length; i++) {
    if (mouseX > nodes[i].x-nodes[i].size/2 && mouseX < nodes[i].x+nodes[i].size/2 && mouseY > nodes[i].y-nodes[i].size/2 && mouseY < nodes[i].y+nodes[i].size/2) {// Check if you clicked on a node
      if (nodes[i].partition == 'a') {
        nodes[i].partition = 'b';
        nodes[i].x += 300-50;
      } else {
        nodes[i].partition = 'a';
        nodes[i].x -= 300-50;
      }
      
      check_y_collisions(nodes);
      drawplayarea();
      drawnodes(nodes);
      drawconnections(nodes);
    }
  }
}

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
  fill(255, 255-millis()/500, 255-millis()/500) ;
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
  text("Can you beat simulated annealing?", screen_x/2, 30);
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
  text("Happiness of Player: " + (int)COST(nodes)+"%", midp1, 520);
  text("Happiness of Computer: " + (int)COST(computer_nodes)+"%", midp2, 520);
  //each cut 10 percent
}
