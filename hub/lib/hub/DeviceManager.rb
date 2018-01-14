module Hub
    class DeviceManager
        def initialize
            @devices = Array.new
        end
        def addDevice(device)
            @devices.push(device)
        end
        def getNumDevices()
            @devices.length
        end 
    end
end