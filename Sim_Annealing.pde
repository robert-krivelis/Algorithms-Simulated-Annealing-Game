void simulatedannealing (node[] nodes, float Tinitial_p, float Tmin_p) { //Simulatedly Anneals computer nodes
  float [] Tinitial_and_Tmin = FirstThreeStepsAnnealing(nodes, Tinitial_p, Tmin_p); // Caculating T0 and Tmin based on input percents 
  float T = Tinitial_and_Tmin[0]; 
  float Tmin = Tinitial_and_Tmin[1];
  float cooling_rate = 0.999; //How fast the temperature lowers, lower = faster
  float r, delta_cost;
  iteration= 0;
  while (T>Tmin) { 
    iteration++;
    PERTURB(new_partitions, 20); //Move something in the copy of computer_nodes
    delta_cost = COST(nodes) - COST(new_partitions); //Cost calculated in this case is actually score. If the score of the suggested move is higher, it will result in a negative delta cost
    if (delta_cost<0) {
      copy_nodes(nodes, new_partitions); //Make computer_nodes equal to it's copy that has been improved
    } else if (delta_cost>0) {
      r = random(0, 1.0);
      if (r<exp(-delta_cost/T)) {
        copy_nodes(nodes, new_partitions); //If temperature is high, we are more likely to accept this bad solution
      }
    }
    T *= cooling_rate;
  }
  for (int i =0; i<nodes.length; i++){ //Random fixing of wacky x values
  println("Node" + i, "X:" + nodes[i].x, "Y:" + nodes[i].y);
 
  }
}

void PERTURB(node[] nodes, int balance_min) {
  int i = (int)random(0, nodes.length-1); //select a single node
  if (nodes[i].partition =='a' && calculatebalance(nodes) - 1.0/number_of_nodes*100>balance_min) { //change partition to b if a will retain 20% or more of the current nodes
    println("Starting at a, knowing that" + calculatebalance(nodes), "-" + 1.0/number_of_nodes*100, ">" + balance_min);
    nodes[i].partition ='b';
    nodes[i].x += 300-50;
    println("Moving node " + i + " from a to b.");
  } else if (nodes[i].partition =='b' && (100-calculatebalance(nodes)) - 1.0/number_of_nodes*100>balance_min) { //change partition to a if b will retain more than 20% of the current nodes
    println("Starting at b, knowing that" + (100-calculatebalance(nodes)), "-" + 1.0/number_of_nodes*100, ">" + balance_min);
    nodes[i].partition ='a';
    nodes[i].x -= 300-50;
    println("Moving node " + i + " from b to a.");
  }
  check_y_collisions(nodes);
}

float COST(node [] nodes) { //Calculates the score of a set of nodes
  return (int)(100-abs(50-calculatebalance(nodes)) - 10*calculatecost(nodes));
}

float [] FirstThreeStepsAnnealing(node[] nodes, float Tinitial_p, float Tmin_p) { //Calculates T and Tmin based on initial percentages
  copy_nodes(new_partitions, nodes); //Make a copy of computer_nodes
  float r, delta_cost;
  float avg_delta_cost = 0;
  for (int i = 0; i<3; i++) { //perform 3 iterations of simulated annealing to find average cost
    PERTURB(new_partitions, 20);
    delta_cost = COST(nodes) - COST(new_partitions);
    avg_delta_cost+=abs(delta_cost)/3; //add to average delta cost
    if (delta_cost<0) {
      copy_nodes(nodes, new_partitions); //update nodes to new solution
    } else {
      r = random(0, 1.0);
      if (r<exp(-delta_cost/100000.0)) { //take essentially every move (only for 3 times)
        copy_nodes(nodes, new_partitions);
      }
    }
  }
  float [] TandTmin = {-avg_delta_cost/log(Tinitial_p/100.0), -avg_delta_cost/log(Tmin_p/100.0)}; //return actual values from percentages
  print("T and Tmin: " + TandTmin[0], " " + TandTmin[1]);
  return TandTmin;
}
