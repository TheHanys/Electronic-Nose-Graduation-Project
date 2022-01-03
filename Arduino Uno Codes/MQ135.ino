
int MQ135 = A5;
// MQ-135 Sensor


void setup() {
  
  pinMode(MQ135, INPUT);
  Serial.begin(9600);
}

void loop() {
  int analogSensor = analogRead(MQ5);

  Serial.print("MQ-135 denisty detected = ");
  Serial.print(analogSensor);
  Serial.println(" ppm");
  
  delay(10);
}
