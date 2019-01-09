int numDataPoints = 50000;
int dataIndex = 1;

void setup()
{
  size(800,800);
  
  String[] dataStrings = new String[numDataPoints]; 
  
    myPort = new Serial(this, "/dev/cu.usbmodem1411", 9600);

 for(int i = 0; i<8; i++)
  {
    portValues[i] = 0; 
  }
  dataStrings[0] = "x,y,z,leftButton,rightButton,lightSensor,soundSensor,tempSensor";
}

import processing.serial.*;   
 
 float[] portValues = new float[8];
 
 Serial myPort;
 
 String inString; 
 
 String buildDataString(float[] v) {
  String result = "";
  for(int i = 0; i<v.length-1; i++) {
   result += str(v[i]) + ","; 
  }
  result += str(v[7]);
  return result;
}

void draw() {
background(255);
noFill();
rectMode(CORNERS);

if (inString != null) {
    portValues = processSensorValues(inString); // get data
    // manage data points
    dataIndex++;
    if(dataIndex > numDataPoints - 1) {
     dataIndex = 1;
    }
}

 // get the x value from the acceleromoter, use to move object horizontally
  float x = map(portValues[1],-10,10,0,width);
  // get the y value from the accelerometer, use to move object vertically
  float y = map(portValues[0],-10,10,0,height);

if( 50 > x && 50 > y){if( x > 1 && y > 1) {fill(255,0,0);}}
rect(1,1,50,50);

if( 200 > x && 50 > y){if( x > 50 && y > 1){fill(0, 255, 0);}}
rect(50,1,200,50);

if( 200 < x && 50 > y){if( x < 750 && y > 1){fill(0,0,255);}}
rect(200,1,750,50);

if( 50 > x && 50 < y){if( x > 1 && y < 420){fill(242,157,67);}}
rect(1,50,50,420);

if( 50 < x && 50 < y){if( x < 200 && y < 420){fill(247,242,103);}}
rect(50,50,200,420);

if( 200 < x && 50 < y){if( x < 500 && y < 200){fill(103,247,156);}}
rect(200,50,500,200);

if( 200 < x && 200 < y){if( x < 500 && y < 420){fill(0,255,255);}}
rect(200,200,500,420);

if( 500 < x && 50 < y){if( x < 750 && y < 420){fill(255,0,255);}}
rect(500,50,750,420);

if( 50 > x && 420 < y){if( x > 1 && y > 1){fill(46,155,133);}}
rect(1,420,50,500);

if( 50 < x && 420 < y){if( x < 200 && y < 500){fill(46,95,155);}}
rect(50,420,200,500);

if( 200 < x && 420 < y){if( x < 750 && y < 500){fill(72,46,155);}}
rect(200,420,750,500);

println(inString);

}

void mouseMoved() {}



float[] processSensorValues(String valString) {
  
  String[] temp = {"0", "0", "0", "0", "0", "0", "0", "0"};
  
  temp = split(valString,"\t");
  
  if(temp == null) {
    for(int i = 0; i<8; i++) {
      temp[i] = "0"; 
    }
  }
  
  float[] vals = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0};
  for(int i = 0; i<8; i++)
  {
    if(temp != null) 
    {
      vals[i] = float(temp[i]); 
    }
    
    else
    {
      vals[i] = 0; 
    }
    
  }
  return vals;
}

// read new data from the Circuit Playground
void serialEvent(Serial p) { 
  inString = myPort.readStringUntil(10);  
} 
