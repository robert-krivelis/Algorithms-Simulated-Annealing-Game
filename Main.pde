//Luke and Robert ENCM 507 Project phase 1, 2019

import processing.sound.*;
SoundFile file;

float screen_x = 1200;
float screen_y = 600;
int textsize = 24;
float play_y = screen_y-200;
float play_x = screen_x-200;
float midp1 = screen_x/4;
float midp2 = screen_x*3/4;
int number_of_nodes = 10;
float music_rate = 1;
node [] nodes = new node[number_of_nodes];
node [] computer_nodes = new node[number_of_nodes];
node [] new_partitions = new node[number_of_nodes];

void setup() {
  size(1200, 600);
  SoundFile file = new SoundFile(this, "rocky.wav"); //Loads song
  file.play(); //Plays song
  initializenodes(nodes); //Initalizes nodes
  createnodes(nodes, number_of_nodes); //Populates nodes with values, gives them a partition and appropriate x location
  check_y_collisions(nodes); //Checks nodes do not collide
  initializecomputernodes(computer_nodes, nodes); //Initializes computer nodes
  //simulatedannealing(computer_nodes, 90, 1); 
}
void draw() {
  drawplayarea(); //Draws the two player areas
  drawwords(); //Draws all the words
  drawconnections(nodes); //Draws node connections
  drawnodes(nodes); //Draws all the nodes
  drawconnections(computer_nodes); //Draws connections between computer nodes THIS WILL HAVE TO BE FIXED
  drawnodes(computer_nodes); //Draws computer nodes
  drawsplit(); //Draws partition
  //musicspeed(file);
}

//Each play area is 400 tall, 500 across, seperations at 50, 300, 550 for x and 100, 500 for y

int calculatecost(node[] nodes) {
  int nc = 0;
  for (int i=0; i<nodes.length; i++) {
    for (int j=0; j<nodes[i].connections.size(); j++) {
      if (nodes[i].partition != nodes[nodes[i].connections.get(j)].partition) { //if a node and it's connection node are in different partitions add nc
        nc +=1;
      }
    }
  }
  return nc;
}
int calculatebalance(node[] nodes) {
  float a = 0;
  for (int i=0; i<nodes.length; i++) {
    if (nodes[i].partition == 'a') {
      a+=1;
    }
  }
  return round(a/number_of_nodes*100.0);
}

void musicspeed(SoundFile file) { //dead function for now
  if (millis()%300 ==0) { //every 3 second
    if (file.isPlaying()) {
      file.pause();
    } else {
      file.play();
    }
  }
}
