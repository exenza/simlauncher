# simlauncher
A PowerShell script to launch different applications when a game controller is detected

Run the script in Powershell and follow the instruction to detect your game controller.

Once you set the $DeviceID variable you can create a task triggered on computer unlock to execute the .bat file:
wheel.bat

The .ps1 file has a infinite while loop and will monitor USB every second.
