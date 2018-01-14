require "Hub/DeviceManager"
require "Hub/Device"
require "minitest/autorun"

module Hub
  class DeviceManagerTest < Minitest::Test
    def test_createDeviceManager
      Hub::DeviceManager.new
    end

    def test_getDevice
      devManager = Hub::DeviceManager.new
      dev = Hub::Device.new("TestDevice")
      devManager.addDevice(dev)
      assert_equal(1, devManager.getNumDevices())
    end
  end
end