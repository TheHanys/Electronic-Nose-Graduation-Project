import processing.serial.*;
Serial mySerial;
PrintWriter output;

double initialTime=0;
double samplingTime=5000;
double time1;


void setup() {
  mySerial = new Serial ( this, "COM3" , 9600 );
  output = createWriter( "Alerts.txt");
  initialTime = millis();
}

void draw() {
  if(millis()/1000.0 <samplingTime){
    if (mySerial.available() > 0){
      String value1 = mySerial.readStringUntil(10);
      if (value1 !=null){
        time1=millis();
        
        output.print(value1);
        
        println(value1);
      }
    }
  }
}
void keyPressed(){
  output.flush();
  output.close();
  exit();
}
