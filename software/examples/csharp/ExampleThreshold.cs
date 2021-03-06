using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your UV Light Bricklet

	// Callback function for UV light reached callback
	static void UVLightReachedCB(BrickletUVLight sender, long uvLight)
	{
		Console.WriteLine("UV Light: " + uvLight/10.0 + " mW/m²");
		Console.WriteLine("UV Index > 3. Use sunscreen!");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletUVLight uvl = new BrickletUVLight(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		uvl.SetDebouncePeriod(10000);

		// Register UV light reached callback to function UVLightReachedCB
		uvl.UVLightReachedCallback += UVLightReachedCB;

		// Configure threshold for UV light "greater than 75 mW/m²"
		uvl.SetUVLightCallbackThreshold('>', 75*10, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
