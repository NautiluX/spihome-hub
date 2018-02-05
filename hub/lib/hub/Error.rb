module Hub
    class DeviceExistsError < StandardError
        def initialize(name)
            @name = name
        end

        def to_s
            "Device already exists: " + @name
        end
    end

    class DeviceDoesNotExistError < StandardError
        def initialize(name)
            @name = name
        end

        def to_s
            "Device does not exists: " + @name
        end
    end

    class DeviceOperationNotSupportedError < StandardError
        def initialize(name, operation)
            @name = name
            @operation = operation
        end

        def to_s
            "Device " + @name + " does not support operation " + @operation + "."
        end
    end

    class Hub::MissingDeviceNameError < StandardError
        def to_s
            "Device name is missing"
        end
    end

    class Hub::MissingHouseCodeError < StandardError
        def to_s
            "House Code is missing"
        end
    end

    class Hub::MissingDeviceIdError < StandardError
        def to_s
            "House Code is missing"
        end
    end
end