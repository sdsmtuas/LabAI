/*
Author: Benjamin Millhouse

Last Update Date: 1/31/2020
*/

class SatSphere
{
  int t;
  //speed of rotation 
  float speed_sat, speed_sphere;
  //the positon in the window of the center of the sphere
  float x, y, s, step;
  // integer locations for the new location from .tranlsate()
  int new_x, new_y, new_s;
  // increment and step values - both used for animations
  float x_step, y_step, s_step;
  //sphere and sat color;
  color sphere_color, sat_color;
  //if a transition is being
  boolean translate;
  
  //constructor
  SatSphere()
  {
     this.speed_sat = 1.25;
     this.speed_sphere = 0.5;
     this.step = 0;
     this.sphere_color = color(194, 68, 78);
     this.sat_color = color(56,165,205);
     translate = false;
  }
  
  //constructor
  SatSphere(float speed_sat, float speed_sphere)
  {
     this.speed_sat = speed_sat;
     this.speed_sphere= speed_sphere;
     this.step = 0;
     this.sphere_color = color(194, 68, 78);
     this.sat_color = color(56,165,205);
     translate = false;
  }
  
  void setup(float x, float y, float s)
 {
    this.x = x;
    this.y = y;
    this.s = s;
  }
  
  void render()
  {
    // save the current fill and stroke data, this is so they can be set back to
    // what they were at the end of the function.
    color curr_fill = g.fillColor;
    color curr_stroke = g.strokeColor;

    // first mode
  if(this.translate)//translation mode
  {
  
      // calculate the next place to render the rectangle. Each step is based
      // off of the previous step.
      this.x = (this.step < 25) ? this.x + (this.step + 1) * ((this.x_step * 50) / 2 / 338) : this.x + (51 - (this.step)) * ((this.x_step * 50) / 2 / 338);
      this.y = (this.step < 25) ? this.y + (this.step + 1) * ((this.y_step * 50) / 2 / 338) : this.y + (51 - (this.step)) * ((this.y_step * 50) / 2 / 338);
      this.s = (this.step < 25) ? this.s + (this.step + 1) * ((this.s_step * 50) / 2 / 338) : this.s + (51 - (this.step)) * ((this.s_step * 50) / 2 / 338);
      
      fill(curr_fill, 0);
      
      
      translate(this.x, this.y, this.s);
     
  // ################## Sphere rotation #############
    pushMatrix();
    rotateY(frameCount * this.speed_sphere /100.0);
    stroke(this.sphere_color);
    sphere(150);
    popMatrix();
  // ###############
  
  // #################### box1 ####################
    pushMatrix();
    rotateX(frameCount * this.speed_sat / 100.0);
  
    translate(0, 0, 200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  
  // #################### ####################
  
  // #################### box2 ####################
    pushMatrix();

    rotateY(-radians(90));
    rotateX(-frameCount * this.speed_sat  / 100.0 + radians(90));
  
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  // ####################  #################### 
  
  // #################### box3 ####################
    pushMatrix();
  //rotateY(-radians(45));
    rotateY(-radians(90));
    rotateX(-frameCount * this.speed_sat  / 100.0 + radians(270));
  
    translate(0, 0, -200);
  //stroke(56,165,205);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  // ####################  #################### 
  
  // #################### box4 ####################
    pushMatrix();
    rotateX(frameCount * this.speed_sat  / 100.0);
  
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  // ####################  #################### 
  
  // #################### box5 ####################
    pushMatrix();
    rotateY(-frameCount * this.speed_sat  / 100.0 + radians(90));
  
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
    // ####################  #################### 
 
    // #################### box6 ####################
    pushMatrix();
    rotateY(-frameCount * this.speed_sat  / 100.0 + radians(270));
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
    
    //increment the step
    this.step +=1;
    
    if(this.step == 51)
    { 
        // change all of the variables, this is so static mode can be drawn with
        // very little processing power.
        this.translate = false;
        this.x = this.new_x;
        this.y = this.new_y;
        this.s = this.new_s;
    }
  }
  //static mode
  else 
  {
      translate(this.x, this.y, this.s);
      fill(curr_fill ,0);
      
    
  // ################## Sphere rotation #############
    pushMatrix();
    rotateY(frameCount * this.speed_sphere /100.0);
    stroke(this.sphere_color);
    sphere(150);
    popMatrix();
  // ###############
  
  // #################### box1 ####################
    pushMatrix();
    rotateX(frameCount * this.speed_sat / 100.0);
  
    translate(0, 0, 200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  
  // #################### ####################
  
  // #################### box2 ####################
    pushMatrix();

    rotateY(-radians(90));
    rotateX(-frameCount * this.speed_sat  / 100.0 + radians(90));
  
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  // ####################  #################### 
  
  // #################### box3 ####################
    pushMatrix();
  //rotateY(-radians(45));
    rotateY(-radians(90));
    rotateX(-frameCount * this.speed_sat  / 100.0 + radians(270));
  
    translate(0, 0, -200);
  //stroke(56,165,205);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  // ####################  #################### 
  
  // #################### box4 ####################
    pushMatrix();
    rotateX(frameCount * this.speed_sat  / 100.0);
  
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  // ####################  #################### 
  
  // #################### box5 ####################
    pushMatrix();
    rotateY(-frameCount * this.speed_sat  / 100.0 + radians(90));
  
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
    // ####################  #################### 
 
    // #################### box6 ####################
    pushMatrix();
    rotateY(-frameCount * this.speed_sat  / 100.0 + radians(270));
    translate(0, 0, -200);
    stroke(this.sat_color);
    box(25);
    popMatrix();
  }

  fill(curr_fill);
  stroke(curr_stroke);

  }
  
  // translate function has the same footprint as the constructor.
  // but without the tickness.
  void move(int new_x, int new_y, int new_s){
    this.x_step = (new_x - this.x) / 50.0;
    this.y_step = (new_y - this.y) / 50.0;
    this.s_step = (new_s - this.s) / 50.0;
    this.new_x = new_x;
    this.new_y = new_y;
    this.new_s = new_s;
    this.translate = true;
    this.step = 0;
  }
  void updateSpeed(float speed_sphere, float speed_sat)
  {
     this.speed_sphere = speed_sphere; 
     this.speed_sat = speed_sat;
  }
  void updateSphereColor(color sphere_color)
  {
      this.sphere_color = sphere_color;
  }
  
  void updateSatColor(color sat_color)
  {
    this.sat_color = sat_color;
  }
  
}
