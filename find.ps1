
clear

$Devices = gwmi -Query "SELECT DeviceID FROM Win32_PNPEntity WHERE Description LIKE '%game%'"
$InitialDeviceIds = @()
$NewDeviceCount = 0

foreach ($Device in $Devices) {
    $InitialDeviceIds += $Device.DeviceID
}

echo 'Initialised device list, turn on wheelbase'
Read-Host 'Press Enter to continue' | Out-Null

$Devices=gwmi -Query "SELECT DeviceID FROM Win32_PNPEntity WHERE Description LIKE '%game%'"

foreach ($Device in $Devices) {
    if ($InitialDeviceIds -notcontains $Device.DeviceID) {
        echo 'New device: {0}' -F $Device.DeviceID
        $NewDeviceCount++
    }
}

echo "Found $NewDeviceCount new device(s)"