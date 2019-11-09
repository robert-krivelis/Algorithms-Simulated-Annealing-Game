node [] nodes = new node[number_of_nodes];
node [] computer_nodes = new node[number_of_nodes];
node [] new_partitions = new node[number_of_nodes];

void initializenodes(node[] nodes) {
  for (int i = 0; i<nodes.length; i++) {
    nodes[i] = new node(0, 0, 0, 0, 'a', new IntList(), color(0, 0, 0));
  }
}
void createnodes(node[] nodes, int n) {
  for (int i = 0; i<n; i++) {
    nodes[i].ID = i;
    nodes[i].size = 30;
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
  for (int i=0; i<nodes.length; i++) {
    for (int j=0; j<i-1; j++) {
      while (abs(nodes[i].y-nodes[j].y) < (nodes[i].size+nodes[j].size)/2.0 && abs(nodes[i].x-nodes[j].x) < (nodes[i].size+nodes[j].size)/2.0) { //Check for collision
        //print("collision at " + i, j, "because of ", nodes[i].y, nodes[j].y, abs(nodes[i].y-nodes[j].y), (nodes[i].size+nodes[j].size)/2, "or", nodes[i].x, nodes[j].x, abs(nodes[i].x-nodes[j].x), (nodes[i].size+nodes[j].size)/2, "\n");
        nodes[j].y = (int) random(150+nodes[j].size/2.0, 500-nodes[j].size/2.0);
      }
    }
    for (int j=i-1; j>0; j--) {
      while (abs(nodes[i].y-nodes[j].y) < (nodes[i].size+nodes[j].size)/2.0 && abs(nodes[i].x-nodes[j].x) < (nodes[i].size+nodes[j].size)/2.0) { //Check for collision
        //print("collision at " + i, j, "because of ", nodes[i].y, nodes[j].y, abs(nodes[i].y-nodes[j].y), (nodes[i].size+nodes[j].size)/2, "or", nodes[i].x, nodes[j].x, abs(nodes[i].x-nodes[j].x), (nodes[i].size+nodes[j].size)/2, "\n");
        nodes[j].y = (int) random(150+nodes[j].size/2.0, 500-nodes[j].size/2.0);
      }
    }
  }
}

void initializecomputernodes(node []computer_nodes, node[] nodes) { //Replicates nodes over to the right
  for (int i = 0; i<nodes.length; i++) {
    computer_nodes[i] = new node(0, 0, 0, 0, 'a', new IntList(), color(0, 0, 0));
  }
  for (int i = 0; i<nodes.length; i++) {
    computer_nodes[i].ID = nodes[i].ID;// + number_of_nodes;
    computer_nodes[i].x = nodes[i].x+600;
    computer_nodes[i].y = nodes[i].y;
    computer_nodes[i].size = nodes[i].size;
    computer_nodes[i].partition = nodes[i].partition;
    computer_nodes[i].connections =  nodes[i].connections;
    computer_nodes[i].col = nodes[i].col;
  }
}

void copy_nodes(node []new_nodes, node[] reference_nodes) { //Replicates nodes over to the right
  for (int i = 0; i<reference_nodes.length; i++) {
    new_nodes[i] = new node(0, 0, 0, 0, 'a', new IntList(), color(0, 0, 0));
  }
  for (int i = 0; i<reference_nodes.length; i++) {
    new_nodes[i].ID = reference_nodes[i].ID;
    new_nodes[i].x = reference_nodes[i].x;
    new_nodes[i].y = reference_nodes[i].y;
    new_nodes[i].size = reference_nodes[i].size;
    new_nodes[i].partition = reference_nodes[i].partition;
    new_nodes[i].connections =  reference_nodes[i].connections;
    new_nodes[i].col = reference_nodes[i].col;
  }
}
