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

            context "when device name is missing" do
                it "raises an error" do
                    deviceManager = createDeviceManagerDouble()
                    inv = ActionInvoker.new(deviceManager)
                    expect{inv.createElroDevice(nil, 25, 3)}.to raise_error(Hub::MissingDeviceNameError)
                end
            end

            context "when house code is missing" do
                it "raises an error" do
                    deviceManager = createDeviceManagerDouble()
                    inv = ActionInvoker.new(deviceManager)
                    expect{inv.createElroDevice("TestDevice", nil, 3)}.to raise_error(Hub::MissingHouseCodeError)
                end
            end

            context "when device id is missing" do
                it "raises an error" do
                    deviceManager = createDeviceManagerDouble()
                    inv = ActionInvoker.new(deviceManager)
                    expect{inv.createElroDevice("TestDevice", 0, nil)}.to raise_error(Hub::MissingDeviceIdError)
                end
            end
        end

        describe :turnOnDevice do
            it "changes state to on" do
                deviceManager = createDeviceManagerDouble()
                inv = ActionInvoker.new(deviceManager)
                expect(deviceManager).to receive(:turnOnDevice).with("TestDevice")
                inv.turnOnDevice("TestDevice")
            end
        end
    end
end