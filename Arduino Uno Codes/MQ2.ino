
int MQ2 = A0;
// MQ-2 Sensor


void setup() {
  
  pinMode(MQ2, INPUT);
  Serial.begin(9600);
}

void loop() {
  int analogSensor = analogRead(MQ2);

  Serial.print("MQ-2 denisty detected = ");
  Serial.print(analogSensor);
  Serial.println(" ppm");
  
  delay(10);
}
