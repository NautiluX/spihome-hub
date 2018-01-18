require "spec_helper"
require "storageMemory/DeviceManagerMemory"
require "hub/Device"

module Hub
    RSpec.shared_examples "a device manager" do
        describe "#addDevice" do
            it "increases number of devices" do
                device = Device.new("ExampleDevice")
                deviceManager = described_class.new()
                deviceManager.addDevice(device)
                expect(deviceManager.getNumDevices).to eq(1)
            end

            it "doesn't allow duplicate devices" do
                device = Device.new("ExampleDevice")
                device2 = Device.new("ExampleDevice")
                deviceManager = described_class.new()
                deviceManager.addDevice(device)
                expect{deviceManager.addDevice(device2)}.to throw_symbol(:DuplicateDevice)
            end
        end

        describe "#getNumDevices" do
            it "returns number of devices" do
                deviceManager = described_class.new()
                for i in 0..4 do
                    device = Device.new("ExampleDevice" + i.to_s)
                    deviceManager.addDevice(device)
                end
                expect(deviceManager.getNumDevices).to eq(5)
            end
        end

        describe "#getDevice" do
            it "return device of a given name" do
                deviceManager = described_class.new()
                device = Device.new("ExampleDevice")
                deviceManager.addDevice(device)
                expect(deviceManager.getDevice("ExampleDevice").getName()).to eq("ExampleDevice")
            end
        end
        
        describe "#hasDevice" do
            it "return if device exists" do
                deviceManager = described_class.new()
                device = Device.new("ExampleDevice")
                deviceManager.addDevice(device)
                expect(deviceManager.hasDevice("ExampleDevice")).to eq(true)
            end
        end
    end

    RSpec.describe Hub::DeviceManagerMemory do
        it_behaves_like "a device manager"
    end
end