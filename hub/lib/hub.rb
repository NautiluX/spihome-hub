require "hub/version"
require "storageMemory/DeviceManagerMemory"
require "elro/ElroDevice"
require 'optparse'

module Hub
  class Hub
    def initialize()
      puts "hello hub"
      deviceManager = DeviceManagerMemory.new()
      deviceManager.addDevice(Elro::Device.new("Bar", BiStateDeviceStateOff, 29, 4))

      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: hub.rb [options]"
      
        opts.on("-dDEVICE", "--device=DEVICE", "device name") do |d|
          options[:device] = d
        end
        opts.on("-sDEVICE", "--state=DEVICE", "specify state") do |s|
          options[:state] = s
        end
      end.parse!

      if deviceManager.hasDevice(options[:device]) then
        if options[:state] == "on" then
          deviceManager.getDevice(options[:device]).turnOn()
        else
          deviceManager.getDevice(options[:device]).turnOff()
        end
      end
    end
  end
end

Hub::Hub.new()