boolean node_locked = false;
int locked_node = 0;
int difficulty = 1;
void mousePressed() { //What happens when you click on the screen?
  /* This process carries out state changes when menu buttons are pressed, and node swaps when nodes are clicked */
  //For state -1 - Instructions
  if (state==-1) {
    if (overButton(int(rect4))) {
      state=5;
      needs_setup =true;
      return;
    }
  }
  //For state 0 - Game selection
  else if (state==0) {
    if (overButton(int(rect1))) { //If you click on the first button
      state=2; //Go to instructions
      needs_setup =true;
      return;
    }
    if (overButton(int(rect2))) { //If you click on the second button
      state=2; //Go to instructions
      game_modifier = 1; //Make rowdy connections
      needs_setup =true;
      return;
    }
    if (overButton(int(rect3))) { //If you click on the third button
      state=4; //Go to input screen
      needs_setup =true;
      return;
    }
  }
  //For state 1 - Game
  else if (state==1) {
    if (overButton(int(rect8))) {
      paused = !paused;
    }
    if (overButton(int(rect9))) {
      timer_bar[1] =screen_y/2-202 + 400;
      timer_bar[3] =0;
    }
    for (int i=0; i<number_of_nodes; i++) { //Checks if you clicked on a node and moves it
      if (state ==1 && mouseX > nodes[i].x-nodes[i].size/2 && mouseX < nodes[i].x+nodes[i].size/2 && mouseY > nodes[i].y-nodes[i].size/2 && mouseY < nodes[i].y+nodes[i].size/2) {// Check if you clicked on a node
        node_locked = true;
        locked_node = i;
      }
    }
  }
  //For state 2 - Difficulty menu
  else if (state==2) { 
    if (overButton(int(rect5))) { //If you click on the first button
      difficulty = amount_of_nodes[0];
      timer_modifier = 0.5;
      music_rate = 1;
      state=-1;
      return;
    } else if (overButton(int(rect6))) {//If you click on the second button
      difficulty = amount_of_nodes[1];
      timer_modifier = 0.7;
      music_rate = 1.2;
      state=-1;
      return;
    } else if (overButton(int(rect7))) {//If you click on the third button
      timer_modifier = 0.9;
      music_rate = 1.4;
      difficulty = amount_of_nodes[2];
      state=-1;
      return;
    }
  }
  //For state 3 - Go back to main menu screen to play again //currently not working
  else if (state==3) { 
    //draw buttom here
    fill(255);
    // rect(rect4[0], rect4[1], rect4[2], rect4[3]);
    // hover_i();
    if (overButton(int(rect4))) { //Top secret code
      needs_setup = true;
      state = 0;
      paused = false;
      timer_bar[0] = screen_x/2;
      timer_bar[1] = screen_y/2-200;
      timer_bar[2] =50;
      timer_bar[3] = 400;
      return;
    }
  }
  //For state 4 - Input menu
  else if (state==4) { 
    //sliders:
    //lock if clicked
    for (Test t : instances)
    {
      if (t.isOver())
        t.lock = true;
    }
    //end sliders

    if (overButton(int(rect4))) { //If you click continue
      state=1;
      result +=',';
      convertinput(); //reads string
      needs_setup = true;
      return;
    }
  } else if (state ==5) {
    if (overButton(int(rect4))) { //If you click continue
      number_of_nodes = difficulty;
      state=1;
      needs_setup = true;
      return;
    }
    for (int i=0; i<number_of_nodes; i++) { //Checks if you clicked on a node and moves it
      if (state ==5 && mouseX > practice_nodes[i].x-practice_nodes[i].size/2 && mouseX < practice_nodes[i].x+practice_nodes[i].size/2 && mouseY > practice_nodes[i].y-practice_nodes[i].size/2 && mouseY < practice_nodes[i].y+practice_nodes[i].size/2) {// Check if you clicked on a node
        node_locked = true;
        locked_node = i;
      }
    }
  }
}
