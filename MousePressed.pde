void mousePressed() { //What happens when you click on the screen?
  //For state 0
  if (state==0) {
    if (overButton(int(rect1))) {
       print("you've swagged button number 1");
       state=1;
       return;
    }
    if (overButton(int(rect2))) {
        print("you've swagged button number 2");
    }
    if (overButton(int(rect3))) {
      print("you've swagged button number 3");
    }
  } 
  
  //For state 1
  for (int i=0; i<nodes.length; i++) { //Checks if you clicked on a node and moves it
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
