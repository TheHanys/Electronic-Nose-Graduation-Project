
const int MQ2 = A0;
const int MQ5 = A1;
const int MQ6 = A2;
const int MQ8 = A3;
const int MQ9 = A4;
const int MQ135 = A5;
// All MQ sensors


void smoke(){
   Serial.println("Smoke detected! Check your surroindings");
  }

  void gasleak(){
   Serial.println("Gas Leak detected! You might check your cooker or pipes");
  }


  void hydrogen(){
   Serial.println(High hydrogen levels! could be from pesticides or burning wood");
  }

  void airquality(){
   Serial.println("Bad Air Quality! Take care");
  }
  
void setup() {
  
  pinMode(MQ2, INPUT);
  pinMode(MQ5, INPUT);
  pinMode(MQ6, INPUT);
  pinMode(MQ8, INPUT);
  pinMode(MQ9, INPUT);
  pinMode(MQ135, INPUT);
  Serial.begin(9600);
}

void loop() {
  int M2 = analogRead(MQ2);   // threshold 110
  int M5 = analogRead(MQ5);   //threshold 155
  int M6 = analogRead(MQ6);   //threshold 210
  int M8 = analogRead(MQ8);   //threshold 170
  int M9 = analogRead(MQ9);   //threshold 120
  int M135 = analogRead(MQ135);  //threshold 380

if (M2 >  110) 
{
  smoke();
}


if (M5 >  155 || M6 >  210 || M8 >  170 ) 
{
  gasleak();
}


if (M9 >  120) 
{
  hydrogen();
}


if (M135 >  380) 
{
  airquality();
}
  delay(60000);
}
