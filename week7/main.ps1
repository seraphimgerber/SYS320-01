. (Join-Path $PSScriptRoot Event-Log.ps1)
. (Join-Path $PSScriptRoot scheduler.ps1)
. (Join-Path $PSScriptRoot config.ps1)
. (Join-Path $PSScriptRoot email.ps1)

$config = readConfig

$Failed = listAtRiskUsers $config.Days

$FailedFormatted = $Failed | Format-Table -Autosize | Out-String

SendAlertEmail $FailedFormatted

ChooseTimeToRun($config.ExecutionTime)



