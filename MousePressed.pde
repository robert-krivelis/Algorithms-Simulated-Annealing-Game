void mousePressed() { //What happens when you click on the screen?
  /* This process carries out state changes when menu buttons are pressed, and node swaps when nodes are clicked */
  //For state -1 - Instructions
  if (state==-1) {
    if (overButton(int(rect4))) {
      state=1;
      needs_setup =true;
      return;
    }
  }
  //For state 0 - Game selection
  else if (state==0) {
    if (overButton(int(rect1))) {
      state=2; //Go to instructions
      needs_setup =true;
      return;
    }
    if (overButton(int(rect2))) {
      state=2; //Go to instructions
      game_modifier = 1; //Make rowdy connections
      needs_setup =true;
      return;
    }
    if (overButton(int(rect3))) {
    }
  }
  //For state 1 - Game
  else if (state==1) {
    for (int i=0; i<number_of_nodes; i++) { //Checks if you clicked on a node and moves it
      if (state ==1 && mouseX > nodes[i].x-nodes[i].size/2 && mouseX < nodes[i].x+nodes[i].size/2 && mouseY > nodes[i].y-nodes[i].size/2 && mouseY < nodes[i].y+nodes[i].size/2) {// Check if you clicked on a node
        if (nodes[i].partition == 'a') {
          nodes[i].partition = 'b';
          nodes[i].x += 300-50;
        } else {
          nodes[i].partition = 'a';
          nodes[i].x -= 300-50;
        }
        check_y_collisions(nodes);
      }
    }
  }
  //For state 2
  else if (state==2) { //difficulty menu
    if (overButton(int(rect5))) {
      number_of_nodes = amount_of_nodes[0];
      timer_modifier = 0.5;
      music_rate = 1;
      state=-1;
      return;
    } else if (overButton(int(rect6))) {
      number_of_nodes = amount_of_nodes[1];
      timer_modifier = 0.7;
      music_rate = 1.2;
      state=-1;
      return;
    } else if (overButton(int(rect7))) {
      timer_modifier = 0.7;
      music_rate = 1.4;
      number_of_nodes = amount_of_nodes[2];
      state=-1;
      return;
    }
  }
}
