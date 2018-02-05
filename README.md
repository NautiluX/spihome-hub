# spihome-hub
hub to manage 433 mhz devices using raspberry pi

# Setup
## Hardware
Wire 433 MHz sender to Raspberry Pi as follows:
* VCC to +5V or more
* GND to Ground
* DATA to WiringPi Pin 0 (GPIO0)

## Software
* install wiringPi as described [here](http://wiringpi.com/download-and-install/)
* build 433 Mhz sender in ext/sendElro by [CurlyMoo](https://github.com/CurlyMoo) and allow it to be executed as root:
```
cd ext/radio
make
cd ../../
sudo chown root ext/radio/sendElro
sudo chmod +s ext/radio/sendElro
```

# Usage
run ./spish -h to get an overview of the usage