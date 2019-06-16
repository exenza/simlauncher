#Paste the device ID from the find.ps1 script here:
$DeviceID = ""

$ShowNotification = $false

#Do not modify below this point unless you know what are you doing!

clear

echo 'Waiting for wheelbase...'

while ($true) {
	$Wheel = gwmi -Query "SELECT * FROM Win32_PNPEntity WHERE DeviceID = '$DeviceID'"

	if ($Wheel) {
        echo 'Found!'
		if ($ShowNotification) {
			Add-Type -AssemblyName System.Windows.Forms 
			$Global:Balloon = New-Object System.Windows.Forms.NotifyIcon
			$Path = (Get-Process -id $pid).Path
			$Balloon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($Path) 
			$Balloon.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Warning 
			$Balloon.BalloonTipText = 'Wheel is on, starting up apps...'
			$Balloon.BalloonTipTitle = "Attention $Env:USERNAME" 
			$Balloon.Visible = $true 
			$Balloon.ShowBalloonTip(5000)
		}
			
		wmic process where "name='CrewChiefV4.exe'" delete
		start "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\CrewChief"
		start "C:\Program Files (x86)\SimHub\SimHubWPF.exe"
		start "C:\Program Files (x86)\Rhinode LLC\Trading Paints\Trading Paints.exe"
		start "C:\Program Files (x86)\iRacing Setup Sync\iRacingSetupSyncLauncher.exe"
		start "C:\Program Files (x86)\iSpeed\iSpeed.exe"
		start "C:\Program Files\SimRacingStudio\simracingstudio.exe"
		break
    }

	start-sleep -s 10
}