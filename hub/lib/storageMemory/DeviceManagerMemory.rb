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
    end
end