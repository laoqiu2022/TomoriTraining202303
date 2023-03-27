$folderPath = "C:\Users\siske\Desktop\pic"

Get-ChildItem -Path $folderPath -Recurse | ForEach-Object {
    if($_.PSIsContainer) {
        Write-Host "Folder: $($_.FullName)"
    } else {
        $fileName = $_.Name
        if($fileName -match '^\d{8}') {
            Write-Host "File with date prefix: $($_.Name)"
        } else {
            Write-Host "File without date prefix: $($_.Name)"
					Rename-Item -Path $_.FullName `
        -NewName ($_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $_.BaseName + $_.Extension)

        }
    }
}
