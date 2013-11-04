import processing.video.*;

// Size of each cell in the grid, ratio of window size to video size
int videoScale = 8;
// Number of columns and rows in our system
int cols, rows;
// Variable to hold onto Capture object
Capture video;
PImage videoPreview;

color black = color(0);
color white = color(255);
int numPixels;
int skip = 1;
float ellipseDiameter;
float xPos, yPos;

String bin;


void setup() {
  size(640,480);
  //size(displayWidth, displayHeight);
  if (frame != null) {
    frame.setResizable(true);
  }
  
  // Initialize columns and rows
  cols = width/videoScale;
  rows = height/videoScale;
  video = new Capture(this,640,480);
  video.start();
  background(40);
  
  PFont font;
  font = loadFont("Ubuntu-Medium-12.vlw");
  textFont(font, 11);
}

void draw() {
  //videoScale = 20;
  background(60);
  if (video.available()) {
    video.read();
  }
  video.loadPixels();
  //image(video, 0, 0, width, height);
  float threshold = 107;
  
  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      //if (j < 16) { //crop the image to hte number of vertical pixels
      // Where are we, pixel-wise?
      int x = i*videoScale;
      int y = j*videoScale;
      // Looking up the appropriate color in the pixel array
      int loc = x +y *video.width;
      color c; // = video.pixels[x + y*video.width];
      if (brightness(video.pixels[loc]) > threshold) {
        video.pixels[loc]  = color(255);  // White
        c = color(white);
        bin = "1";
      }  else {
        video.pixels[loc]  = color(0);    // Black
        c = color(black);
        bin = "0";
      }
      //videoPreview = video;
      fill(c);
      stroke(0);
      noStroke();
      
      ellipseMode(CORNER);
      ellipseDiameter = 10*(height/480); 
      println(ellipseDiameter);
      //ellipse(x+5,y+5,videoScale/2,videoScale/2);
      
      xPos = int(x*(width/640));
      yPos = y*(height/480);
      //ellipse(xPos+ 5, yPos + 5,ellipseDiameter,ellipseDiameter);
      //rect(xPos, yPos, videoScale, videoScale);
      text(bin, xPos, yPos);
      }

    //}
  }
}

void keyPressed() {
     saveFrame("output/frames####.png"); 
}
