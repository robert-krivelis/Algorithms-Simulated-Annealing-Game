//Luke and Robert ENCM 507 Project phase 1, 2019

//TODOS Fix colors of player areas and background of game

//Fix difficulty levels so that time actually matters 3.
//Fix graphics so it's beautiful looking 2.
//Fix customize simulated annealing - Be able to input Cooling rate, min temp, max temp, num of nodes -- Wait this one is actually pretty easy I think?
int number_of_nodes = 20;
float T_initial_p = 10; //Initial temperature for simulated annealing
float T_min_p = 0.001; //Minimum temperature for simulated annealing
float T;
float Tmin;
float cooling_rate = 0.999; //How fast the temperature lowers, lower = faster. 
int state = -1;

/*
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
    drawimages();//Draws classroom clipart
    drawwords(); //Draws all the words
    drawconnections(nodes); //Draws node connections
    drawnodes(nodes); //Draws all the nodes
    simulatedannealing(computer_nodes); //Simulatedly anneals the computer nodes into an optimal position.
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
