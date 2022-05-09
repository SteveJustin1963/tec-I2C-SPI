
// initializing the I2C bus, sending start signals, sending address signals, sending data signals, and sending stop signals.

#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/i2c-dev.h>

int main(int argc, char* argv[])
{
    // Create I2C bus
    int file;
    char *bus = "/dev/i2c-1";
    if((file = open(bus, O_RDWR)) < 0) 
    {
        printf("Failed to open the bus. \n");
        exit(1);
    }
    // Get I2C device, TMP102 I2C address is 0x48(72)
    ioctl(file, I2C_SLAVE, 0x48);

    // Select configuration register(0x01)
    // Continuous conversion mode, 12-bits resolution, fault queue is 1, normal operation(0x60, 0xA1)
    char config[2] = {0};
    config[0] = 0x01;
    config[1] = 0x60;
    write(file, config, 2);
    // Select resolution register(0x00)
    // 12-bits resolution(0xC0)
    config[0] = 0x00;
    config[1] = 0xC0;
    write(file, config, 2);
    sleep(1);

    // Read 2 bytes of data
    // temp msb, temp lsb
    char reg[1] = {0x00};
    write(file, reg, 1);
    char data[2] = {0};
    if(read(file, data, 2) != 2)
    {
        printf("Erorr : Input/output Erorr \n");
    }
    else
    {
        // Convert the data to 12-bits
        int temp = ((data[0] * 256 + data[1]) * 625) / 1000;
        // Output data to screen
        printf("Temperature in Celsius : %d \n", temp);
    }
    return 0;
}
