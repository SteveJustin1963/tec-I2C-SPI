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

### brian.chiha
SPI and more
- https://github.com/bchiha/Ready-Z80
- https://www.youtube.com/watch?v=tZHt6CwbkVA
