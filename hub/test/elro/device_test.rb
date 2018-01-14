require "elro/ElroDevice"
require "minitest/autorun"

module Elro
  class DeviceTest < Minitest::Test
    def test_createDevice
      devName = "test device"
      dev = Device.new(devName, 21, 1)
      assert_equal(devName, dev.getName())
    end

    def test_getHouseCode
      devName = "test device"
      houseCode = 21
      dev = Device.new(devName, houseCode, 1)
      assert_equal(houseCode, dev.getHouseCode())
    end

    def test_getDeviceId
      devName = "test device"
      houseCode = 21
      deviceId = 2
      dev = Device.new(devName, houseCode, deviceId)
      assert_equal(deviceId, dev.getDeviceId())
    end
  end
end