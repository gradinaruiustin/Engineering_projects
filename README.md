# Electronics Projects Collection

This repository contains several electronics projects, including LED sequencers, power supplies, signal generators, digital clocks, and FM/AM radios. Each project includes the purpose, components, working principle, and schematics.  

## 1. LED Sequencer / LED Assembly (NE555 + CD4017)

### Introduction and Purpose
The LED sequencer is an electronic circuit used to generate a repetitive sequence of pulses that activate LEDs one by one, creating a visually appealing cyclic display.

### Components and Functions
- **NE555 Timer (Astable Mode):** Generates continuous rectangular digital pulses. Frequency and duty cycle are adjustable using a potentiometer.  
- **CD4017 (Johnson Decade Counter):** Advances the output sequentially with each clock pulse, controlling each LED in order.  
- **LEDs with Resistors:** Emit light while resistors limit current to protect LEDs.  
- **Potentiometer:** Adjusts NE555 pulse frequency, changing the LED sequence speed.  

### Working Principle
NE555 produces a pulse train applied to CD4017’s clock input. Each pulse lights a specific LED sequentially. The potentiometer changes the speed of the LED sequence.

### Components List
| No | Component | Symbol | Specification | Quantity |
|----|-----------|--------|---------------|----------|
| 1  | IC | U1 | NE555 | 1 |
| 2  | IC | U2 | CD4017 | 1 |
| 3  | Resistor | R1–R10 | 1kΩ | 10 |
| 4  | Resistor | R11 | 10kΩ | 1 |
| 5  | Resistor | R12 | 2kΩ | 1 |
| 6  | Capacitor | C1, C2 | 1µF | 2 |
| 7  | LED | D1–D10 | 5mm | 10 |
| 8  | Potentiometer | RV1 | 50kΩ | 1 |

## 2. Adjustable Voltage Regulated Power Supply (LM317)

### Introduction and Purpose
Provides a stable voltage to power circuits regardless of variations in input voltage or load.

### Components and Functions
- **LM317 Adjustable Voltage Regulator:** Maintains constant output voltage using internal reference and feedback.  
- **Resistors & Potentiometer:** Set output voltage according to formula:  
  `Vout = Vref × (1 + R1/R2) + Iadj × R2`  
- **Filter Capacitors:** Reduce noise and prevent oscillations.  
- **Protection Diodes:** Prevent damage due to reverse polarity or overvoltage.  
- **Heatsink:** Dissipates heat from voltage drop across LM317.  

### Working Principle
LM317 monitors output voltage and adjusts current internally to maintain stable voltage regardless of load or input changes.

### Components List (Selected)
| No | Component | Symbol | Specification | Quantity |
|----|-----------|--------|---------------|----------|
| 1  | Resistor | R1 | 240Ω | 1 |
| 2  | Potentiometer | R5 | 100kΩ | 1 |
| 3  | Capacitor | C1, C4 | 680µF / 25V | 2 |
| 4  | IC | U1 | LM317T | 1 |
| 5  | Diodes | D1–D6 | 1N4007 | 6 |
| 6  | Transformer | T1 | AC 12V – 2.5W | 1 |

## 3. Signal Generator (ICL8038)

### Introduction and Purpose
Generates sinusoidal, triangular, and square waves with adjustable frequency and amplitude, useful for testing and calibration.

### Components and Functions
- **ICL8038:** Produces multiple waveform types simultaneously.  
- **Resistors & Capacitors:** Set frequency and waveform shape.  
- **Potentiometers:** Adjust frequency and amplitude.  
- **Transistor 9013:** Acts as buffer for stable output.  

### Working Principle
ICL8038 generates square pulses that are integrated into triangle waves. Harmonic filtering produces sine waves. Outputs are available on dedicated pins.

### Components List (Selected)
| No | Component | Symbol | Specification | Quantity |
|----|-----------|--------|---------------|----------|
| 1  | IC | IC1 | ICL8038 | 1 |
| 2  | Transistor | T1 | 9013 | 1 |
| 3  | Potentiometer | RP1 | 10kΩ | 1 |
| 4  | LED | D1 | 3mm red | 1 |
| 5  | Capacitors | C1, C2… | Various | Multiple |

## 4. 4-Digit Digital Clock (DIY Kit)

### Introduction and Purpose
Digital clock displaying hours and minutes with precision, adjustable via tactile buttons.

### Components and Functions
- **Microcontroller 89C2051:** Controls timekeeping, display, and button inputs.  
- **12 MHz Crystal Oscillator:** Provides precise clock signal.  
- **4-Digit 7-Segment Display:** Shows time using multiplexing.  
- **Tactile Buttons:** Adjust hours and minutes.  
- **Buzzer:** Provides audio feedback for actions and alarms.  

### Working Principle
Oscillator provides timing. Microcontroller uses multiplexing to update 7-segment displays. Buttons modify internal variables to adjust time. Buzzer signals user interaction.

### Components List (Selected)
| No | Component | Symbol | Specification | Quantity |
|----|-----------|--------|---------------|----------|
| 1  | Microcontroller | U1 | 89C2051 | 1 |
| 2  | Display | DS1 | 4-digit, 7-segment | 1 |
| 3  | Crystal | Y1 | 12 MHz | 1 |
| 4  | Buzzer | LS1 | Active | 1 |
| 5  | Button | S1, S2 | 6×6×6 mm | 2 |

## 5. FM/AM Radio CF210SP

### Introduction and Purpose
Receives FM and AM signals, decodes them, and outputs audio, demonstrating radio reception, demodulation, and audio amplification.

### Components and Functions
- **CD9088/CD7642:** Demodulate FM and AM signals.  
- **TDA2822 Audio Amplifier:** Boosts audio signal for speaker.  
- **Coils and Variable Capacitor:** Tune desired frequency.  
- **Speaker:** Converts electrical signals into sound.  

### Working Principle
Antenna captures electromagnetic signals. Resonant circuit selects the desired frequency. Demodulator extracts audio, and amplifier drives the speaker.

### Components List (Selected)
| No | Component | Symbol | Specification | Quantity |
|----|-----------|--------|---------------|----------|
| 1  | IC | IC1 | CD9088 | 1 |
| 2  | IC | IC2 | CD7642 | 1 |
| 3  | IC | IC3 | TDA2822 | 1 |
| 4  | Coils | L1, L2 | 7T5, 8T5 | 2 |
| 5  | Variable Capacitor | CA, CB | CBM-444 | 1 |
| 6  | Speaker | — | φ40 mm | 1 |
| 7  | Potentiometer | VOL | 10kΩ | 1 | 
