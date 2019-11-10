boolean needs_setup=true;
node [] nodes = new node[number_of_nodes];
node [] computer_nodes = new node[number_of_nodes];
node [] new_partitions = new node[number_of_nodes];

void initializenodes(node[] nodes) {
  /* Input: node []
  Output: Fills in node array with empty values */
  for (int i = 0; i<number_of_nodes; i++) {
    nodes[i] = new node(0, -100, -100, 0, 'a', new IntList(), color(0, 0, 0));
  }
}
void createnodes(node[] nodes, int n) {
  /* Input: node []
  Output: Fills in node array with meaningful values, giving a location, color, and partition to each node  */
  for (int i = 0; i<n; i++) {
    nodes[i].ID = i;
    nodes[i].size = -2*n + 60; // y = mx + b for size of nodes 
    nodes[i].col = color(random(50, 255), random(50, 255), random(50, 255));
    if (random(0, 1.0)<0.5) {
      nodes[i].partition = 'a'; 
      nodes[i].x = (int) random(50+nodes[i].size, 300-nodes[i].size);
      nodes[i].y = (int) random(150+nodes[i].size, 500-nodes[i].size);
    }  
    else {
      nodes[i].partition = 'b';
      nodes[i].x =(int)  random(300+nodes[i].size, 550-nodes[i].size);
      nodes[i].y =(int) random(150+nodes[i].size, 500-nodes[i].size);
    }
    check_y_collisions(nodes);
  }
  for (int i = 0; i<n; i++) {
    int possible_connection;
    possible_connection = (int) random(0, n);
    while (nodes[i].connections.hasValue(possible_connection)) { //Make every node have at least one connection
      possible_connection = (int) random(0, n);
    } 
    nodes[i].connections.append(possible_connection);
  }
}


void check_y_collisions(node [] nodes) {
  /* Input: node []
  Output: Moves a node's y position if it overlaps with another node */
  for (int i=0; i<number_of_nodes; i++) {
    for (int j=0; j<i-1; j++) {
      while (abs(nodes[i].y-nodes[j].y) < (nodes[i].size+nodes[j].size)/2.0 && abs(nodes[i].x-nodes[j].x) < (nodes[i].size+nodes[j].size)/2.0) { //Check for collision
        nodes[j].y = (int) random(150+nodes[j].size/2.0, 500-nodes[j].size/2.0);
      }
    }
    for (int j=i-1; j>0; j--) {
      while (abs(nodes[i].y-nodes[j].y) < (nodes[i].size+nodes[j].size)/2.0 && abs(nodes[i].x-nodes[j].x) < (nodes[i].size+nodes[j].size)/2.0) { //Check for collision
        nodes[j].y = (int) random(150+nodes[j].size/2.0, 500-nodes[j].size/2.0);
      }
    }
  }
}

void initializecomputernodes(node []computer_nodes, node[] nodes) { 
  /* Input: node [], node []
  Output: Copies an array of nodes, but with each node over to the right 600 pixels*/
  for (int i = 0; i<number_of_nodes; i++) {
    computer_nodes[i] = new node(0, 0, 0, 0, 'a', new IntList(), color(0, 0, 0));
  }
  for (int i = 0; i<number_of_nodes; i++) {
    computer_nodes[i].ID = nodes[i].ID;// + number_of_nodes;
    computer_nodes[i].x = nodes[i].x+600;
    computer_nodes[i].y = nodes[i].y;
    computer_nodes[i].size = nodes[i].size;
    computer_nodes[i].partition = nodes[i].partition;
    computer_nodes[i].connections =  nodes[i].connections;
    computer_nodes[i].col = nodes[i].col;
  }
}

void copy_nodes(node []new_nodes, node[] reference_nodes) {
  /* Input: node [], node[]
  Output: Copies the second array into the first array */
  for (int i = 0; i<number_of_nodes; i++) {
    new_nodes[i] = new node(0, 0, 0, 0, 'a', new IntList(), color(0, 0, 0));
  }
  for (int i = 0; i<number_of_nodes; i++) {
    new_nodes[i].ID = reference_nodes[i].ID;
    new_nodes[i].x = reference_nodes[i].x;
    new_nodes[i].y = reference_nodes[i].y;
    new_nodes[i].size = reference_nodes[i].size;
    new_nodes[i].partition = reference_nodes[i].partition;
    new_nodes[i].connections =  reference_nodes[i].connections;
    new_nodes[i].col = reference_nodes[i].col;
  }
}

//The only thing that ever switches a state is pressing a button. Therefore after pressing a button needs_setup should be true
void do_once(int state) {
  /* Input: state
  Output: Based on state, do_once runs associated setup functions */
  if (state ==-1 && needs_setup==true) { //State =-1 (setup instruction screen)
    instruction_screen();
    needs_setup=false;
  }
  if (state ==0 && needs_setup==true) { //State = 0 (game selection). After this go to difficulty screen
    setupselectionmenu();
    needs_setup=false;
  }
  if (state==1 && needs_setup==true) { //State one initialization 
    music();
    game_started = millis();
    initializenodes(nodes); //Initalizes player nodes
    createnodes(nodes, number_of_nodes); //Populates player nodes with values, gives them a partition and appropriate x location
    check_y_collisions(nodes); //Checks nodes do not collide
    initializecomputernodes(computer_nodes, nodes); //Initializes computer nodes as a copy of player nodes
    T = FirstThreeStepsAnnealing(computer_nodes, T_initial_p, T_min_p)[0];
    Tmin = FirstThreeStepsAnnealing(computer_nodes, T_initial_p, T_min_p)[1];
    needs_setup=false;
  }
  if (state ==2 && needs_setup==true) {
    setupselectionmenu_d();
    needs_setup=false;
  }
}
