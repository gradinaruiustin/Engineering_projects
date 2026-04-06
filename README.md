# Planetary Exploration Robot

## Project Goal
The goal of this project is to build an intelligent humanoid robot capable of:  
- Moving autonomously or manually in an unknown environment  
- Monitoring internal statistics in real-time (voltage, current)  
- Communicating with MATLAB via WiFi (ESP32)  
- Allowing 3D trajectory editing from a MATLAB interface  

## Hardware Development

### Microcontrollers & Development Boards
**ESP32 (WiFi + Bluetooth)**  
- Processor: ESP32-WROOM-32D, dual-core Tensilica LX6, up to 240 MHz  
- Memory: 520 KB SRAM, 448 KB ROM, 4 MB Flash  
- Connectivity: WiFi, Bluetooth 
- Pins: 34 GPIO including analog inputs, SPI, I2C, UART  
- Power: 5V via MicroUSB, logic 3.3V   

### Motors & Motor Control
**MG996R Servo Motor** (trunk, legs)  
- Voltage: 4.8–6.6V, Torque: 13 kg/cm, 180° rotation  

**SG90 Micro Servo** (head, arms)  
- Voltage: 3–7.2V, Torque: 1 kg/cm, Speed: 0.12s/60°  

**PCA9685 Servo Driver**  
- PWM control of up to 16 servos using only 2 I2C pins  
- Frequency: 40–1000 Hz, Resolution: 12-bit  

### Sensors
**HC-SR04 (Ultrasonic Distance Sensor)**  
- Range: 2–500 cm, resolution: 0.3 cm, angle: <15°  

**MPU6050 (Gyroscope + Accelerometer)**  
- I2C, ±250–2000°/s gyroscope, ±2–16g accelerometer  

**INA219 (Voltage & Current Sensor)**  
- Measures up to ±26V, ±3.2A, I2C addresses: 0x40, 0x41, 0x44, 0x45  

### Other Components
- LM2596 Voltage Regulator (5V for servos)  
- Breadboard (400 points)  
- Jumper wires  
- Power Bank USB (10,000 mAh)  
- LiPo Battery 11.1V, 2200 mAh  

## Power Supply
- Main power for microcontrollers and modules via Power Bank  
- Servo motors powered separately via LiPo battery regulated by LM2596  

## Operating Modes

### Autonomous Mode
- Uses HC-SR04 sensor for obstacle detection  
- Makes decisions based on sensor data (movement, stop, response)  

### Manual Mode
- Controlled remotely via MATLAB over WiFi  
- Executes pre-defined commands from MATLAB interface  
- Real-time monitoring of sensor data  

## Software & Libraries

### Programming Languages
- MATLAB  
- Arduino IDE (ESP32)  

### Libraries for ESP32
- Servo, WiFi, Wire (I2C), SoftwareSerial  
- Adafruit_PWMServoDriver (PCA9685)  
- NewPing (HC-SR04)  
- Adafruit_INA219, MPU6050  

### Libraries for MATLAB
- TCP/IP Client (ESP32 communication)  
- UIFigure, uiaxes, uipanel (GUI)  
- datetime, writetable, ginput, plot3, split  

## Servo Motor Configuration

**SG90 (fine movements):**  
- Head → PWM 0  
- Right Shoulder → PWM 2  
- Left Shoulder → PWM 3  
- Left Elbow → PWM 4  
- Right Elbow → PWM 5  

**MG996R (heavier parts):**  
- Trunk → PWM 1  
- Right Hip → PWM 6  
- Left Hip → PWM 7  
- Left Knee → PWM 8  
- Right Knee → PWM 9  

**PCA9685 Connections:**  
- PWM outputs connected to servos  
- Powered by LM2596 5V stable  
- SDA → GPIO 21, SCL → GPIO 22  

## Sensor Connections

**HC-SR04:**  
- Trig → GPIO 5  
- Echo → GPIO 18  
- VCC → 3.3V, GND → common ground  

**MPU6050:**  
- SDA → GPIO 21, SCL → GPIO 22  
- VCC → 3.3V, GND → common ground  

**INA219:**  
- SDA → GPIO 21, SCL → GPIO 22  
- VCC → 3.3V, GND → common ground  

## System Schematics

### Logic Overview
- ESP32 sends PWM signals to PCA9685  
- PCA9685 drives servos (head, arms, legs, trunk)  
- ESP32 reads sensors (HC-SR04, MPU6050, INA219)  
- MATLAB GUI connects via WiFi, sends commands and visualizes sensor data  

### Electrical Flow
- LiPo battery → LM2596 → PCA9685 (5V) → Servos  
- Power Bank → ESP32 via MicroUSB  
