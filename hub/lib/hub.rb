require "hub/version"
require "storageMemory/DeviceManager"

module Hub
  class Hub
    def initialize()
      puts "hello hup"
      DeviceManager.new
      puts 
    end
  end
end

Hub::Hub.new