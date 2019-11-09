float [] rect1, rect2, rect3;
float w = 1200, h = 600;
void setupmenu() {
  rect1 = new float[4];
  rect2 = new float[4];
  rect3 = new float[4];
  rect1[0] = w/2;
  rect1[1] = h*2/5;
  rect1[2] = w*0.7;
  rect1[3] = h*0.15; 

  rect2[0] = w/2;
  rect2[1] = h*3/5;
  rect2[2] = w*0.7;
  rect2[3] = h*0.15; 

  rect3[0] = w/2;
  rect3[1] = h*4/5;
  rect3[2] = w*0.7;
  rect3[3] = h*0.15;
}
void drawmenu() {
  background(#88c2c0);
  fill(255);
  rectMode(CENTER);
  rect(rect1[0], rect1[1], rect1[2], rect1[3]);
  rect(rect2[0], rect2[1], rect2[2], rect2[3]);
  rect(rect3[0], rect3[1], rect3[2], rect3[3]);
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Student Seperation", w/2, 80);
  text("Sort out kids based on their friendships", rect1[0], rect1[1]); //Add difficulties
  text("Seperate kids who are anti-good", rect2[0], rect2[1]);
  text("Customize simulated annealing", rect3[0], rect3[1]);
  textFont(createFont("Georgia", 32));
  textSize(14);
  fill(50);
  textAlign(RIGHT,BOTTOM);
  text("ENCM PROJECT PHASE 1\n LUKE RENAUD - ROBERT KRIVELIS", w-15, h-15);
  rectMode(CORNER);
}

boolean overButton(int dimensions[]) {
  if (mouseX >= dimensions[0]-dimensions[2]/2 && mouseX <= dimensions[0] + dimensions[2]/2 && 
    mouseY >= dimensions[1]-dimensions[3]/2 && mouseY <= dimensions[1]+dimensions[3]/2) 
    return true;
  else 
  return false;
}
