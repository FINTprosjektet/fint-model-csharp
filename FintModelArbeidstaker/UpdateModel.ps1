﻿Write-Host "Starter script for å oppdatere modellen fra informasjonsmodell xsd"

$projectDir = $args[0];

$xsdFolder = $projectDir + "\Xsd\"
$modelFolder = $projectDir
$xsds = @(
    'https://raw.githubusercontent.com/FINTprosjektet/fint-informasjonsmodell/master/xsd/1.0/FINT/Felles/fintfelles.xsd',
    'https://raw.githubusercontent.com/FINTprosjektet/fint-informasjonsmodell/master/xsd/1.0/FINT/Arbeidstaker/arbeidstaker.xsd'
)
$xsdTool = "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6.1 Tools\xsd.exe"

# DOWNLOAD FILES TO XSD FOLDER
foreach($xsd in $xsds){
    $filename = [System.IO.Path]::GetFileName($xsd);
    (New-Object Net.WebClient).DownloadFile($xsd, $xsdFolder + $filename)
    Write-Host "Downloaded $filename." 
}

# GENERATE CS-file from XSD
$args = @('/classes', "/o:$modelFolder")
& $xsdTool ((Get-ChildItem $xsdFolder | ForEach-Object { $xsdFolder + $_.Name }) + $args)
Write-Host "CS-model generated." 
