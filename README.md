#Scopul Proiectului
Construirea unui robot umanoid inteligent, capabil să:
•	se deplaseze autonom sau manual într-un spațiu necunoscut,
•	să își monitorizeze în timp real statisticile interne (tensiune, curent),
•	să comunice cu MATLAB prin rețea WiFi (ESP32),
•	să permită editarea traseului dintr-o interfață 3D.

#Dezvoltare Hardware (HW)
#Componente Hardware

#Microcontrolere și plăci de dezvoltare:
#ESP32 (WiFi + Bluetooth) 
Specificatii(pentru procesare și conectivitate):
•	Procesor: ESP32-WROOM-32D
•	Programator: CP2102
•	Tensiune alimentare: 5VDC, prin MicroUSB
•	Conector: MicroUSB
•	Tensiune logica: 3.3V 
•	Procesor: Nucleu dual-core Tensilica LX6
•	Frecventa: pana la 240 MHz
•	Memorie SRAM: 520 KB
•	Memorie ROM: 448 KB de ROM pentru incarcatorul de boot si bibliotecile de sistem
•	Memorie FLASH: 4 MB
•	WiFi: 802.11 b/g/n/e/i (2.4 GHz)
•	Bluetooth: v4.2 BR/EDR si Bluetooth Low Energy (BLE)
•	Antena: integrata pentru WiFi si Bluetooth
•	Pini: 34 de pini de I/O (General Purpose Input/Output), inclusiv pini de intrare analogica
•	Comunicare: SPI, 12C, 12S, UART/USART pentru comunicare cu alte dispozitive
•	ADC: 12 biti ADC (Analog-to-Digital Converter) cu pana la 18 canale
•	DAC: 2 canale DAC (Digital-to-Analog Converter)
•	Securitate: Accelerator pentru criptografie (AES, SHA-2, ECC, RSA) Securitate WiFi: WPA/WPA2/ WPA3 personal si enterprise
•	Securitate Bluetooth BLE: criptare AES-CCM 

#Motoare și control motoare:
#MG996R Servo Motor 
Specificatii(pentru articulații (trunchi, picioare)):
•	Tensiune alimentare: 4.8 - 6.6V
•	Torque: 13Kg/cm la 6V
•	Consum maxim: 2.5A
•	Unghi efectiv: 180°
•	Greutate: 55g
•	Dimensiuni mm: 40.7 x 19.7 x 42.9mm

#SG90 Micro Servo 
Specificatii(pentru mișcări de finețe(cap,brate)):
•	Tensiune alimentare: 3 - 7.2VDC
•	Viteza functionare: 0,12 s/600 (la 4,8V)
•	Cuplu in blocare: 1Kg/cm la 4.8V
•	Dimensiuni mm: 22 x 11.5 x 22.5

#PCA9685 Servo Driver 
Specificatii(pentru controlul sincronizat al motoarelor):
•	Modul PCA9685, compatibil Arduino si alte placi de dezvoltare, va permite prin folosirea a doar 2 pini arduino, controlul separat a 16 iesiri PWM
•	Interfata input: 12C
•	Frecventa: 40-1000Hz
•	Numar canale PWM: 16
•	Rezolutie: 12bit
•	Tensiune: 5-10VDC
•	Dimensiuni mm: 60 x 25

#Senzori:
#HC-SR04 
Specificatii(senzor de distanță pentru navigare autonomă):
•	alimentare: 5V DC
•	curent de repaus: <2mA
•	unghi efectiv: <15°
•	distanta: 2cm – 500 cm
•	rezolutie: 0,3 cm

#MPU6050 
Specificatii(giroscop + accelerometru pentru echilibru și mișcare):
•	Chip: MPU-6050
•	Sursa de alimentare:3V-5V (Stabilizator tensiune intern)
•	Mod de comunicare: Protocol IIC standard
•	Chip built-in: 16bit AD converter, 16bit data output
•	Raza giroscop: ±250 500 1000 2000 o/s
•	Raza accelerometru:±2 ±4 ±8 ±16g
•	Spatiere pin:2.54mm
•	Dimensiune: 20.2 x 15.4mm

#INA219
Specificatii(senzor de current+ tensiune):
•	Rezistor de 0.1 ohm 1% 2W
•	Tensiune de pana la + 26V
•	Curent pana la ± 3.2A, cu rezolutie de ± 0.8 mA
•	Dimensiuni: 2.28cm x 2.03cm
•	Placa utilizeaza adresele I2C pe 7-bit adrese 0x40, 0x41, 0x44, 0x45

#Alte componente:
#LM2596 
Specificatii(reglează tensiunea pentru alimentarea corectă a componentelor):
•	Tensiune intrare: 3.20 - 40V
•	Tensiune iesire: Reglabila, 1.25-35V
•	Curent iesire: 2A, maxim 3A (necesita obligatoriu racire activa)
•	Functionare: Buck
•	Eficienta: 92%
•	Frecventa: 150KHZ
•	Ripple iesire: 30mV (maxim)
•	Regulator voltaj: +- 2.5%
•	Temperatura functionare: -40 - 85 grade C
•	Dimensiuni mm: 43 x 21 x 14

#Breadboard 400 points
#Jumper Wires 
#Power Bank USB (10,000mAh) 
#LiPo Battery 11.1V 2200mAh

#Putere și alimentare
•	Alimentare principală prin Power Bank pentru microcontrolere și module.
•	Alimentare separată pentru servo-motoare cu bateria LiPo (regulată de LM2596).

#Funcționalități și Moduri de Operare
Mod Autonom
•	Navigare: Robotul folosește senzorul HC-SR04 pentru detectarea obstacolelor și navigare sigură.
•	Decizii automate: Analizează informațiile primite de la senzori și decide acțiunile (mers, oprire, răspuns).

#Mod 2 Manual
•	Control la distanță: Robotul este operat prin aplicația MATLAB , folosind conexiunea WiFi.
•	Comenzi personalizate: Mișcările sunt controlate comenzi predefinite în aplicație.
•	Monitorizare în timp real: Datele de la senzori sunt afișate pe aplicație.

#Software și Biblioteci Utilizate
#Limbaj de programare:
•	MATLAB (MATLAB Language)
•	Arduino IDE (ESP32)

#Biblioteci:
#Pentru ESP32:
•	Servo - Folosit pentru controlul servo-motoarelor.
•	WiFi - Folosit pentru conectarea ESP32 la rețelele Wi-Fi, dacă este necesar pentru controlul prin rețea.
•	Wire - Permite comunicarea I2C cu senzori (de exemplu, MPU6050).
•	SoftwareSerial - Permite comunicarea serială prin pinii digitali ai Arduino.
•	Adafruit_PWMServoDriver - Folosit pentru controlul precis al servomotoarelor prin modulul PCA9685.
•	NewPing - Măsurare cu senzor ultrasonic HC-SR04
•	Adafruit_INA219 - Citire tensiune și curent (INA219)
•	MPU6050 - Folosit pentru măsurarea accelerației și giroscopului.
#Pentru MATLAB:
•	MATLAB TCP/IP Client - Comunicare cu ESP32 prin TCP
•	UI Figure + uiaxes, uipanel - Interfață grafică modernă MATLAB
•	datetime, writetable - Timp și salvare în Excel
•	ginput, plot3, split - Interacțiune și vizualizare


#Configurare
#Servo Motoare (SG90 și MG996R)
#Servo-motoarele controlează mișcările robotului: capul, brațele, picioarele și trunchiul.
#SG90 (pentru mișcări mai mici):
•	Cap: Conectat la canalul PWM 0 pe PCA9685.
•	Umăr Dreapta: Conectat la canalul PWM 2.
•	Umăr Stânga: Conectat la canalul PWM 3.
•	Cot Stânga: Conectat la canalul PWM 4.
•	Cot Dreapta: Conectat la canalul PWM 5.
#MG996R (pentru părți mai grele):
•	Trunchi: Canalul PWM 1.
•	Șold Dreapta: Canalul PWM 6.
•	Șold Stânga: Canalul PWM 7.
•	Genunchi Stânga: Canalul PWM 8.
•	Genunchi Dreapta: Canalul PWM 9.

#Conexiuni la PCA9685:
•	Conectează toate servo-motoarele la ieșirile PWM ale PCA9685.
•	Alimentează PCA9685 folosind un LM2596 (regulator de tensiune)
 pentru a furniza 5V stabili.
•	Semnalul PWM de la PCA9685 este conectat la servo-uri prin 
canalele corespunzătoare.

#Senzor Ultrasonic HC-SR04
#Acesta detectează obstacolele pentru modul autonom.
•	Trig: Conectat la pinul GPIO 5 de pe ESP32.
•	Echo: Conectat la pinul GPIO 18 de pe ESP32.
•	VCC: Alimentat cu 3.3V de la ESP32.
•	GND: Legat la masă (GND) comună.
#Montare: Plasează senzorul ultrasonic pe partea frontal
 a robotului, astfel încât să poată detecta obstacolele. 

#Driver pentru Servo PCA9685
#Acest driver permite controlul precis al până la 16 
servo-motoare.
•	VCC: Conectat la 5V.
•	GND: Conectat la masă comună.
•	SCL: Conectat la pinul GPIO 22 de pe ESP32 (SCL - I2C).
•	SDA: Conectat la pinul GPIO 21 de pe ESP32 (SDA - I2C).

#Pinii MPU-6050:
•	VCC: Conectat la 3.3V.
•	GND: Conectat la masă comună.
•	SCL: Conectat la pinul GPIO 22 de pe ESP32 (SCL - I2C).
•	SDA: Conectat la pinul GPIO 21 de pe ESP32 (SDA - I2C).

#Pinii INA219:
•	VCC: Conectat la 3.3V.
•	GND: Conectat la masă comună.
•	SCL: Conectat la pinul GPIO 22 de pe ESP32 (SCL - I2C).
•	SDA: Conectat la pinul GPIO 21 de pe ESP32 (SDA - I2C).

#Diagrame de Conectare
#Schema Logică:
#ESP32:
•	Controlează PCA9685 pentru semnalele PWM ale servo-motoarelor.
•	Gestionează senzorii:
•	HC-SR04 (senzor de distanță ultrasonic).
•	MPU-6050 (accelerometru și giroscop).
•	INA219(tensiune și curent)
•	Preia comenzi de la MATLAB și transmite date prin WiFi.
•	Transmite comenzile către PCA9685.
•	
#PCA9685:
•	Controlează toate servo-motoarele robotului (cap, umeri, coate, șolduri, genunchi).

#MATLAB:
•	Se conectează la ESP32 prin WiFi, preia datele de la acesta și le afișează într-o interfață grafică.

#Schema Electrică:
#Bateria LiPo:
•	Alimentează LM2596 (convertor de tensiune).
#LM2596:
•	Reglează tensiunea de la baterie pentru a furniza 5V stabil pentru:
•	PCA9685.
#Servo-motoarele:
•	Alimentate direct de la PCA9685 cu 5V.
#Power Bank USB (10,000mAh):
•	Asigură alimentarea ESP32 prin USB.
