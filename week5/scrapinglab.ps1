function gatherClasses(){

    $page = Invoke-WebRequest -TimeoutSec 2 -Uri http://10.0.17.19/Courses.html

    $trs = $page.ParsedHtml.getElementsByTagName('tr')

    $FullTable = @()

    for ($i = 1; $i -lt $trs.length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")

        $Times = $tds[5].innerText -split "[-\s]+"

        $FullTable += [PSCustomObject]@{
            "Class Code" = $tds[0].innerText
            "Title"      = $tds[1].innerText
            "Days"       = $tds[4].innerText
            "Time Start" = $Times[0]
            "Time End"   = $Times[1]
            "Instructor" = $tds[6].innerText
            "Location"   = $tds[9].innerText
         }
    }

    return $FullTable
}

function daysTranslator($FullTable) {
    for ($i = 0; $i -lt $FullTable.length; $i++) {
        $Days = @()

        if ($FullTable[$i].Days -ilike "*M*") { $Days += "Monday" }

        if ($FullTable[$i].Days -ilike "*T[^h]*") { $Days += "Tuesday" }
        ElseIf ($FullTable[$i].Days -ilike "*T*") { $Days += "Tuesday" }

        if ($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }

        if ($FullTable[$i].Days -ilike "*Th*") { $Days += "Thursday" }

        if ($FullTable[$i].Days -ilike "*F*") { $Days += "Friday" }

        $FullTable[$i].Days = $Days

    }

    return $FullTable

}

$classesTable = gatherClasses
$translatedTable = daysTranslator($classesTable)

#Deliverable 6i:
#$translatedTable | Where-Object { $_.Instructor -eq "Furkan Paligu" } |
#    Format-Table "Class Code", Instructor, Location, Days, "Time Start", "Time End" -AutoSize

#Deliverable 6ii:
#$translatedTable | Where-Object { $_.Location -like "JOYC 310" -and $_.Days -contains "Monday" } |
#    Format-Table "Class Code", Instructor, Location, Days, "Time Start", "Time End" -AutoSize

#Deliverable 6iii:
$ITSInstructors = $translatedTable | Where-Object {
    $_."Class Code" -match "^SYS|^NET|^SEC|^FOR|^CSI|^DAT"
} | Select-Object -ExpandProperty Instructor -Unique | Sort-Object
#$ITSInstructors

#Deliverable 6iv:
$translatedTable | Where-Object { $_.Instructor -in $ITSInstructors } |
    Group-Object -Property Instructor |
    Sort-Object Count -Descending |
    Select-Object Count, Name