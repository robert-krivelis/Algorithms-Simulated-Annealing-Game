//Luke and Robert ENCM 507 Project phase 2, 2019
//Student Seperation
//TODO: Computer speed slider?
//TODO: Happiness as nice visual
//TODO: Rowdy students as a different visual rather than red line
//TODO: Make into 4 classes
//TODO: Happy and sad faces

int [] amount_of_nodes = {5, 10, 15}; //Amount of nodes for difficulties easy, medium, and hard. Feel free to change it to something else.
int number_of_nodes =  25; //Maximum number of nodes
float T_initial_p = 99; //Initial temperature for simulated annealing
float T_min_p = 0.01; //Minimum temperature for simulated annealing
float cooling_rate = 0.98; //How fast the temperature lowers, lower = faster. 
float timer_modifier = 0.7; //Lower is slower
int state = 0; //Starting screen state
int game_modifier =0; //0 is regular game, 1 is to seperate rowdy kids
int Counter = 0;
/*
State -1 = Instructions
 State 0 = Game selection (Starting Screen)
 State 1 = Base Game
 State 2 = Difficulty selection
 State 3 = End Game 
 State 4 = Custom inputs
 State 5 = Practice Movement
 State 6 = Simm annealing demonstration
 */
void setup() {
  size(1200, 600);
}
void draw() {
  switch (state) {
  case -1: //INSTRUCTION SCREEN
    do_once(-1); //Setup for state -1
    draw_instruction_screen(); //Displays instructions for player
    draw_state(); //Shows how many steps are left until the game screen in the bottom left 
    break;
  case 0: //STARTING SCREEN
    do_once(0); //Setup for state 0
    drawmenu(); //Draws main selection menu
    draw_state();//Shows how many steps are left until the game screen in the bottom left 
    break;
  case 1: //PLAY GAME
    do_once(1);
    drawplayarea(); //Draws the two player areas 
    drawtime(); //Draws time remaining
    drawimages();//Draws classroom clipart
    drawwords(); //Draws all the words
    drawconnections(nodes); //Draws node connections
    drawnodes(nodes); //Draws all the nodes
    simulatedannealing(computer_nodes); //Simulatedly anneals the computer nodes into an optimal position.
    drawsplit(); //Draws partition
    drawpause();
    drawfinish();
    holdnode(nodes);
    break;
  case 2: //DIFFICULTY SCREEN
    do_once(2); //Setup for state 2 (difficulty screen)
    drawmenu_d();
    draw_state();//Shows how many steps are left until the game screen in the bottom left 
    break;
  case 3: //END GAME SCREEN
    do_once(3); //Setup for state 3 (end game screen)
    fill(buttoncol);
    rect(rect4[0], rect4[1], rect4[2], rect4[3],brad);
    hover();
    fill(0);
    text("Main Menu", rect4[0], rect4[1]);
    break;
  case 4: //CUSTOM INPUT FOR SIMULATED ANNEALING
    do_once(4); //Setup for state 4 (input screen)
    draw_input_screen(); //Draws background
    draw_text_box(); //Input text box
    draw_state();//Shows how many steps are left until the game screen in the bottom left 
    for (Test t : instances) //Draws sliders
      t.run();
    break;
  case 5: //PRACTICE MOVEMENT SCREEN
    do_once(5); //Setup
    draw_practice(); //Shows practice screen
    draw_state(); //Shows how many steps are left until the game screen in the bottom left 
    holdpracticenode(practice_nodes); //Allows player to click and drag nodes
    break;
  case 6: //SIMULATED ANNEALING DEMO
    do_once(6); //Setup
    draw_sim_demo();//Shows simulated annealing demo
    draw_state(); 
    if (Counter > 30 ) { //Slows down simulated annealing example, lower number = faster annealing
      simulatedannealingexample(sim_nodes);
      Counter = 0;
    } else {
      Counter++;
    }
    drawlastmoved(sim_nodes, last_moved); //Draws red outline on circle
    break;
  default:
    break;
  }
}
