function SendAlertEmail($Body) {

    $From = "seraphim.gerber@mymail.champlain.edu"
    $To = "seraphim.gerber@mymail.champlain.edu"
    $Subject = "Suspicious Activity!!!"

    $Password = "password" | ConvertTo-SecureString -AsPlainText -Force
    $Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

    Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer smtp.gmail.com -Port 587 -UseSsl -Credential $Credential

}
