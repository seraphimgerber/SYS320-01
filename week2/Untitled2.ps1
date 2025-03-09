function manageChromeProcess {

    $chrome = Get-Process -Name "chrome"

    if ($chrome) {
       Write-Host "Google Chrome is already running, let's stop it."
      Stop-Process -Name "chrome"
    } else {
        Write-Host "Why isn't Google Chrome running? Let's start it!"
        Start-Process "chrome.exe" "https://www.champlain.edu"
    }
}