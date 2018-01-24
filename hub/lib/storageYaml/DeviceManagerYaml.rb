require "yaml"
require "securerandom"

require "storageMemory/DeviceManagerMemory"

module Hub
    class DeviceManagerYaml < DeviceManagerMemory
        def initialize(filename = nil)
            super()
            if filename == nil then
                @filename = SecureRandom.hex + ".yaml"
            else
                @filename = filename
            end
            loadDevices()
        end

        def loadDevices()
            if File.file?(@filename) then
                @devices = YAML::load_file(@filename)
            end
        end

        def addDevice(device)
            super
            save()
        end

        def save()
            File.open(@filename, "w") do |file|
                file.truncate(0)
                file.puts YAML::dump(@devices)
            end
        end

        def clear()
            super
            if File.file?(@filename) then
                File.delete(@filename)
            end
        end
    end
end