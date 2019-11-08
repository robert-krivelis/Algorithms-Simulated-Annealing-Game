float screen_x = 1200;
float screen_y = 600;
int textsize = 24;
float play_y = screen_y-200;
float play_x = screen_x-200;
float midp1 = screen_x/4;
float midp2 = screen_x*3/4;
int number_of_nodes = 10;
node [] nodes = new node[number_of_nodes];
void setup() {
  size(1200, 600);
  initializenodes(nodes); //Initalizes nodes
  createnodes(nodes, number_of_nodes); //Populates nodes with values
}
void draw() {
  drawplayarea(); //Draws the two player areas
  drawwords(); //Draws all the words
  drawconnections(nodes); //Draws node connections
  drawnodes(nodes); //Draws all the nodes
  drawsplit(); //Draws partition
  
}

void drawplayarea() { //Draws pink play areas
  background(255);
  fill(#fc88d6);
  rectMode(CENTER);
  rect(screen_x/4, screen_y/2, screen_x/2-100, play_y);
  rect(screen_x*3/4, screen_y/2, screen_x/2-100, play_y);
  rectMode(CORNER);
}

void drawwords() { //Draws all words on the screen
  textSize(32);
  fill(0);
  textMode(CENTER);
  textAlign(CENTER, CENTER);
  text("Player", midp1, 70);
  text("Computer", midp2, 70);
  textSize(36);
  textFont(createFont("Georgia", 32));
  text("Can you beat simulated annealing?", screen_x/2, 30);
  textSize(14);
  text("A", midp2-5*textsize, 150);
  text("B", midp2+5*textsize, 150);

  text("A", midp1-5*textsize, 150);
  text("B", midp1+5*textsize, 150);
}
//Each play area is 400 tall, 500 across, seperations at 50, 300, 550 for x and 100, 500 for y
void drawnodes(node[] nodes) {
for (int i=0; i<nodes.length; i++) {
    fill(nodes[i].col);
    circle(nodes[i].x, nodes[i].y, nodes[i].size);
  }
}

void drawsplit() { //Draws the cut between the two partitions  
  line(midp1, 100, midp1, 500);
  line(midp2, 100, midp2, 500);
}

public class node { //Contains the color, size, location, and neighbors of Nodes
  int ID;
  int x;
  int y; 
  int size;
  char partition;
  IntList connections;
  color col;
  node (int a, int b, int c, int d, char e, IntList f, color g) {
    ID = a;
    x = b;
    y = c;
    size = d;
    partition = e;
    connections = f;
    col = g;
  }
}
void initializenodes(node[] nodes) {
  for (int i = 0; i<nodes.length; i++) {
    nodes[i] = new node(0, 0, 0, 0, 'a', new IntList(), color(0, 0, 0));
  }
}
void createnodes(node[] nodes, int n) {
  for (int i = 0; i<n; i++) {
    nodes[i].ID = i;
    nodes[i].size = 20;
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
  }
  for (int i = 0; i<n; i++) {
    int possible_connection;
    possible_connection = (int) random(0, n);
    if (nodes[i].connections.hasValue(possible_connection)) {
    } else {
      nodes[i].connections.append(possible_connection);
    }
  }
}

void drawconnections(node [] nodes) {
  for (int i=0; i<nodes.length; i++) {
    fill(0);
    strokeWeight(1);
    for (int j=0; j<nodes[i].connections.size(); j++) {
      line(nodes[i].x, nodes[i].y, nodes[nodes[i].connections.get(j)].x, nodes[nodes[i].connections.get(j)].y);
    }
  }
}

void check_y_collisions(node [] nodes) {
  for (int i=0; i<nodes.length; i++) {
    for (int j=0; j<i-1; j++) {
      while (abs(nodes[i].y-nodes[j].y) < nodes[i].size+nodes[j].size) {
        nodes[i].y = (int) random(100+nodes[i].size/2+50, 500-nodes[i].size/2);
        print("collision at " + i, j, "because of ", nodes[i].y, nodes[j].y, abs(nodes[i].y-nodes[j].y), nodes[i].size+nodes[j].size, "\n");
      }
    }
  }
}
