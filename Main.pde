//Luke and Robert ENCM 507 Project phase 2, 2019
//Student Seperation
//TODO: Custom input sanitation > sliders?
//TODO: Computer speed slider?
//TODO: Pause time button?
//TODO: Happiness as nice visual
//TODO: Rowdy students as a different visual rather than red line
//TODO: Make into 4 classes
//TODO: Happy and sad faces

int [] amount_of_nodes = {5, 10, 15}; //Amount of nodes for difficulties easy, medium, and hard. Feel free to change it to something else.
int number_of_nodes =  25; //Maximum number of nodes
float T_initial_p = 99; //Initial temperature for simulated annealing
float T_min_p = 0.01; //Minimum temperature for simulated annealing
float cooling_rate = 0.98; //How fast the temperature lowers, lower = faster. 
float timer_modifier = 0.7; //lower is slower
int state = 0;
int game_modifier =0;

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
  case -1:
    do_once(-1); //setup for state -1
    draw_instruction_screen();
    draw_state();
    break;
  case 0:
    do_once(0); //setup for state 0
    drawmenu();
    draw_state();
    break;
  case 1:
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
  case 2:
    do_once(2); //setup for state 2 (difficulty screen)
    drawmenu_d();
    draw_state();
    break;
  case 3:
    do_once(3); //setup for state 3 (end game screen)
    fill(220);
    rect(rect4[0], rect4[1], rect4[2], rect4[3]);
    hover_i();
    fill(0);
    text("Main Menu", rect4[0], rect4[1]);
    break;
  case 4:
    do_once(4); //setup for state 4 (input screen)
    draw_input_screen(); 
    draw_text_box();
    draw_state();
    for (Test t : instances)
      t.run();
    break;
  case 5:
    do_once(5); //practice movement screen
    draw_instructions_pic(); 
    draw_state();
    holdpracticenode(practice_nodes);
    break;
  default:
    break;
  }
}
