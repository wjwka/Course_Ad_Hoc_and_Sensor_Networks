# Hardware
1. Raspberry Pi: Communication, Controlling, Processing
2. TELOSB: Sensing

# Software
1. Raspbian
2. TinyOS

# Scenario:
1. lab car with sensors, which can be remote controlled. We control the car driving to somewhere we want. And the sensor will sample the data(T, H, Images) in real-time and delivered it to the web server running on the Raspberry Pi. The web server will visualize this data and we can see it when we access the web server through any device inside the network.
2. When the car ran into a dark area(H < threshold), the car should open its spotlight to make the camera successfully capture the image.

# Video Transfer
2 methods:
1. Motion
2. Mjpg-Streamer
