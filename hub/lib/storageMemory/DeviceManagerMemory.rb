require "hub/Device"
require "hub/Error"

module Hub
    class DeviceManagerMemory
        def initialize
            @devices = Array.new
        end

        def addDevice(device)
            if !hasDevice(device.getName()) then
                @devices.push(device)
            else
                throw :DuplicateDevice
            end
        end

        def getNumDevices()
            @devices.length
        end 

        def getDevice(name)
            if hasDevice(name) then
                @devices.find {|device| device.getName() == name}
            else
                raise DeviceDoesNotExistError.new(name)
            end
        end 

        def hasDevice(name)
            res = @devices.any?{|device| device.getName() == name}
            return res
        end

        def clear()
            @devices.clear()
        end

        def listDeviceNames()
            result = ""
            @devices.each do |device|
                result += device.getName() + "\n"
            end
            return result
        end

        def turnOnDevice(name)
            device = getDevice(name)
            if device.respond_to?(:turnOn) then
                device.turnOn
            else
                raise DeviceOperationNotSupportedError.new(name, "turn on")
            end
        end
    end
end