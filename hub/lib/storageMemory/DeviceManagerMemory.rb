module Hub
    class DeviceManagerMemory
        def initialize
            @devices = Array.new
        end

        def addDevice(device)
            if getDevice(device.getName()) == nil then
                @devices.push(device)
            else
                throw :DuplicateDevice
            end
        end

        def getNumDevices()
            @devices.length
        end 

        def getDevice(name)
            @devices.find {|device| device.getName() == name}
        end 

        def hasDevice(name)
            return getDevice(name) != nil
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
    end
end