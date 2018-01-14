require "Hub/Device"
require "minitest/autorun"

module Hub
  class DeviceTest < Minitest::Test
    def test_createDevice
      devName = "test device"
      dev = Device.new(devName)
      assert_equal(devName, dev.getName())
    end
  end
end