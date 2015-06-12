//
// BCEC_Marquee
//
// (c) Mark J Stock 2015
//

// Which screen are we generating imagery for this time?
// 0 is left, 1 is right, 2 is top
int useScreen = 0;

// When doing final recording, set this to true
Boolean record = false;
int maxFrames = 899;

// These are the actual screen sizes
int[] screenx = { 594, 550, 864 };
int[] screeny = { 264, 264, 1024 };

int width = screenx[useScreen];
int height = screeny[useScreen];

// How many frames have been written
int wroteFrame = 0;

String prefix;

void setup() {
  size(width, height);
  frameRate(30);
  
  //noFill();
  noStroke();
  smooth();
  strokeWeight(2.0);

  background(0);
  
  if (useScreen == 0) {
    // high-res left screen
    prefix = "left_####.png";
  } else if (useScreen == 1) {
    // high-res right screen
    prefix = "right_####.png";
  } else {
    // low-res top screen
    prefix = "top_####.png";
  }
}

void draw() {
  
  if (useScreen == 0) {
    // high-res left screen
    stroke(127,0,0,255);
    fill(127,0,0,63);
    float rad = random(10,30);
    ellipse(random(10, width-10), random(10, height-10), rad, rad);
    
  } else if (useScreen == 1) {
    // high-res right screen
    stroke(0,127,0,255);
    fill(0,127,0,63);
    float rad = random(10,30);
    ellipse(random(10, width-10), random(10, height-10), rad, rad);
    
  } else {
    // low-res top screen
    stroke(0,0,127,255);
    fill(0,0,127,63);
    float rad = random(10,30);
    ellipse(random(10, width-10), random(10, height-10), rad, rad);
  }
  
  // dump frames, but at the proper speed
  if (record) {
    saveFrame(prefix);
    wroteFrame++;
  
    // quit at the right time
    if (wroteFrame == maxFrames) {
      println("Wrote "+maxFrames+" frames.");
      exit();
    }
  }
}

// for testing, just hit 'p' to drop a frame
void keyPressed() {
  if (key == 'p') {
    saveFrame("img_#####.png");
    println("wrote frame "+frameCount);
  }
}

