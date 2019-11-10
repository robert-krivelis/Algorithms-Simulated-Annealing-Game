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
