require "elro/ElroDevice"
require "hub/Error"

module Hub
    class ActionInvoker
      def initialize(deviceManager)
        @deviceManager = deviceManager
      end

      def createElroDevice(name, houseCode, deviceId)
        if name == nil then
          raise MissingDeviceNameError.new()
        elsif houseCode == nil then
          raise MissingHouseCodeError.new()
        elsif deviceId == nil then
          raise MissingDeviceIdError.new()
        elsif !@deviceManager.hasDevice(name) then
            device = Elro::Device.new(name, BiStateDeviceStateOff, houseCode, deviceId)
            @deviceManager.addDevice(device)
        else
            raise DeviceExistsError.new(name)
        end
      end

      def turnOnDevice(name)
        @deviceManager.turnOnDevice(name)
      end
    end
end