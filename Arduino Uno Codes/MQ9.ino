
int MQ9 = A4;
// MQ-9 Sensor


void setup() {
  
  pinMode(MQ9, INPUT);
  Serial.begin(9600);
}

void loop() {
  int analogSensor = analogRead(MQ9);

  Serial.print("MQ-9 denisty detected = ");
  Serial.print(analogSensor);
  Serial.println(" ppm");
  
  delay(10);
}
