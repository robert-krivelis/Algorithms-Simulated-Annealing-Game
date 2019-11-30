int iteration =0; //Counts iterations of simulated_annealing
float avg_delta_cost = 0;
float T;
float Tmin;
float best_score=-100; //Keeps track of the best score simulated annealing has gotten
void simulatedannealing (node[] nodes) { 
  /* Input: node [], T initial percentage, T minimum percentage
   Output: Goes through Simulated Annealing for a given node array based on T initial percentage, T minimum percentage */
  float r, delta_cost;
  if (T>Tmin) { //Changing from a while loop to an if statement makes it so that it can be shown in real time
    iteration++;
    PERTURB(new_partitions, 20); //Move something in the copy of computer_nodes
    delta_cost = COST(nodes) - COST(new_partitions); //Cost calculated in this case is actually score. If the score of the suggested move is higher, it will result in a negative delta cost
    if (delta_cost<0) {
      copy_nodes(nodes, new_partitions); //Make computer_nodes equal to it's copy that has been improved
      if (COST(best_partitions)-COST(new_partitions)<0) { //Update best_partitions if new score is higher
        copy_nodes(best_partitions, new_partitions);
      }
    } else if (delta_cost>0) {
      r = random(0, 1.0);
      if (r<exp(-delta_cost/T)) {
        copy_nodes(nodes, new_partitions); //If temperature is high, we are more likely to accept this bad solution
      }
    }
    T *= cooling_rate;
  } else if (T<=Tmin) { //At end of annealing, revert to best partitions
    if (COST(best_partitions)-COST(nodes)>0) { //Update best_partitions if new score is higher
      copy_nodes(nodes, best_partitions);
    }
  }
  if (state==1) {
    drawconnections(computer_nodes); //Draws connections between computer nodes
    drawnodes(computer_nodes); //Draws computer nodes
  }
  if (exp(-avg_delta_cost/T)<0.1) {
    cooling_rate = 0.99; //Slows down cooling rate near the end of annealing for better results without greatly increasing iteration count/time
  }
}


void PERTURB(node[] nodes, int balance_min) {
  /* Input: node [], minimum balance allowed during simulated annealing process
   Output: Moves a node over to the opposite partition */
  int i = (int)random(0, number_of_nodes-1); //select a single node
  if (nodes[i].partition =='a' && calculatebalance(nodes) - 1.0/number_of_nodes*100>balance_min) { //change partition to b if a will retain 20% or more of the current nodes
    nodes[i].partition ='b';
    nodes[i].x += 300-50;
    last_moved = i; //Updates red circle for sim annealing demo
  } else if (nodes[i].partition =='b' && (100-calculatebalance(nodes)) - 1.0/number_of_nodes*100>balance_min) { //change partition to a if b will retain more than 20% of the current nodes
    nodes[i].partition ='a';
    nodes[i].x -= 300-50;
    last_moved = i;
  }
  check_y_collisions(nodes);
}

float COST(node [] nodes) { //Calculates the score of a set of nodes
  if (game_modifier==1) {
    return (int)(70-abs(50-calculatebalance(nodes)) - 10*calculatecost(nodes) + 10*calculateanticost(nodes));
  }
  return (int)(100-abs(50-calculatebalance(nodes)) - 10*calculatecost(nodes));
}

float [] FirstThreeStepsAnnealing(node[] nodes, float Tinitial_p, float Tmin_p) { //Calculates T and Tmin based on initial percentages
  copy_nodes(new_partitions, nodes); //Make a copy of computer_nodes
  copy_nodes(best_partitions, nodes);
  float r, delta_cost;   
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
  float [] TandTmin = {-avg_delta_cost/log(Tinitial_p/100.0)*pow(cooling_rate, 3), -avg_delta_cost/log(Tmin_p/100.0)*pow(cooling_rate, 3)}; //return values from percentages with these iterations taken into account
  return TandTmin;
}

int calculatecost(node[] nodes) { //calculates net cuts
  int nc = 0;
  for (int i=0; i<number_of_nodes; i++) {
    for (int j=0; j<nodes[i].connections.size(); j++) {
      if (nodes[i].partition != nodes[nodes[i].connections.get(j)].partition) { //if a node and it's connection node are in different partitions add nc
        nc +=1;
      }
    }
  }
  return nc;
}
int calculateanticost(node[] nodes) { //calculates net cuts
  int nc = 0;
  for (int i=0; i<number_of_nodes; i++) {
    for (int j=0; j<nodes[i].anticonnections.size(); j++) {
      if (nodes[i].partition != nodes[nodes[i].anticonnections.get(j)].partition) { //if a node and it's connection node are in different partitions add nc
        nc +=1;
      }
    }
  }
  return nc;
}
int calculatebalance(node[] nodes) { //calculates balance based on how many nodes are in partition 'a'
  float a = 0;
  for (int i=0; i<number_of_nodes; i++) {
    if (nodes[i].partition == 'a') {
      a+=1;
    }
  }
  return round(a/number_of_nodes*100.0);
}
void simulatedannealingexample (node[] nodes) {  //SIMULATED ANNEALING CODE FOR SIM ANNEALING DEMO
  /* Input: node [], T initial percentage, T minimum percentage
   Output: Goes through Simulated Annealing for a given node array based on T initial percentage, T minimum percentage */
  float r, delta_cost;
  if (T>Tmin) { //Changing from a while loop to an if statement makes it so that it can be shown in real time
    iteration++;
    PERTURB(new_partitions, 20); //Move something in the copy of computer_nodes
    delta_cost = COST(nodes) - COST(new_partitions); //Cost calculated in this case is actually score. If the score of the suggested move is higher, it will result in a negative delta cost
    if (delta_cost<0) {
      copy_nodes(nodes, new_partitions); //Make computer_nodes equal to it's copy that has been improved
      if (COST(best_partitions)-COST(new_partitions)<0) { //Update best_partitions if new score is higher
        copy_nodes(best_partitions, new_partitions);
      }
    } else if (delta_cost>0) {
      r = random(0, 1.0);
      if (r<exp(-delta_cost/T)) {
        copy_nodes(nodes, new_partitions); //If temperature is high, we are more likely to accept this bad solution
      }
    }
    T *= cooling_rate;
  } else if (T<=Tmin) { //At end of annealing, revert to best partitions
    if (COST(best_partitions)-COST(nodes)>0) { //Update best_partitions if new score is higher
      copy_nodes(nodes, best_partitions);
    }
  }
  if (state==1) {
    drawconnections(computer_nodes); //Draws connections between computer nodes
    drawnodes(computer_nodes); //Draws computer nodes
  }
  if (exp(-avg_delta_cost/T)<0.1) {
    cooling_rate = 0.99; //Slows down cooling rate near the end of annealing for better results without greatly increasing iteration count/time
  }
}
