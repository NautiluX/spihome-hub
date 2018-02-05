# spihome-hub
hub to manage 433 mhz devices using raspberry pi

# Setup
* install wiringPi as described [here](http://wiringpi.com/download-and-install/)
* build 433 Mhz sender in ext/sendElro by [CurlyMoo](https://github.com/CurlyMoo):
```
cd ext/radio
make
cd ../../
chown root ext/radio/sendElro
chmod +s ext/radio/sendElro
```

# Usage
run ./spish -h to get an overview of the usage