Imports System
Imports Tinkerforge

Module ExampleThreshold
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your UV Light Bricklet

    ' Callback subroutine for UV light reached callback
    Sub UVLightReachedCB(ByVal sender As BrickletUVLight, ByVal uvLight As Long)
        Console.WriteLine("UV Light: " + (uvLight/10.0).ToString() + " mW/m²")
        Console.WriteLine("UV Index > 3. Use sunscreen!")
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim uvl As New BrickletUVLight(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        uvl.SetDebouncePeriod(10000)

        ' Register UV light reached callback to subroutine UVLightReachedCB
        AddHandler uvl.UVLightReachedCallback, AddressOf UVLightReachedCB

        ' Configure threshold for UV light "greater than 75 mW/m²"
        uvl.SetUVLightCallbackThreshold(">"C, 75*10, 0)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
