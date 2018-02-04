module Hub
    class DeviceExistsError < StandardError

        def initialize(name)
            @name = name
        end

        def to_s
            "Device already exists: " + @name
        end
    end
end