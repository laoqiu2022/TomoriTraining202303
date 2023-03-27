$folderPath = "D:\04_ITトレーニング\2023年03月期\20230304\202303Training\SampleFileWork"  # 指定文件夹路径
$folder = Get-ChildItem $folderPath -Recurse

foreach ($file in $folder) {
    if ($file -is [System.IO.FileInfo]) {
        # 判断是否为文件和快捷方式
        if ($file.BaseName.Length -lt 8 -or
        [regex]::IsMatch($file.BaseName.Substring(0,8),'^(?!\d{8})')) {
            Rename-Item -Path $file.FullName `
                -NewName ($file.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $file.BaseName + $file.Extension)
                # 重命名文件
            Write-Host "The $($file.FullName) be renamed."
        }
        else {
            Write-Host "The first eight characters of file $($file.FullName) represent a date. Skipping rename."
        }
    }
}
