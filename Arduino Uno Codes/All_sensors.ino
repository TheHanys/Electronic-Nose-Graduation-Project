
int MQ2 = A0;
int MQ5 = A1;
int MQ6 = A2;
int MQ8 = A3;
int MQ9 = A4;
int MQ135 = A5;
// MQ All sensors


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
  int analogSensor1 = analogRead(MQ2);
  int analogSensor2 = analogRead(MQ5);
  int analogSensor3 = analogRead(MQ6);
  int analogSensor4 = analogRead(MQ8);
  int analogSensor5 = analogRead(MQ9);
  int analogSensor6 = analogRead(MQ135);

  Serial.print("MQ-2 denisty detected = ");
  Serial.print(analogSensor1);
  Serial.println(" ppm");

   Serial.print("MQ-5 denisty detected = ");
  Serial.print(analogSensor2);
  Serial.println(" ppm");

   Serial.print("MQ-6 denisty detected = ");
  Serial.print(analogSensor3);
  Serial.println(" ppm");

   Serial.print("MQ-8 denisty detected = ");
  Serial.print(analogSensor4);
  Serial.println(" ppm");

   Serial.print("MQ-9 denisty detected = ");
  Serial.print(analogSensor5);
  Serial.println(" ppm");

   Serial.print("MQ-135 denisty detected = ");
  Serial.print(analogSensor6);
  Serial.println(" ppm");

  Serial.println("---------------------------------");
  delay(1000);
}
