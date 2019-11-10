//Luke and Robert ENCM 507 Project phase 1, 2019

int number_of_nodes = 15;
int state = -1; /*
State -1 = Instructions
State 0 = Game selection
State 1 = Base Game
State 2 = Difficulty selection
*/

void setup() {
  size(1200, 600);
}
void draw() {
  switch (state) {
  case -1:
    do_once(-1); //setup for state -1
    draw_instruction_screen();
    break;
  case 0:
    do_once(0); //setup for state 0
    drawmenu();
    break;
  case 1:
    drawplayarea(); //Draws the two player areas
    drawwords(); //Draws all the words
    drawconnections(nodes); //Draws node connections
    drawnodes(nodes); //Draws all the nodes
    drawconnections(computer_nodes); //Draws connections between computer nodes
    drawnodes(computer_nodes); //Draws computer nodes
    drawsplit(); //Draws partition
    break;
  case 2:
    do_once(2); //setup for state 2 (difficulty screen)
    drawmenu_d();
    break;
  default:
    println("You shouldn't be in here..");
    break;
  }
}

//Each play area is 400 tall, 500 across, seperations at 50, 300, 550 for x and 100, 500 for y
