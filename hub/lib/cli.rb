require "hub/version"
require "storageYaml/DeviceManagerYaml"
require "elro/ElroDevice"
require "hub/ActionInvoker"
require 'optparse'

module Hub
  class CLI
    def initialize()
      deviceManager = DeviceManagerYaml.new("devices.yaml")

      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: hub.rb [options]"
      
        opts.on("-dDEVICE", "--device=DEVICE", "device name") do |d|
          options[:device] = d
        end
        opts.on("-aACTION", "--action=ACTION", "action to execute (init, list, on, off, add)") do |action|
          options[:action] = action
        end
        opts.on("-HHOUSE_CODE", "--house_code=HOUSE_CODE", "housecode of elro device") do |code|
          options[:houseCode] = Integer(code)
        end
        opts.on("-IDEVICE_ID", "--device_id=DEVICE_ID", "device id of elro device") do |id|
          options[:deviceId] = Integer(id)
        end
        opts.on("-v", "--verbose", "verbose mode") do
          options[:verbose] = true
        end
        opts.on("-h", "--help", "Prints this help") do
          puts opts
          exit
        end
      end.parse!

      actionInvoker = ActionInvoker.new(deviceManager)

      begin
        if options[:action] == nil
          raise "missing argument ACTION"
          exit
        end
        case options[:action]
        when "add"
          actionInvoker.createElroDevice(options[:device], options[:houseCode], options[:deviceId])
        when "init"
          deviceManager.clear()
          deviceManager.addDevice(Elro::Device.new("Bar", BiStateDeviceStateOff, 29, 4))
          deviceManager.addDevice(Elro::Device.new("Radio", BiStateDeviceStateOff, 29, 1))
          deviceManager.addDevice(Elro::Device.new("Baum", BiStateDeviceStateOff, 29, 3))
          deviceManager.addDevice(Elro::Device.new("Lounge", BiStateDeviceStateOff, 29, 2))
        when "list"
          puts deviceManager.listDeviceNames()
        when "on"
          actionInvoker.turnOnDevice(options[:device])
        when "off"
          if deviceManager.hasDevice(options[:device]) then
            deviceManager.getDevice(options[:device]).turnOff()
          end
        else
          raise "Action not supported: " + options[:action]
        end
      rescue => e
        puts "An Error occured: " + e.to_s
        if options[:verbose] then
          raise e
        end
      end
    end
  end
end

Hub::CLI.new()