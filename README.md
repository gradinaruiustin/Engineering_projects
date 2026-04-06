# Mini Humanoid Robot

## Project Goal
Development of a mini humanoid robot capable of operating in two distinct modes:  

- **Autonomous Mode** – The robot explores its surroundings and responds autonomously to user questions using advanced voice recognition.  
- **Manual Mode** – The robot is remotely controlled via a mobile app using Bluetooth.  

## Project Objectives
- Build a hardware platform that enables mobility and interaction with the environment.  
- Implement a voice recognition system using Google Speech-to-Text.  
- Develop an autonomous navigation algorithm using integrated sensors.  
- Ensure connectivity with a mobile app for manual control.  
- Display sensor data and responses directly on the mobile app via Bluetooth.  

## Hardware Development

### Hardware Components

**Microcontrollers and Development Boards**  

- **ESP32 (WiFi + Bluetooth)**
  - Processor: ESP32-WROOM-32D, dual-core Tensilica LX6, up to 240 MHz  
  - Memory: 520 KB SRAM, 448 KB ROM, 4 MB FLASH  
  - Connectivity: WiFi 802.11 b/g/n, Bluetooth v4.2 BLE  
  - I/O Pins: 34  
  - Power Supply: 5VDC, MicroUSB  

- **Arduino Uno R3**
  - 14 I/O pins, 6 PWM, 8 analog pins  
  - Frequency: 16 MHz  
  - Voltage: 5V, Communication: TWI, SPI, UART  

- **Raspberry Pi 3 Model B**
  - CPU Quad Core 1.2 GHz, 1 GB RAM  
  - Built-in WiFi + BLE, 40 GPIO pins  
  - HDMI, CSI camera port, DSI display port, MicroSD  

**Motors and Motor Control**  
- MG996R Servo Motor – For trunk and legs (Torque 13Kg/cm)  
- SG90 Micro Servo – For head and arms (Torque 1Kg/cm)  
- PCA9685 Servo Driver – Synchronized control for up to 16 servos  

**Sensors**  
- HC-SR04 – Distance sensor (2–500 cm)  
- MPU6050 – Gyroscope + accelerometer  

**Connectivity**  
- HC-05 Bluetooth Module – Mobile connection (range 10m, baud 9600–460800 bps)  

**Other Components**  
- Mini Speaker 8 Ohm 1W  
- LM2596 – Voltage regulator  
- Breadboard 400 points, MicroSD, Jumper Wires  
- Power Bank USB 10,000mAh, LiPo Battery 11.1V 2200mAh  

## Features and Operating Modes

### Mode 1: Autonomous
- Safe navigation using HC-SR04 sensor  
- Voice interaction with Google Speech-to-Text  
- Automatic decisions based on sensor data  

### Mode 2: Manual
- Remote control via mobile app (Bluetooth/WiFi)  
- Custom commands for movements  
- Real-time sensor monitoring  

## Software and Libraries
- **Languages:** Python (Raspberry Pi), Arduino IDE (ESP32, Arduino Uno)  
- **Voice Recognition:** SpeechRecognition, PyMycroft  
- **Sensors:** Adafruit_PCA9685, DHT, MPU6050  
- **Communication:** BluetoothSerial, WiFi, pySerial  
- **Text-to-Speech:** gTTS, PyAudio  
- **Web Server (optional):** Flask, Flask-SocketIO  

## Hardware Setup

### Servo Motors (SG90 and MG996R)
- SG90: Head, shoulders, elbows → PWM channels 0–5  
- MG996R: Trunk, hips, knees → PWM channels 1, 6–9  
- Connect to PCA9685 and supply stable 5V via LM2596  

### HC-SR04 Sensor
- Trig: D8, Echo: D9, VCC: 5V, GND common  

### HC-05 Bluetooth Module
- VCC: 5V, GND, TX → RX D10, RX → TX D11  

### MPU-6050
- VCC: 3.3–5V, GND, SDA → A4, SCL → A5  

## Wiring Diagram Overview
- Arduino Uno controls PCA9685 and sensors (HC-SR04, MPU6050)  
- PCA9685 controls all robot servo motors  
- ESP32 receives commands from Raspberry Pi and sends them to Arduino  
- Raspberry Pi handles voice recognition and control applications  
