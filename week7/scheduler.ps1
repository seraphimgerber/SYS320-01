function ChooseTimeToRun($Time){

$scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }

if($scheduledTasks -ne $null){
    Write-Host "The task already exists." | Out-String
    DisableAutoRun
}

Write-Host "Creating new task!" | Out-String

$action = New-ScheduledTaskAction -Execute "powershell.exe" `
          -argument "-File `"c:\Users\champuser\SYS320-01\week7\main.ps1`""

$trigger = New-ScheduledTaskTrigger -Daily -At $Time

}