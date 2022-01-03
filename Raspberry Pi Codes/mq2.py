import RPi.GPIO as GPIO
import time
 
#GPIO SETUP
channel = 27
GPIO.setmode(GPIO.BCM)
GPIO.setup(channel, GPIO.IN)
 
def callback(channel):
    print("Smoke Detected")
 
GPIO.add_event_detect(channel, GPIO.BOTH, bouncetime=200)  # To know when the pin goes High or Low
GPIO.add_event_callback(channel, callback)  # Assign function to GPIO PIN, Run function on change
 
# infinite loop
while True:
        time.sleep(1)
