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

//What if I made an array with 5 0r 10 or 15 or 20 nodes
public class node_array { //Contains Nodes
  node [] nodes = new node[number_of_nodes]; //The array of nodes is in here, meaning it can be accessed from anywhere with p1.nodes.x
  node_array (node [] nodes_i) {
  nodes = nodes_i;
  }
}
