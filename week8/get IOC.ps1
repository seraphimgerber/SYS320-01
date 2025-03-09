function Get-IOC {
    param (
        [string]$url = http://10.0.17.6/IOC.html"
    )

    $webContent = Invoke-WebRequest -Uri $url -UseBasicParsing

    $html = New-Object -ComObject "HTMLFile"
    $html.IHTMLDocument2_write($webContent.Content)

    $rows = $html.getElementsByTagName("tr")

    $IOC_List = @()

    for ($i = 1; $i -lt $rows.length; $i++) {
        $cols = $rows[$i].getElementsByTagName("td")
        if ($cols.length -eq 2) {
            $pattern = $cols[0].innerText.trim()
            $description = $cols[1].innerText.trim()

            $IOC_List += [PSCustomObject]@{
                Pattern = $pattern
                Explanation = $description
            }
        }
    }

    return $IOC_List

}

Get-IOC