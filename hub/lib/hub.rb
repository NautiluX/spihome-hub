require "hub/version"
require "storageYaml/DeviceManagerYaml"
require "elro/ElroDevice"
require 'optparse'

module Hub
  class Hub
    def initialize()
      deviceManager = DeviceManagerYaml.new("devices.yaml")

      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: hub.rb [options]"
      
        opts.on("-dDEVICE", "--device=DEVICE", "device name") do |d|
          options[:device] = d
        end
        opts.on("-aACTION", "-aACTION", "action to execute (init, list, on, off)") do |list|
          options[:action] = list
        end
      end.parse!

      case options[:action]
      when "init"
        deviceManager.clear()
        deviceManager.addDevice(Elro::Device.new("Bar", BiStateDeviceStateOff, 29, 4))
        deviceManager.addDevice(Elro::Device.new("Radio", BiStateDeviceStateOff, 29, 1))
        deviceManager.addDevice(Elro::Device.new("Baum", BiStateDeviceStateOff, 29, 3))
        deviceManager.addDevice(Elro::Device.new("Lounge", BiStateDeviceStateOff, 29, 2))
      when "list"
        puts deviceManager.listDeviceNames()
      when "on"
        if deviceManager.hasDevice(options[:device]) then
          deviceManager.getDevice(options[:device]).turnOn()
        end
      when "off"
        if deviceManager.hasDevice(options[:device]) then
          deviceManager.getDevice(options[:device]).turnOff()
      end
    end
  end
end

Hub::Hub.new()