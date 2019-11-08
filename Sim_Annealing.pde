void simulatedannealing (node[] nodes, float Tinitial_p, float Tmin_p) { //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
  /*Input: All cells belonging to computer 
   Output: New partitioning and location of cells
   Tinitial and Tmin are passed in as percentages, and then converted to a value based on Tinitial= -Avg_cost/ln(Tinitial%)
   */
  print("reached simulatedannealing!");
  copy_nodes(new_partitions, nodes);
  float [] TandTmin = {100, 40};//This number is just until we decide what the actual Tinitial and Tmin should be after a few iterations
  float T = TandTmin[0]; 
  float Tmin = TandTmin[1];
  float r;
  float cooling_rate = 0.8; 
  float delta_cost;
  int flag = 0;
  while (T>Tmin) {
    if (flag == 0) { //First time we run through simulated annealing, only do it three times
      flag+=1;
      TandTmin = FirstThreeStepsAnnealing(nodes, Tinitial_p, Tmin_p);
      T = TandTmin[0]; //Update T with accurate value
      T = T*pow(cooling_rate, 3.0); //Multiply T by cooling_rate^3 because three iterations have already been done
      Tmin = TandTmin[1];//Update Tmin with accurate value
    }
    print("HELP! IM STUCK IN T " + T," " + Tmin + "\n");
    PERTURB(new_partitions, 20); //Minimum partition of 20% during simulated annealing
    delta_cost = COST(new_partitions) - COST(nodes);
    if (delta_cost<0) {
      copy_nodes(nodes, new_partitions); //update nodes to new solution
    } else {
      r = random(0, 1.0);
      if (r<exp(-delta_cost/T)) {
        copy_nodes(nodes, new_partitions); //If temperature is high, we are more likely to accept this bad solution
      }
    }
    T *= cooling_rate;
  }
}
//if (millis()%100 ==0) { //every second
//}


void PERTURB(node[] nodes, int balance_min) { //Moves a node to another partition while keeping a balance in mind
  print("perturb!");
  //Steal from mousepressed to make sure x values are being updated and the board is being redrawn after each iteration
  int i = (int)random(0, nodes.length-1); //select a single node
  if (nodes[i].partition =='a' && calculatebalance(nodes) - 1/number_of_nodes*100>balance_min) { //change partition to b if a will retain 20% or more of the current nodes
    nodes[i].partition ='b';
    nodes[i].x += 300-50;
  } else if (nodes[i].partition =='b' && (100-calculatebalance(nodes)) - 1/number_of_nodes*100>balance_min) { //change partition to a if b will retain more than 20% of the current nodes
    nodes[i].partition ='a';
    nodes[i].x -= 300-50;
  }
  check_y_collisions(nodes);
  drawplayarea();
  drawnodes(nodes);
  drawconnections(nodes);
}

float COST(node [] nodes) { /*This cost value should calculate if the move is worth doing.
 To determine cost of netcuts and balance, one additional netcut is equal to making balance 10 percent worse */
  return (int)(100-abs(50-calculatebalance(nodes)) - 10*calculatecost(nodes));
}

float [] FirstThreeStepsAnnealing(node[] nodes, float Tinitial_p, float Tmin_p) {
  print("reached first three!");
  float r;
  float delta_cost;
  float avg_delta_cost=0;
  for (int i = 0; i<3; i++) { //perform 3 iterations of simulated annealing to find average cost
    PERTURB(new_partitions, 20);
    delta_cost = COST(new_partitions) - COST(nodes);
    avg_delta_cost+=abs(delta_cost)/3; //add to average delta cost
    if (delta_cost<0) {
      copy_nodes(nodes, new_partitions); //update nodes to new solution
    } else {
      r = random(0, 1.0);
      if (r<exp(-delta_cost/100000)) { //take essentially every move (only for 3 times)
        copy_nodes(nodes, new_partitions);
      }
    }
  }
  if (avg_delta_cost ==0) {
    print("0!");
    avg_delta_cost =10;
  }
  float [] TandTmin = {-avg_delta_cost/log(Tinitial_p), -avg_delta_cost/log(Tmin_p)}; //return actual values from percentages
  return TandTmin;
}
