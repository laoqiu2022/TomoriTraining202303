$inputForlder = ""

if(![string]::IsNullorEmpty($args[0])){
    if(Test-Path $args[0]){
        $inputForlder = $args[0]
    }
    else{
        Write-Host("Forlder not exist.") -BackgroundColor Blue;
        return
    }
}

$count = 0;
if($inputForlder -ne ""){
    Get-ChildItem -Path $inputForlder | ForEach-Object -Process{
        if($_ -is [System.IO.FileInfo])
        {
            #Write-Host($_.CreationTime);
            Write-Host($_.FullName);
            
            if (!($_.BaseName -match '^(\d{8}-\d{6}.\d{3}-)(.*)$')) {
                Rename-Item -Path $_.FullName `
                -NewName ($_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $_.BaseName + $_.Extension)
                $count++
            }            
        }
    }
}
else{
    Write-Host("Forlder is empty.") -BackgroundColor Blue;
}

Write-Host("Renamed $count files.") -BackgroundColor Blue;
