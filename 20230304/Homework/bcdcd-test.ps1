# 定义要遍历的文件夹路径
$folderPath = "D:\04_ITトレーニング\2023年03月期\20230304\202303Training\SampleFileWork"

# 获取文件夹对象
$folder = Get-ChildItem -Path $folderPath -Recurse

# 正则表达式,yyyyMMdd-HHmmss
$regex = "^\d{8}-\d{6}"

# 遍历文件夹中的所有文件和子文件夹
foreach ($item in $folder) {
    # 判断是否为文件夹
    if ($item.PSIsContainer) {
        Write-Host "文件夹：" $item.FullName
    }
	# 判断文件名是否是日期开头
	elseif ($item.Name -match $regex) {
		Write-Host "文件：" $item.Name
	}
    else {
        Write-Host "文件：" $item.Name
		Rename-Item -Path $item.FullName`
		-NewName ($item.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $item.BaseName + $item.Extension)
    }
}


