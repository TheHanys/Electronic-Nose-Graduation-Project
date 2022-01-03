
int MQ6 = A2;
// MQ-6 Sensor


void setup() {
  
  pinMode(MQ6, INPUT);
  Serial.begin(9600);
}

void loop() {
  int analogSensor = analogRead(MQ6);

  Serial.print("MQ-6 denisty detected = ");
  Serial.print(analogSensor);
  Serial.println(" ppm");
  
  delay(10);
}
