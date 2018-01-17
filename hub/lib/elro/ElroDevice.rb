require "hub/Device"
module Elro
    class Elro::Device < Hub::BiStateDevice
        def initialize(name, houseCode, deviceId)
            super(name)
            @houseCode = houseCode
            @deviceId = deviceId
        end

        def getHouseCode()
            return @houseCode
        end

        def getDeviceId()
            return @deviceId;
        end
    end
end