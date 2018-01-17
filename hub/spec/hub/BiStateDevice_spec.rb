require "spec_helper"
require "hub/BiStateDevice"
require "hub/BiStateDeviceState"

module Hub
    RSpec.shared_examples "a BiStateDevice" do
        describe "#getState" do
            it "returns the current state of the device" do
                device = described_class.new("ExampleDevice", BiStateDeviceStateOff, nil)
                expect(device.getState).to eq(BiStateDeviceStateOff)
            end
        end

        describe "#turnOn" do
            it "sets the current state to on" do
                device = described_class.new("ExampleDevice", BiStateDeviceStateOff, nil)
                device.turnOn()
                expect(device.getState).to eq(BiStateDeviceStateOn)
            end

            it "propagates a state change" do
                propagator = double("MockStatePropagator")
                expect(propagator).to receive(:onStateChanged).with(BiStateDeviceStateOn)
                device = described_class.new("ExampleDevice", BiStateDeviceStateOff, propagator)
                device.turnOn()
            end
        end

        describe "#turnOff" do
            it "sets the current state to off" do
                device = described_class.new("ExampleDevice", BiStateDeviceStateOn, nil)
                device.turnOff()
                expect(device.getState).to eq(BiStateDeviceStateOff)
            end

            it "propagates a state change" do
                propagator = double("MockStatePropagator")
                expect(propagator).to receive(:onStateChanged).with(BiStateDeviceStateOff)
                device = described_class.new("ExampleDevice", BiStateDeviceStateOn, propagator)
                device.turnOff()
            end
        end
    end

    RSpec.describe Hub::BiStateDevice do
        it_behaves_like "a BiStateDevice"
    end
end