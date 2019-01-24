
#Start the script and follow the instuctions.
#Copy the DeviceID, for example: HID\VID_0EB7&PID_6204\7&210F0DBA&0&0000
#Then set the DeviceID variable like this example:
#$DeviceID="7&2FD628C0&0&0001"

$DeviceID=""

#Do not modify below this point unless you know what are you doing!

if(!$DeviceID){
clear
echo "Turn off or disconnect your Wheelbase"
Read-Host 'Press Enter to continue…' | Out-Null
echo "Reading current game controllers..."
$devices=gwmi -Query "SELECT DeviceID FROM Win32_PNPEntity WHERE Description LIKE '%game%'"
clear
echo "Now turn on/connect your wheel"
Read-Host 'Press Enter to continue…' | Out-Null
while($devices){
clear
echo "Detecting new USB device..."
start-sleep -s 5
$newdevice=gwmi -Query "SELECT DeviceID FROM Win32_PNPEntity WHERE Description LIKE '%game%'"
if($newdevice -ne $devices){
   echo "Found new device!"
   Read-Host 'Press Enter to continue…' | Out-Null
   $newdvice=$newdevice[@($devices).length]
   break
}
}
clear
echo "Your wheel device id is:"
echo $newdevice[0].DeviceID
echo ""
echo "Copy the DeviceID, for example: HID\VID_0EB7&PID_6204\7&210F0DBA&0&0000"
echo "Then set the DeviceID variable on line 7 like this example:"
echo "`$DeviceID=`"7&210F0DBA&0&0000`""
Read-Host 'Press Enter to quit.' | Out-Null
}

$wheel=""
$wheelwas=0

while($true -And $DeviceID)
{

$wheel=gwmi -Query "SELECT * FROM Win32_PNPEntity WHERE DeviceID LIKE '%$DeviceID%'"
clear
echo "Monitoring device id $DeviceID"
if(!$wheelwas -And $wheel){
    $wheelwas=1
    Add-Type -AssemblyName System.Windows.Forms 
    $global:balloon = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path) 
    $balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
    $balloon.BalloonTipText = 'Wheel is on, starting up apps...'
    $balloon.BalloonTipTitle = "Attention $Env:USERNAME" 
    $balloon.Visible = $true 
    $balloon.ShowBalloonTip(5000)
    wmic process where "name='CrewChiefV4.exe'" delete
    start "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CrewChief"
    start "C:\Program Files (x86)\Rhinode LLC\Trading Paints\Trading Paints.exe"
    start "C:\Program Files (x86)\iRacing Setup Sync\iRacingSetupSyncLauncher.exe"
    start "C:\Program Files (x86)\iSpeed\iSpeed.exe"
    start "C:\Program Files\SimRacingStudio\simracingstudio.exe"

} ElseIf(!$wheel) {
    $wheelwas=0
    echo "wheel is OFF"
}

if($wheelwas){
echo "wheel is ON"
}

start-sleep -s 1
}
