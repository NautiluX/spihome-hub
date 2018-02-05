require "hub/BiStateDevice"

module Elro
    class Elro::Device < Hub::BiStateDevice
        def initialize(name, currentState, houseCode, deviceId)
            super(name, currentState, StatePropagator.new(self))
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

    class Elro::StatePropagator
        def initialize(device)
            @device = device
        end

        def onStateChanged(state)
            cmd = "sendElro -i " + @device.getDeviceId().to_s + " -u " + @device.getHouseCode().to_s + " "
            if state == Hub::BiStateDeviceStateOn then
                cmd += "-t"
            else
                cmd += "-f"
            end
            for i in 1..3 do
                system(cmd)
                sleep(2)
            end
        end
    end
end