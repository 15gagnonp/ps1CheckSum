
function Get-CheckInfo {
    param ($filePath, $checkType, $CheckSumInput, $fileHash)
    $check = $false
    #checks if the user inputes a valid check sum name
    while ($check -eq $false) 
    {   
        $checkType = Read-Host -Prompt 'Enter CheckSum type (or type "options" for list of options)'
        switch ($checkType) {
        "options" {Write-Host "Hash options: SHA1 | SHA256 | SHA384 | SHA512 | MACTripleDES | MD5 | RIPEMD160"; break}
        "SHA1"  {$check = $true; break}
        "SHA256" {$check = $true; break}
        "SHA385" {$check = $true; break}
        "SHA512" {$check = $true; break}
        "MACTripleDES" {$check = $true; break}
        "MD5" {$check = $true; break}
        "RIPEMD160" {$check = $true; break}
        }
        if ($check -eq $false) {Write-Host "Error invalid Hash"}
        elseif ($check -eq $true) {$global:checkType = $checkType}
    }
    
    $global:filePath = Read-Host -Prompt 'Input your file path'
    $global:checkSumInput = Read-Host -Prompt "Input the $checkType checkSum"


    $global:fileHash = Get-FileHash $filePath -Algorithm "$checkType"
}
function Get-Valid {
    param (
        $checkSumInput, $fileHash
    )

    if($fileHash.Hash.ToLower() -eq $checkSumInput.ToLower())    
    {
        Write-Host "               File passes checkSum"
        Write-Host "checkSumInput: $checkSumInput"
        Write-Host "$checkType fileHash:" $fileHash.Hash.ToLower()
    }
    elseif($fileHash.Hash.ToLower() -ne $checkSumInput.ToLower())
    {
        Write-Host "File does not pass checkSum"
        Write-Host "checkSumInput: $checkSumInput"
        Write-Host "$checkType fileHash:"  $fileHash.Hash.ToLower()
    }
}
Get-CheckInfo $filePath $checkType $CheckSumInput $FileHash
Get-Valid $checkSumInput $FileHash




