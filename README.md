# tec-I2C-SPI
- https://www.facebook.com/groups/623556744820045/search/?q=I2C
- https://www.facebook.com/groups/623556744820045/search/?q=spi
- 


### with mint
- using a Tec-1 with mint code 
- Ken Boak commented that Bitbanged SPI should be possible in MINT, but with a low clock frequency. 


## Craig Hart 
- has successfully completed the challenge involving the use of I2C and SPI. 
- He is covered the possibility of using a Bitbanged SPI bus to communicate with an Arduino board. 

#### the I2CSPI PCB
- for testing and experimenting with I2C and SPI bus interfaces
- https://github.com/1971Merlin/SPI2C  with source code, schematics, and other details available.
- The board features
- a DS1207 based Real Time Clock,
- a MAX7219 8-digit 7-seg display,
- a 24LC16B 16k EEPROM,
- and soon an 84x48 OLED display.
-
- The board is being designed in KiCad and the code by Craig.
- future; need for more 74HC125s to finish the design
- and carry on with the code.
- Suggestions for read-only SPI devices are also welcome.
- ongoing;  work on the SPI2C board, writing an I2C bus scanner that can detect I2C devices by their bus address.
- discovered that the Duinotech RTC board also has an AT24C32N 32k serial EEPROM onboard.
- what can done with the nonvolatile memory?


## Craig Jones and Craig Hart 
- co op together to get Craig Hart's SPI2C board running on a Nokia 5110 display.
- Craig Jones is connecting various components to the I2C,
- such as a BMP180 and BME/BMP280 Temperature and Humidity sensor.
- Craig Hart is also cleaning up his code and turning it into a modular library.

##  analysis Craig Hart i2c code 
- written in assembly language and is intended to run on a TEC-1 or SC-1 target machine.
- It is a test code for the TEC SPI2C board with MAX7219 and DS1307 RTC.

Code comments:
1. general information, target machines, copyright information, and a link to the project's GitHub repository.
2. Global constants are defined, such as the memory addresses for the DS1307 RTC and the 7-segment display.
3. The hardware initialization code begins. It resets the I2C and SPI buses to their idle states and initializes the MAX7219 7-segment display.
4. The DS1307 RTC is set with the initial starting time and date.
5. The main program loop starts. It reads the clock from the I2C bus, displays the clock on the internal 7-segment display (for testing purposes), and also displays the clock on the I2C 7-segment module.
6. The "handlekey" subroutine is called to check if a keypress has occurred and perform some action if a key is pressed.
7. The "pollkey" subroutine is called to update the keyboard buffer if a keypress is detected.
8. The "ldelay" subroutine is a general-purpose delay loop used for pausing the program.
9. The "i2c_start" subroutine is called to make the I2C bus active.
10. The "i2c_stop" subroutine is called to return the I2C bus to the idle state.
11. The "i2c_txbyte" subroutine is used to transmit a byte on the I2C bus.
12. The "i2c_rxbyte" subroutine is used to receive a byte from the I2C bus.
13. The "spi_wr" subroutine is called to write to the SPI bus. It takes a command and a data byte as input.
14. The "rd1307" subroutine is used to read the DS1307 clock chip.
15. The "set1307" subroutine is used to set the DS1307 clock chip with the desired time and date.
16. The "convdata" subroutine processes the clock chip's raw data into the display buffer format.
17. The "maxout" subroutine sends the contents of the display buffer to the MAX7219 chip for display.
18. The code includes data sections, such as the register buffer, display buffer, mode flag, keyboard variables, clock set data, and segment patterns for the 7-segment display.
19. The program ends with the ".end" directive.

Please note that the code is specific to the TEC-1 and SC-1 target machines and relies on specific memory addresses and hardware configurations. It may not be directly applicable to other systems without modifications.

## code rewritten as pseudo code with comments:

```
// Test code for TEC SPI2C board with MAX7219, DS1307 RTC

// Define global constants
ds1307 = 0x68    // I2C address for DS1307 RTC
lc16b = 0xA0     // Memory address for 7-segment display

// Hardware initialization
Reset I2C bus to idle state
Reset SPI bus to idle state
Initialize SPI 7-segment display (MAX7219)
Setup DS1307 initial starting time and date

// Main program loop
loop:
    Read clock from I2C bus
    Display clock on internal 7-segment display (for testing)
    Display clock on I2C 7-segment module
    Poll keyboard for keypress
    Handle keypress, if any

// Handle keypress
handlekey:
    If a key is pressed:
        Set flag indicating keypress
        Process the pressed key

// Poll keyboard
pollkey:
    Read keyboard port
    If a key is pressed:
        Update key buffer
    Return

// General purpose delay loop
ldelay:
    Delay for a certain amount of time
    Return

// Make the I2C bus active
i2c_start:
    Set SCL and SDA to start condition
    Return

// Return I2C bus to idle
i2c_stop:
    Set SCL and SDA to stop condition
    Return

// Transmit a byte on the I2C bus
i2c_txbyte:
    Loop through each bit in the byte:
        Set SDA to the current bit value
        Set SCL high, then low
    Receive ACK from device
    Return ACK result

// Receive a byte from the I2C bus
i2c_rxbyte:
    Loop through each bit to receive a byte:
        Set SDA to tristate output
        Set SCL high, then low
        Read bit value from SDA
        Store bit value in result byte
    Send ACK
    Return received byte

// Utility routine to scan the internal 7-segment displays
scan_7seg:
    Loop through each display digit:
        Set display value
        Turn on display
        Delay to show the value
        Turn off display
    Return

// Convert data from DS1307 to display format
convdata:
    Convert seconds and date values to display format
    Convert minutes and month values to display format
    Convert hours and year values to display format
    Return

// Send display buffer contents to MAX7219
maxout:
    Loop through each byte in the display buffer:
        Send byte to SPI bus
    Return

// Read DS1307 clock chip
rd1307:
    Loop through each DS1307 register:
        Send register address to DS1307
        Read register value from DS1307
        Store value in buffer
    Return

// Set DS1307 clock chip
set1307:
    Loop through each clock set byte:
        Send register address to DS1307
        Send clock set value to DS1307
    Return

// Main program
Start execution at the main loop
```

## Ben Grimmett 

- https://github.com/SteveJustin1963/tec-CPLD-BG

Ben Grimmett on FaceBook March 5, 2020
  · 
```
Perhaps this could make programmable logic a little less mysterious and maybe encourage
discussion and integration into the TEC.
In the picture is the code to make two 8bit registers and read and write to them depending on the address.

Let me know if you'd like an assembled board.

The software is all free,
a programmer is under $10 from eBay.
This small CPLD can easily manage i2c or spi comms, or rs232.

You could drive a
serial graphics
or chr lcd,
temp sensors,
make a sound card,
configurable clock for the z80,
interrupt timebase etc.
The options are truly endless. 

You can program these chips via a drag and drop schematic screen,
linking 74 series logic with wires using your mouse. 

Or you can code in vhdl or verilog
for a more optimised tailored solution for your project. 

Happy to make a thread with code examples to get you started.

-- Signal Assignments

process (CS,WR)
begin
    if CS='0' then -- If Chip Select of the Expansion port is Low then...
        if WR = '1' then -- If Write signal on Expansion Port is High (CPU is requesting a read) then..
            if A="00" then -- If the lower two address lines are 00 (0x1000) then..
                D<=Reg1; -- Put the contents of Reg1 onto the Bus;
            elsif
                A="01" then -- Else, if Address lines are 01 (0x1001) then put Reg2 on the Bus
                D<=Reg2;--;
            else D<="ZZZZZZZZ";
            end if;
        else D<="ZZZZZZZZ";
        end if;
    else D<="ZZZZZZZZ";
    end if;
end process;

process (CS,WR)
begin
    if CS='0' then -- Same as the above function except now if the CPU is requesting a Write, we’ll put the value D (Data Bus)
        if WR = '0' then
            if A="00" then
                Reg1<=D;--;
            elsif A="01" then
                Reg2<=D;
            end if;
        end if;
    end if;
end process;


```

