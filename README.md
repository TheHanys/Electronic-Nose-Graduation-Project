# Electronic-Nose-Graduation-Project
The E-Nose is divided into four sectors. Starting with the hardware components, It is built using Arduino-Uno. The Arduino-Uno is a micro-controller that is used to gather inputs via various sensors. An array of Mx Sensors, as well as ultrasonic motion sensors is halted on the micro-controller to detect various gases. Depending on the gases detected, the sensor mechanism will generate voltages. The Arduino-Uno will use ADC (Analog to Digital Converter) to convert the signal provided by the sensors from Analog to binary values.

 Data acquired through the ADC undergoes the pre-processing phase; Which consists of numerous stages. Normalization is the process in which you change the values of numeric columns in the dataset to use a common scale. Then there is the standardization process that involves bringing data into a uniform format that allows people to research the data. The data is then scaled to normalize the range of independent variables of the data. Then, feature selection is applied by dropping the features we don't need.

 After that, we start building our model and processing it, using either Training/Testing Split or Cross-Validation. In the training or testing split, the process entails partitioning a dataset into two subgroups. The training dataset is the initial subset, which is used to fit the model. The second subset is not used to train the model; instead, the dataset's input element is fed into the model, which then makes predictions and compares them to the estimated parameters. Cross-validation is a resampling strategy for testing and training a model on different iterations that uses different chunks of the data. It's mainly utilized in situations when the aim is to anticipate how well a predictive model will perform in practice.

 Furthermore, the Odors and the motion are then classified to output the result. The sensors check the output results by comparing them to the data sets. This procedure classifies which gas was detected by the sensors.

 In the last stage, the signals will be analyzed to detect any abnormalities, If so, a notification will be sent to the user on a mobile application.

<img width="550" alt="SO" src="https://user-images.githubusercontent.com/76770296/157508107-dc94eb87-3771-4f17-9017-c3de435a4aca.PNG">
