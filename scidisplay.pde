/*
Author: Conrad Selig
Version: 1.0
Late Update Date: 12 / 28 / 19

Description: Scirect draws a single rectangle when given an x, y point
(for the top left of the rectangle), a width (w) and a height (h). A Scirect
also needs a thickness (t) for the stroke.
The animation occures is called when .render() is called. All animations take exactly 50 frames
(or steps). The first 50 frames are the initial drawing of the rectangle.
.translate() can be called to smoothly change the location and/or size of the
rectangle. .translate() is called once to give the new location and/or size, and
then .render() is again used to animate the rectangle.
*/
class scirect {
  // thickness integer
  int t;
  // location values, floats are used so smooth movements can me drawn.
  float x, y, w, h, step;
  // integer locations for the new location from .tranlsate()
  int new_x, new_y, new_w, new_h;
  // increment and step values - both used for animations
  float v_inc, h_inc, x_step, y_step, w_step, h_step;
  // boolean tracking if a translation animation is being drawn or not
  boolean translate;
  
  // contructor
  scirect(int x, int y, int w, int h, int t){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.t = t;
    this.step = 0;
    this.v_inc = h*(4.0/50) - 1;
    this.h_inc = w*(4.0/50) - 1;
    translate = false;
  }
  
  // the render function has three main blocks. Translation mode, initial drawing
  // mode, and static drawing mode.
  void render(){
    // save the current fill and stroke data, this is so they can be set back to
    // what they were at the end of the function.
    color curr_fill = g.fillColor;
    int stroke = g.strokeColor;
    float stroke_w = g.strokeWeight;
    
    // first mode
    if(this.translate) { //translation mode

      // calculate the next place to render the rectangle. Each step is based
      // off of the previous step.
      this.x = (this.step < 25) ? this.x + (this.step + 1) * ((this.x_step * 50) / 2 / 338) : this.x + (51 - (this.step)) * ((this.x_step * 50) / 2 / 338);
      this.y = (this.step < 25) ? this.y + (this.step + 1) * ((this.y_step * 50) / 2 / 338) : this.y + (51 - (this.step)) * ((this.y_step * 50) / 2 / 338);
      this.h = (this.step < 25) ? this.h + (this.step + 1) * ((this.h_step * 50) / 2 / 338) : this.h + (51 - (this.step)) * ((this.h_step * 50) / 2 / 338);
      this.w = (this.step < 25) ? this.w + (this.step + 1) * ((this.w_step * 50) / 2 / 338) : this.w + (51 - (this.step)) * ((this.w_step * 50) / 2 / 338);
      
      // ensure the alpha of the fill is 0.
      fill(curr_fill, 0);
      // draw the rectangle in the new location
      rect(this.x, this.y, this.w, this.h);
    
      // increment the step
      this.step += 1;
      
      // if the step if 51, or the animation is complete
      if(this.step == 51){ 
        // change all of the variables, this is so static mode can be drawn with
        // very little processing power.
        this.translate = false;
        this.x = this.new_x;
        this.y = this.new_y;
        this.w = this.new_w;
        this.h = this.new_h;
      };
      
    // second mode
    } else if(this.step > 50){ //static mode
    
      // set fill to 0 alpha
      fill(curr_fill, 0);
      // make the stroke weight = to the given thickness.
      // -1 is used so that that the thickness looks = to line thickness.
      strokeWeight(this.t - 1);
      // draw the rectangle
      rect(this.x, this.y, this.w, this.h);
      
    // third mode
    } else { // initial drawing
      
      // fill with the stroke color, thats because all of the initial
      // "lines" are actually rectangles
      fill(stroke);
      // if the user has set strokeWeight = 0; Don't draw anything
      noStroke();
      
      // first line
      if(this.step < Math.round(50/4)){
        rect(x, y, t, this.v_inc * this.step);
      }
      // second line
      else if(this.step > Math.round(50/4) - 1 && this.step < Math.round(100/4)){
        rect(x, y, t, h);
        rect(x, y + h - t, this.h_inc * (this.step - 50/4), t);
      }
      // third line
      else if(this.step > Math.round(100/4) - 1 && this.step < Math.round(150/4)){
        rect(x, y, t, h);
        rect(x, y + h - t, w, t);
        rect(x + w - t, (y + h) - this.v_inc * (this.step - 100/4), t, this.v_inc * (this.step - 100/4));
      }
      // fourth line
      else if(this.step > Math.round(150/4) - 1){
        rect(x, y, t, h);
        rect(x, y + h - t, w, t);
        rect(x + w - t, y, t, h);
        rect((x + w) - this.h_inc * (this.step - 150/4), y, this.h_inc * (this.step - 150/4), t);
      }
      // increment the step for the next rendering
      this.step++;
    }
    // reset the fill and stroke values
    fill(curr_fill);
    stroke(stroke);
  }
  
  // translate function has the same footprint as the constructor.
  // but without the tickness.
  void translate(int new_x, int new_y, int new_w, int new_h){
    this.x_step = (new_x - this.x) / 50.0;
    this.y_step = (new_y - this.y) / 50.0;
    this.w_step = (new_w - this.w) / 50.0;
    this.h_step = (new_h - this.h) / 50.0;
    this.new_x = new_x;
    this.new_y = new_y;
    this.new_w = new_w;
    this.new_h = new_h;
    this.translate = true;
    this.step = 0;
  }

  // reset the shape, this is so that the initial drawing animation will play again
  void reset(){
    this.step = 0;
  }

}


/*
Author: Conrad Selig
Version: 1.0
Late Update Date: 12 / 28 / 19

Description: Scidroprect draws a single rectangle when given an x, y point
(for the top left of the rectangle), a width (w) and a height (h). A Scirect
also needs a thickness (t) for the stroke.
The animation occures is called when .render() is called. All animations take exactly 50 frames
(or steps). The first 50 frames are the initial drawing of the rectangle.
.translate() can be called to smoothly change the location and/or size of the
rectangle. .translate() is called once to give the new location and/or size, and
then .render() is again used to animate the rectangle.
*/
class scidroprect {
  // thickness integer
  int t, a;
  // location values, floats are used so smooth movements can me drawn.
  float x, y, w, h, step;
  // integer locations for the new location from .tranlsate()
  int new_x, new_y, new_w, new_h;
  // increment and step values - both used for animations
  float x_step, y_step, w_step, h_step;
  // boolean tracking if a translation animation is being drawn or not
  boolean translate;
  
  // constructor
  scidroprect(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.step = 0;
    this.a = 255;
    this.translate = false;
  }
  
  // the render function has three main blocks. Translation mode, initial drawing
  // mode, and static drawing mode.
  void render(){
    if(this.translate) { //translation mode

      // calculating the location of the next rendering. Each step is calculated based off of the previous location
      this.x = (this.step < 25) ? this.x + (this.step + 1) * ((this.x_step * 50) / 2 / 338) : this.x + (51 - (this.step)) * ((this.x_step * 50) / 2 / 338);
      this.y = (this.step < 25) ? this.y + (this.step + 1) * ((this.y_step * 50) / 2 / 338) : this.y + (51 - (this.step)) * ((this.y_step * 50) / 2 / 338);
      this.h = (this.step < 25) ? this.h + (this.step + 1) * ((this.h_step * 50) / 2 / 338) : this.h + (51 - (this.step)) * ((this.h_step * 50) / 2 / 338);
      this.w = (this.step < 25) ? this.w + (this.step + 1) * ((this.w_step * 50) / 2 / 338) : this.w + (51 - (this.step)) * ((this.w_step * 50) / 2 / 338);
      
      // draw the shape
      rect(this.x, this.y, this.w, this.h);
    
      // increment the step (or frame) by one.
      this.step += 1;
      // if the animation is over...
      if(this.step == 51){ 
        // setup the variables for static drawing mode
        this.translate = false;
        this.x = this.new_x;
        this.y = this.new_y;
        this.w = this.new_w;
        this.h = this.new_h;
      };
    } else if(this.step > 50){ //static drawing
    
      // simply draw the shape
      rect(this.x, this.y, this.w, this.h);
      
    } else { // initial drawing
    
      // caluclate the alpha value
      this.a = Math.round(-cos(this.step * (PI / 50)) * 255 + 200);
      // set the fill color with the new alpha color
      fill(g.fillColor, this.a);
      // if there is a stroke
      if(g.stroke){
        // set the stroke alpha
        stroke(g.strokeColor, this.a);
      }
      // draw the shape with a calculated y location
      rect(this.x, this.y - cos((1/1.57) * pow(this.step * (PI / 100), 2)) *  50, this.w, this.h);
      // increase the step (or frame) by 1.
      this.step++;
    }
  }
  
  // translate function has the same footprint as the constructor.
  // but without the tickness.
  void translate(int new_x, int new_y, int new_w, int new_h){
    this.x_step = (new_x - this.x) / 50.0;
    this.y_step = (new_y - this.y) / 50.0;
    this.w_step = (new_w - this.w) / 50.0;
    this.h_step = (new_h - this.h) / 50.0;
    this.new_x = new_x;
    this.new_y = new_y;
    this.new_w = new_w;
    this.new_h = new_h;
    this.translate = true;
    this.step = 0;
  }
  
  // reset the shape, this is so that the initial drawing animation will play again
  void reset(){
    this.step = 0;
  }
  
}


/*
Author: Conrad Selig
Version: 1.0
Late Update Date: 12 / 31 / 19

Description: Scidroptext draws text when given an x, y point
(for the top left of the text), a color (c), and the text to render.
The animation occures is called when .render() is called. All animations take exactly 50 frames
(or steps). The first 50 frames are the initial drawing of the text.
.translate() can be called to smoothly change the location of the text.
.translate() is called once to give the new location, and
then .render() is again used to animate the text.
*/
class scidroptext {
  int a; // alpha value
  color c; // color for the text
  int x, y; // location
  int step; // aka frame
  String text; // text to display
  
  // constructor
  scidroptext(int x, int y, color c, String text) {
    this.c = c;
    this.x = x;
    this.y = y;
    this.text = text;
    this.step = 0;
    this.a = 255;
  }
  
  void render(){
    if(this.step > 50){
      fill(this.c, 255);
      noStroke();
      text(this.text, this.x, this.y);
    } else {
      this.a = Math.round(this.step * 5.1);
      fill(this.c, this.a);
      noStroke();
      text(this.text, this.x, this.y - cos((1/1.57) * pow(this.step * (PI / 100), 2)) *  50);
      this.step++;
      alpha(255);
    }
  
  }
  
  // reset the shape, this is so that the initial drawing animation will play again
  void reset(){
    this.step = 0;
  }
  
}
