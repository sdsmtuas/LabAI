  
float speed = 1.25;
  
void setup() {
  size(500, 500, P3D);
  noFill();
}
int b = 0;
void draw() {
  background(16,28,43);
 
  pushMatrix();
  // start at the middle of the screen
  translate(width/2, height/2, -200);     
  // some random rotation to make things interesting
  b += 1;
  fill(9,17,27);
  //fill(16,28,43);
  
  // ################## Sphere rotation
  pushMatrix();
  rotateY(frameCount * 0.5 /100.0);
  stroke(194, 68, 78);
  sphere(150);
  popMatrix();
  //rotateY(-frameCount/100.0);
  // ###############
  
  // #################### box1 ####################
  pushMatrix();
  //rotateY(radians(45));
  rotateX(frameCount * speed / 100.0);
  
  translate(0, 0, 200);
  stroke(56,165,205);
  box(25);
  popMatrix();
  
  // #################### ####################
  
  // #################### box2 ####################
  pushMatrix();
  //rotateY(-radians(45));
  rotateY(-radians(90));
  rotateX(-frameCount * speed  / 100.0 + radians(90));
  
  translate(0, 0, -200);
  stroke(56,165,205);
  box(25);
  popMatrix();
  // ####################  #################### 
  
  // #################### box3 ####################
  pushMatrix();
  //rotateY(-radians(45));
  rotateY(-radians(90));
  rotateX(-frameCount * speed  / 100.0 + radians(270));
  
  translate(0, 0, -200);
  //stroke(56,165,205);
  stroke(56,165,205);
  box(25);
  popMatrix();
  // ####################  #################### 
  
  // #################### box4 ####################
  pushMatrix();
  //rotateY(radians(45));
  rotateX(frameCount * speed  / 100.0);
  
  translate(0, 0, -200);
  //stroke(56,165,205);
  stroke(56,165,205);
  box(25);
  popMatrix();
  // ####################  #################### 
  
  // #################### box5 ####################
  pushMatrix();
  rotateY(-frameCount * speed  / 100.0 + radians(90));
  
  translate(0, 0, -200);
  //stroke(56,165,205);
  stroke(56,165,205);
  box(25);
  popMatrix();
  // ####################  #################### 
 
  // #################### box6 ####################
  pushMatrix();
  rotateY(-frameCount * speed  / 100.0 + radians(270));
  
  translate(0, 0, -200);
  //stroke(56,165,205);
  stroke(56,165,205);
  box(25);
  popMatrix();
  // ####################  #################### 
 
  // the box was drawn at (0, 0, 0), store that location
  float x = modelX(0, 0, 0);
  float y = modelY(0, 0, 0);
  float z = modelZ(0, 0, 0);
  // clear out all the transformations
  popMatrix();


}
