public class node { //Contains the color, size, location, and neighbors of Nodes

  // TODO add more characteristics like strings in here to represent degrees and such?
  int ID;
  int x;
  int y; 
  int size;
  char partition;
  IntList connections;
  IntList anticonnections;
  color col;
  node (int a, int b, int c, int d, char e, IntList f, IntList h, color g) {
    ID = a;
    x = b;
    y = c;
    size = d;
    partition = e;
    connections = f;
    anticonnections = h;
    col = g;
  }
}
