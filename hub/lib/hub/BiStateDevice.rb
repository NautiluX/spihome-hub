require "hub/Device"
require "hub/BiStateDeviceState"

module Hub
    BiStateDeviceStateOn = BiStateDeviceState.new("on")
    BiStateDeviceStateOff = BiStateDeviceState.new("off")

    class BiStateDevice < Device
        def initialize(name, currentState, statePropagator)
            super(name)
            @state = currentState
            @statePropagator = statePropagator
        end

        def getState()
            return @state
        end

        def turnOn()
            @state = BiStateDeviceStateOn
            puts("turning on " + getName())
            propagateStateChanged()
        end

        def turnOff()
            @state = BiStateDeviceStateOff
            puts("turning off " + getName())
            propagateStateChanged()
        end

        def propagateStateChanged()
            if @statePropagator.respond_to?(:onStateChanged)
                @statePropagator.onStateChanged(@state)
            end
        end
    end
end