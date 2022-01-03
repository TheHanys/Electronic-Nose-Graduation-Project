
int MQ5 = A1;
// MQ-5 Sensor


void setup() {
  
  pinMode(MQ5, INPUT);
  Serial.begin(9600);
}

void loop() {
  int analogSensor = analogRead(MQ5);

  Serial.print("MQ-5 denisty detected = ");
  Serial.print(analogSensor);
  Serial.println(" ppm");
  
  delay(10);
}
