﻿. C:\Users\champuser\SYS320-01\week3\deliverable5.ps1 

$days = 14

$loginLogoffEvents = Get-LoginLogoff -Days $days
$loginLogoffEvents | Format-Table -Autosize

$systemStartShutdownEvents = Get-SystemStartShutdown -Days $days
$systemStartShutdownEvents | Format-Table -Autosize