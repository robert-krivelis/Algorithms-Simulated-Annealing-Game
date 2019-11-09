//Luke and Robert ENCM 507 Project phase 1, 2019

int number_of_nodes = 15;
int state = 0;

void setup() {
  size(1200, 600);
  setupmenu();
}
void draw() {
  switch (state) {
  case 0:
    drawmenu();
    break;
  case 1:
    do_once(1); //setup for state one
    drawplayarea(); //Draws the two player areas
    drawwords(); //Draws all the words
    drawconnections(nodes); //Draws node connections
    drawnodes(nodes); //Draws all the nodes
    drawconnections(computer_nodes); //Draws connections between computer nodes
    drawnodes(computer_nodes); //Draws computer nodes
    drawsplit(); //Draws partition
    break;
  default:
    println("You shouldn't be in here..");
    break;
  }
}

//Each play area is 400 tall, 500 across, seperations at 50, 300, 550 for x and 100, 500 for y

int calculatecost(node[] nodes) { //calculates net cuts
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
int calculatebalance(node[] nodes) { //calculates balance based on how many nodes are in partition a
  float a = 0;
  for (int i=0; i<nodes.length; i++) {
    if (nodes[i].partition == 'a') {
      a+=1;
    }
  }
  return round(a/number_of_nodes*100.0);
}
