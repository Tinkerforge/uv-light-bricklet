<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletUVLight.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletUVLight;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your UV Light Bricklet

// Callback function for UV light callback
function cb_uvLight($uv_light)
{
    echo "UV Light: " . $uv_light/10.0 . " mW/m²\n";
}

$ipcon = new IPConnection(); // Create IP connection
$uvl = new BrickletUVLight(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register UV light callback to function cb_uvLight
$uvl->registerCallback(BrickletUVLight::CALLBACK_UV_LIGHT, 'cb_uvLight');

// Set period for UV light callback to 1s (1000ms)
// Note: The UV light callback is only called every second
//       if the UV light has changed since the last call!
$uvl->setUVLightCallbackPeriod(1000);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
