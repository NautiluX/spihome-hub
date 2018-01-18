require "hub/version"
require "storageMemory/DeviceManagerMemory"
require "elro/ElroDevice"

module Hub
  class Hub
    def initialize()
      puts "hello hub"
      deviceManager = DeviceManagerMemory.new()
      deviceManager.addDevice(Elro::Device.new("Bar", BiStateDeviceStateOff, 29, 4))
      puts "x"
      deviceManager.getDevice("Bar").turnOff()
      puts "a"
      deviceManager.getDevice("Bar").turnOn()
      puts "b"
      deviceManager.getDevice("Bar").turnOff()
      puts "c"
    end
  end
end

Hub::Hub.new()