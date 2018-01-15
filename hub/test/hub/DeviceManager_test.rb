require "StorageMemory/DeviceManagerMemory"
require "Hub/Device"
require "minitest/autorun"

module Hub
  class DeviceManagerMemoryTest < Minitest::Test
    def test_createDeviceManagerMemory
      Hub::DeviceManagerMemory.new
    end

    def test_getDeviceCount
      devManager = Hub::DeviceManagerMemory.new
      dev = Hub::Device.new("TestDevice")
      devManager.addDevice(dev)
      assert_equal(1, devManager.getNumDevices())
    end
    
    def test_getDeviceCount2
      devManager = Hub::DeviceManagerMemory.new
      dev = Hub::Device.new("TestDevice")
      dev2 = Hub::Device.new("TestDevice2")
      devManager.addDevice(dev)
      devManager.addDevice(dev2)
      assert_equal(2, devManager.getNumDevices())
    end

    def test_getDevice
      devManager = Hub::DeviceManagerMemory.new
      dev = Hub::Device.new("TestDevice")
      dev2 = Hub::Device.new("TestDevice2")
      devManager.addDevice(dev)
      devManager.addDevice(dev2)
      devGet = devManager.getDevice("TestDevice")
      assert_equal("TestDevice", devGet.getName())
      devGet2 = devManager.getDevice("TestDevice2")
      assert_equal("TestDevice2", devGet2.getName())
    end

    def test_duplicateDevice
      devManager = Hub::DeviceManagerMemory.new
      dev = Hub::Device.new("TestDevice")
      dev2 = Hub::Device.new("TestDevice")
      devManager.addDevice(dev)
      assert_throws :DuplicateDevice do
        devManager.addDevice(dev2)
      end
    end
  end
end