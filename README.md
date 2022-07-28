# tec-I2C
 
 When can we prefer SPI over I2C?
As a very simplified rule of thumb, you might say that SPI is a better choice for the small number of peripherals that need to transfer a large amount of data (fast , 4 wire). I2C is the best option if you need to control many peripherals, especially if you are transferring a small amount of data to each one ( slower with 2 wire).
 
 
 
- model from the ref examples to port i2c to the tec-1
- https://easyeda.com/editor#id=4ec3298aecf449f3be1aadabb0c80a82
- https://github.com/SteveJustin1963/tec-Tiny-RTC
- 

### i2c toys, devices, etc
- Accelerometers
- Actuators
- ADCs
- Amplifiers
- Analog-to-digital converters
- Audio codecs
- Automotive sensors
- Biometric sensors
- Bluetooth modules
- Cameras
- CAN controllers
- Climate sensors
- CO2 sensors
- Current sensors
- DACs
- Digital-to-analog converters
- Displays
- DVD players
- EEPROM memory
- Environmental sensors
- Ethernet controllers
- Firewire controllers
- Gaming controllers
- GPS modules
- Gyroscopes
- Headphones
- I/O expanders
- Industrial sensors
- Infrared sensors
- Joysticks
- Keyboards
- LCD displays
- LED drivers
- Light sensors
- Magnetometers
- Memory chips
- Mice
- Microphones
- Monitors
- Motor drivers
- OLED displays
- Optical sensors
- Optocouplers
- Pressure sensors
- Printers
- Real-time clocks
- Relay drivers
- Scanners
- SD card interfaces
- SD cards
- SDIO controllers
- servo  
  - https://www.auselectronicsdirect.com.au/16-channel-12-bit-pwm-servo-motor-driver-module-pc?gclid=Cj0KCQjw54iXBhCXARIsADWpsG_12rQjCZjtpo01LxsLLkQ_KE3-Nj6plgwsNtYB68HU6dnAP4un6FwaAvUJEALw_wcB
  - https://core-electronics.com.au/adafruit-16-channel-12-bit-pwm-servo-driver-i2c-interface-pca9685.html
- Security chips
- Security sensors
- Serial EEPROMs
- Soil moisture sensors
- Solenoid drivers
- Speakers
- Temperature sensors
- Touchscreens
- TVs
- USB chips
- USB controllers
- Video codecs
- Voltage regulators
- Webcams
- Wi-Fi modules
- Wireless transceivers

## References
 
- https://k1.spdns.de/Develop/Hardware/K1-Bus%20Z80%20CPU%20board%20with%20SRAM/
- https://github.com/Kris-Sekula/CA80/blob/master/RTC/RTC_0x2000_0x2300_v1.4.asm
- https://mygeekyhobby.com/2020/04/06/i2c-bit-banging-on-z80-with-8255a/
- https://github.com/1971Merlin/SPI2C
- https://github.com/VladimirBakum/Z80/blob/master/I2C.asm  see my comments in the code
- 
- 

