#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletUVLight;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your UV Light Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $uvl = Tinkerforge::BrickletUVLight->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current UV light
my $uv_light = $uvl->get_uv_light();
print "UV Light: " . $uv_light/10.0 . " mW/m²\n";

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
