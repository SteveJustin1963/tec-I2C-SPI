# tec-I2C-SPI
- https://www.facebook.com/groups/623556744820045/search/?q=I2C
- https://www.facebook.com/groups/623556744820045/search/?q=spi
- 

## Craig Hart 
has successfully completed a challenge involving the use of I2C and SPI busses. He is now discussing the possibility of using a Bitbanged SPI bus to communicate with an Arduino board. suggested using a Tec-1-mint and Ken Boak commented that Bitbanged SPI should be possible in MINT, but with a low clock frequency. 

Using is about the I2CSPI board, a development board for testing and experimenting with I2C and SPI bus interfaces. The board can be found on GitHub, with source code, schematics, and other details available. The board features a DS1207 based Real Time Clock, a MAX7219 8-digit 7-seg display, a 24LC16B 16k EEPROM, and soon an 84x48 OLED display. The board is being designed in KiCad and the code is being written by the author. There is more work to be done on the code and the design, such as the need for more 74HC125s to finish the design and carry on with the code. Suggestions for read-only SPI devices are also welcome.

is continuing to work on the SPI2C board, writing an I2C bus scanner that can detect I2C devices by their bus address. He has discovered that the Duinotech RTC board also has an AT24C32N 32k serial EEPROM onboard. He is now asking what he can do with the nonvolatile memory. All code related to the project can be found on GitHub.
https://github.com/1971Merlin/SPI2C


## Craig Jones and Craig Hart 
have been working together to get Craig Hart's SPI2C board running on a Nokia 5110 display. Craig Jones is connecting various components to the I2C, such as a BMP180 and BME/BMP280 Temperature and Humidity sensor. Craig Hart is also cleaning up his code and turning it into a modular library.


## Ben Grimmett 
is offering a solution for programmable logic using a CPLD (Complex Programmable Logic Device). The code provided is for two 8-bit registers which can be read and written to depending on the address. He is offering an assembled board for anyone interested and the software used is free. This CPLD can be used for I2C, SPI, RS232, serial graphics, etc. Programming it can either be done using a drag and drop schematic screen or by using VHDL or Verilog. Ben is also offering to make a thread with code examples to help get people started.
