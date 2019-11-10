void mousePressed() { //What happens when you click on the screen?
/* This process carries out state changes when menu buttons are pressed, and node swaps when nodes are clicked */
  //For state -1 - Instructions
  if (state==-1) {
    if (overButton(int(rect4))) {
      state=0;
      needs_setup =true;
      return;
    }
  }
  //For state 0 - Game selection
  else if (state==0) {
    if (overButton(int(rect1))) {
      state=2; //Go to difficulty selection
      needs_setup =true;
      return;
    }
    if (overButton(int(rect2))) {
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
        drawplayarea();
        drawnodes(nodes);
        drawconnections(nodes);
      }
    }
  }
  //For state 2
  else if (state==2) {
    if (overButton(int(rect5))) {
      number_of_nodes =5;
      needs_setup =true;
      do_once(1); //setup for state 1
      state=1;
      return;
    }
    if (overButton(int(rect6))) {
      number_of_nodes =10;
      needs_setup =true;
      do_once(1); //setup for state 1
      state=1;
      return;
    }
    if (overButton(int(rect7))) {
      number_of_nodes =15;
      needs_setup =true;
      do_once(1); //setup for state 1
      state=1;
      return;
    }
  }
}
