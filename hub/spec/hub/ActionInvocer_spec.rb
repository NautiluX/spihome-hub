require "spec_helper"
require "hub/ActionInvoker"
require "hub/Error"
require "elro/ElroDevice"

module Hub
    describe ActionInvoker do
        def createDeviceManagerDouble
            deviceManager = double("DeviceManager")
            allow(deviceManager).to receive(:hasDevice)
            allow(deviceManager).to receive(:addDevice)
            return deviceManager
        end
        describe :createElroDevice do
            context "when device doesn't exist" do
                it "creates an Elre device in DeviceManager" do
                    deviceManager = createDeviceManagerDouble()
                    expect(deviceManager).to receive(:addDevice).with(instance_of(Elro::Device))
                    inv = ActionInvoker.new(deviceManager)
                    inv.createElroDevice("TestDevice", 25, 2)
                end
            end

            context "when device already exists" do
                it "raises an error" do
                    deviceManager = createDeviceManagerDouble()
                    allow(deviceManager).to receive(:hasDevice).and_return(true)
                    inv = ActionInvoker.new(deviceManager)
                    expect{inv.createElroDevice("TestDevice", 25, 3)}.to raise_error(Hub::DeviceExistsError)
                end
            end
        end
    end
end