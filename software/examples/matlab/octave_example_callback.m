function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your UV Light Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    uvl = javaObject("com.tinkerforge.BrickletUVLight", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register UV light callback to function cb_uv_light
    uvl.addUVLightCallback(@cb_uv_light);

    % Set period for UV light callback to 1s (1000ms)
    % Note: The UV light callback is only called every second
    %       if the UV light has changed since the last call!
    uvl.setUVLightCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for UV light callback
function cb_uv_light(e)
    fprintf("UV Light: %g mW/m²\n", java2int(e.uvLight)/10.0);
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
