
int MQ8 = A3;
// MQ-8 Sensor


void setup() {
  
  pinMode(MQ8, INPUT);
  Serial.begin(9600);
}

void loop() {
  int analogSensor = analogRead(MQ8);

  Serial.print("MQ-8 denisty detected = ");
  Serial.print(analogSensor);
  Serial.println(" ppm");
  
  delay(10);
}
