require "spec_helper"
require "storageMemory/DeviceManagerMemory"
require "storageYaml/DeviceManagerYaml"
require "hub/Device"
require "hub/BiStateDevice"

module Hub
    RSpec.shared_examples "a device manager" do
        describe "#addDevice" do
            it "increases number of devices" do
                device = Device.new("ExampleDevice")
                deviceManager = described_class.new()
                deviceManager.addDevice(device)
                expect(deviceManager.getNumDevices).to eq(1)
                deviceManager.clear()
            end

            it "doesn't allow duplicate devices" do
                device = Device.new("ExampleDevice")
                device2 = Device.new("ExampleDevice")
                deviceManager = described_class.new()
                deviceManager.addDevice(device)
                expect{deviceManager.addDevice(device2)}.to throw_symbol(:DuplicateDevice)
                deviceManager.clear()
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
                deviceManager.clear()
            end
        end

        describe "#getDevice" do
            it "return device of a given name" do
                deviceManager = described_class.new()
                device = Device.new("ExampleDevice")
                deviceManager.addDevice(device)
                expect(deviceManager.getDevice("ExampleDevice").getName()).to eq("ExampleDevice")
                deviceManager.clear()
            end
        end
        
        describe "#hasDevice" do
            it "return if device exists" do
                deviceManager = described_class.new()
                device = Device.new("ExampleDevice")
                deviceManager.addDevice(device)
                expect(deviceManager.hasDevice("ExampleDevice")).to eq(true)
                deviceManager.clear()
            end
        end

        describe "#listDeviceNames" do
            it "lists the existing devices" do
                deviceManager = described_class.new()
                deviceManager.addDevice(Device.new("ExampleDevice1"))
                deviceManager.addDevice(Device.new("ExampleDevice2"))
                expect(deviceManager.listDeviceNames()).to eq("ExampleDevice1\nExampleDevice2\n")
                deviceManager.clear()
            end
        end

        describe "#clear" do
            it "clear all devices" do
                deviceManager = described_class.new()
                deviceManager.addDevice(Device.new("ExampleDevice1"))
                deviceManager.addDevice(Device.new("ExampleDevice2"))
                expect(deviceManager.getDevice("ExampleDevice1")).not_to eq(nil)
                expect(deviceManager.getDevice("ExampleDevice2")).not_to eq(nil)
                deviceManager.clear()
                expect(deviceManager.hasDevice("ExampleDevice1")).to eq(false)
                expect(deviceManager.hasDevice("ExampleDevice2")).to eq(false)
            end
        end

        describe "#turnOnDevice" do
            it "turns on the given device" do
                deviceManager = described_class.new()
                ex1 = BiStateDevice.new("ExampleDevice1", BiStateDeviceStateOff, double())
                ex2 = BiStateDevice.new("ExampleDevice2", BiStateDeviceStateOff, double())
                deviceManager.addDevice(ex1)
                deviceManager.addDevice(ex2)
                deviceManager.turnOnDevice("ExampleDevice1")
                expect(ex1.getState()).to eq(BiStateDeviceStateOn)
                expect(ex2.getState()).to eq(BiStateDeviceStateOff)
            end
        end
    end

    RSpec.describe Hub::DeviceManagerMemory do
        it_behaves_like "a device manager"
    end

    RSpec.describe Hub::DeviceManagerYaml do
        it_behaves_like "a device manager"
    end
end