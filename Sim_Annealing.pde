void simulatedannealing (node[] nodes, float Tinitial, float Tmin) {
  //Input: All cells
  //Output: Partition
  float T = Tinitial;
  float r;
  float cooling_rate = 0.8;
  while(T>Tmin){
    while(!STOP()){
      new_partitions = PERTURB(nodes);
      delta_cost = COST(new_P) - COST(P);
      if (delta_cost<0){
        P = new_P;
      }
      else{
       r = random(0,1.0);
       if (r<exp(-delta_cost/T){
         P = new_P;
       }
      }
    }
    T *= cooling_rate;
  }
  //if (millis()%100 ==0) { //every second
  //}
}

void PERTURB_20(node[] nodes){ //Moves a node to another partition while keeping a balance of 20 % in mind
  int i = (int)random(0,nodes.length-1);
  if (nodes[i].partition =='a'){
    nodes[i].partition ='b';
  }
  else if (nodes[i].partition =='b'){
    nodes[i].partition ='a';
  }
}
