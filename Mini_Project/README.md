# Hardware
1. Raspberry Pi: Communication, Controlling, Processing
2. TELOSB: Sensing, Processing

# Software(Operating Systems)
1. Raspbian
2. TinyOS

# Technique
2. Flask
4. Sensing methods in TinyOS
3. GPIO library in Raspbian
3. html/css

# Scenario:
1. lab car with sensors, which can be remote controlled. We control the car driving to somewhere we want. And the sensor will sample the data(Temperature, Humidity, Light, Images) in real-time and delivered it to the web server running on the Raspberry Pi. The web server will visualize these data and we are able to see them when we access the web server through any device inside the network.
2. When the car ran into a dark area(L < threshold), the car should open its spotlight to make the camera capture the image successfully.
3. Also, the car should be able to take photos when users give commands( optional ).

# Implementation
## Video Transfer
2 methods:
1. Motion
2. Mjpg-Streamer
