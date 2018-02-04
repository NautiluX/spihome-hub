require "elro/ElroDevice"
require "hub/Error"

module Hub
    class ActionInvoker
      def initialize(deviceManager)
        @deviceManager = deviceManager
      end

      def createElroDevice(name, houseCode, deviceId)
        if !@deviceManager.hasDevice(name) then
            device = Elro::Device.new(name, BiStateDeviceStateOff, houseCode, deviceId)
            @deviceManager.addDevice(device)
        else
            raise DeviceExistsError.new(name)
        end
      end
    end
end