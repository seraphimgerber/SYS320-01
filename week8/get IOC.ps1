function Get-IOC {
    param (
        [string]$url = "http://10.0.17.6/IOC.html"
    )

    $webContent = Invoke-WebRequest -Uri $url -UseBasicParsing
    $html = $webcontent.content -join "`n"

    $xml = [xml]("<root>" + $html + "</root>")

    $rows = $xml.SelectNodes("//tr")

    $IOC_List = @()
    
    foreach ($row in $rows) {
        $cols = $row.SelectNodes("td")
        if ($cols.Count -eq 2) {
            $pattern = $cols[0].InnerText.Trim()
            $description = $cols[1].InnerText.Trim()

            $IOC_List += [PSCustomObject]@{
                Pattern = $pattern
                Explanation = $description
            }
        }

    }
    return $IOC_List
}

Get-IOC | Format-Table -AutoSize