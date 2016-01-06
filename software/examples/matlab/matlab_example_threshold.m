function matlab_example_threshold()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletUVLight;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    uvl = handle(BrickletUVLight(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    uvl.setDebouncePeriod(10000);

    % Register UV light reached callback to function cb_uv_light_reached
    set(uvl, 'UVLightReachedCallback', @(h, e) cb_uv_light_reached(e));

    % Configure threshold for UV light "greater than 750 µW/cm²" (unit is µW/cm²)
    uvl.setUVLightCallbackThreshold('>', 750, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for UV light reached callback (parameter has unit µW/cm²)
function cb_uv_light_reached(e)
    fprintf('UV Light: %i µW/cm²\n', e.uvLight);
    fprintf('UV Index > 3. Use sunscreen!\n');
end