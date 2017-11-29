PShape usa;
PShape state;
Table poverty100;
Table poverty125;
Table poverty50;
Table fat;
PFont font;
Boolean mouseShowText = false;
int TextmouseX;
int TextmouseY;
String currentstate;


String[] states={ "HI", "RI", "CT", "MA", "ME", "NH", "VT", "NY", "NJ",
         "FL", "NC", "OH", "IN", "IA", "CO", "NV", "PA", "DE", "MD", "MI",
         "WA", "CA", "OR", "IL", "MN", "WI", "DC", "NM", "VA", "AK", "GA", "AL", "TN", "WV", "KY", "SC", "WY", "MT",
         "ID", "TX", "AZ", "UT", "ND", "SD", "NE", "MS", "MO", "AR", "OK",
         "KS", "LA"};

PGraphics pg; // hiddenMap

int rectX, rectY;      // Position of square button
int circleX1, circleY1,circleX2, circleY2,circleX3, circleY3;  // Position of circle button
int rectSize = 20;     // Diameter of rect
int circleSize = 20;   // Diameter of circle
color rectColor, circleColor, baseColor;
color rectHighlight, circleHighlight;
Table currentTable;
boolean rectOver = false;
boolean circleOver1 = false;
boolean circleOver2 = false;
boolean circleOver3 = false;

 
void setup() {
  size(1110, 650);
  
  pg = createGraphics(950, 600);
  

  
  font = createFont("SansSerif", 10);
    rectHighlight = color(51);
  circleColor = color(255);
  circleHighlight = color(204);
  baseColor = color(102);
  
  poverty100 = new Table("100.csv");
  poverty125 = new Table("125.csv");
  poverty50 = new Table("50.csv");
  fat = new Table("obe.csv");
  currentTable = poverty100;
  
  circleX1 = 880;
  circleY1 = 510;
  circleX2 = 880;
  circleY2 = 530;
  circleX3 = 880;
  circleY3 = 550;
  rectX = 869;
  rectY = 570;
  ellipseMode(CENTER);
  
  usa = loadShape("Blank_US_Map_(states_only).svg");

  smooth(); // Improves the drawing quality of the SVG
  
   pg.beginDraw();
    pg.background(0);
    for (int i = 0; i < states.length; ++i) {
    PShape state = usa.getChild(states[i]);
    // Disable the colors found in the SVG file
    state.disableStyle();
    // Set our own coloring
    pg.fill(i+10,0,0);  // !!!!!!!!!!!!!!!!!!!!!!!!!
    pg.noStroke();
    // Draw a single state   
  pg.shape(state, 0, 0);
  }
  pg.endDraw();

}
 
void draw() {
  background(255);
  // Draw the full map
  shape(usa, 0, 0);
  
  textSize(15);fill(0);
  text("2015 100%poverty line",892,514);
  text("2015 125%poverty line",892,536);
  text("2015 50%poverty line",892,558);
  text("2015 obesity rate",890,588);
  
  // Blue denotes states won by Obama
  if(currentTable != fat){if(currentTable==poverty100){
  for (int i = 1; i < currentTable.getRowCount(); i++) {
  statesColoring(currentTable.getString(i,0), (1-(currentTable.getFloat(i,3)-9.2)/12.3)*510);
  }}
  else if(currentTable==poverty50){
  for (int i = 1; i < currentTable.getRowCount(); i++) {
  statesColoring(currentTable.getString(i,0), (1-(currentTable.getFloat(i,3)-3)/7.1)*510);
  }}
  else if(currentTable==poverty125){
  for (int i = 1; i < currentTable.getRowCount(); i++) {
  statesColoring(currentTable.getString(i,0), (1-(currentTable.getFloat(i,3)-13.4)/(28.1-13.4))*510);
  }}
  }
  else {
     for (int i = 1; i < currentTable.getRowCount(); i++) {
  statesColoring(currentTable.getString(i,0), (1-(currentTable.getFloat(i,1)-17.9)/(35.2-17.9))*510);
  }
  }
  update(mouseX, mouseY);
  if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
  
  if (circleOver1) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX1, circleY1, circleSize, circleSize);
  
    if (circleOver2) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX2, circleY2, circleSize, circleSize);
  
    if (circleOver3) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX3, circleY3, circleSize, circleSize);
  
  if(mouseShowText==true){if(currentTable !=fat){textSize(20);fill(0, 200, 153);
    text(currentstate+" Poverty% "+currentTable.getString(currentstate,3),TextmouseX, TextmouseY);
  }
  else {textSize(20);fill(0, 200, 153);text(currentstate+" Obesity% "+fat.getString(currentstate,1),TextmouseX, TextmouseY);}
  }
}
 
void statesColoring(String state, float c){
    PShape statep = usa.getChild(state);
    // Disable the colors found in the SVG file
   statep.disableStyle();
    // Set our own coloring
    //fill(c/2);
    if(c>255)
    fill(255,255,c-255);
    else
    fill(255,c,0);
    noStroke();
    // Draw a single state
    shape(statep, 0, 0);
}

void update(int x, int y) {
  if ( overCircle(circleX1, circleY1, circleSize) ) {
    circleOver1 = true;
    rectOver = false;
    circleOver2 = false;
    circleOver3 = false;
  } else if ( overRect(rectX, rectY, rectSize, rectSize) ) {
    rectOver = true;
    circleOver1 = false;
    circleOver2 = false;
    circleOver3 = false;
  } 
  else if ( overCircle(circleX2, circleY2, circleSize) ) {
    rectOver = false;
    circleOver1 = false;
    circleOver2 = true;
    circleOver3 = false;
  }
  else if ( overCircle(circleX3, circleY3, circleSize) ) {
    rectOver = false;
    circleOver1 = false;
    circleOver2 = false;
    circleOver3 = true;
  }
  else {
    circleOver1 = rectOver = circleOver2 = circleOver3 = false;
  }
}

void mousePressed() {
  if (circleOver1) {
    currentTable = poverty100;
  }
  else  if (circleOver2) {
    currentTable = poverty125;
  }
  else  if (circleOver3) {
    currentTable = poverty50;
  }
  else if (rectOver) {
    currentTable = fat;
  }
}

void mouseReleased() {
  int numberOfState = int(red(pg.get(mouseX, mouseY)));
  numberOfState -= 10; 
  if (numberOfState<0 || numberOfState>49)
  {
    mouseShowText=false;
  }
  else { mouseShowText=true;TextmouseX=mouseX;TextmouseY=mouseY;currentstate = states[numberOfState];}
}



  

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}