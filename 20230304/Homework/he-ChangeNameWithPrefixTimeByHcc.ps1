# 要遍历的文件根目录
$rootFolder = "D:\04_ITトレーニング\2023年03月期\20230304\202303Training\SampleFileWork"

# 设置了遍历深度 -Recurse -Depth 0 ，只遍历指定目录的当前子目录。
# 若用 -Recurse 遍历所有目录及子目录，则不同层级目录下的所有图片及同名图片都会被改名。
#   特别是加上重名判断后，不同层级子目录下同名文件所加序号，会根据遍历顺序总体依次递增
#   而不是在每级目录中从1开始递增
# 本文所有方案中判断重名后，处理方法为：在新名称最后加上序号以区分。（也可采用经判断重复而跳过改名过程的处理方法。）
Get-ChildItem -Path $rootFolder -Recurse -Depth 0 | ForEach-Object {
    if($_.PSIsContainer){
        # 如果是文件夹， 执行以下代码
        Write-Host "文件夹：" $_.FullName
    }elseif($_.Extension -eq ".jpg" -or $_.Extension -eq ".png"){
        # 如果是图片文件，执行以下代码
        Write-Host "图片文件：" $_.Name
        # 预先将新名字存入变量，用于判断若改名是否与已存在文件重名
        $newname = $_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $_.BaseName + $_.Extension

        <#
        # 方案一：先判断名称前缀是否是DSCF，是则修改名称
        if($_.BaseName.StartsWith("DSCF")){
            # 同一文件重复放入，判断更改名称是否会重名情况，如出现重名，后缀加序号
            $index = 1
            while (Test-Path -Path ($rootFolder + "\" + $newname)){
                $newname = $_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $_.BaseName + "-" + $index.ToString() + $_.Extension
                $index++
            }
            Rename-Item -Path $_.FullName -NewName $newname            
        }   
        #>
        
        <#
        # 方案二：先判断名称前缀是否是日期格式
        # 增加变量保存最后修改时间用于判断是否已改名
        $LastWriteTime = $_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff')
        # 如果文件名称前缀不是最后修改时间
        if(!($_.BaseName.StartsWith($LastWriteTime))){
            # 同一文件重复放入，判断更改名称是否会重名情况，如出现重名，后缀加序号
            $index = 1
            while (Test-Path -Path ($rootFolder + "\" + $newname)){
                $newname = $_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $_.BaseName + "-" + $index.ToString() + $_.Extension
                $index++
            }
            Rename-Item -Path $_.FullName -NewName $newname
        }
        #>

        # 方案三：日期正则表达式判断
        # 如果不符合日期yyyyMMdd-HHmmss.fff的正则表达式
        if(!($_.BaseName -match "^\d{8}-\d{6}\.\d{3}")){
            # 同一文件重复放入，判断更改名称是否会重名情况，如出现重名，后缀加序号
            $index = 1
            while (Test-Path -Path ($rootFolder + "\" + $newname)){
                $newname = $_.LastWriteTime.ToString('yyyyMMdd-HHmmss.fff') + '-' + $_.BaseName + "-" + $index.ToString() + $_.Extension
                $index++
            }
            Rename-Item -Path $_.FullName -NewName $newname
        }
    }else{
        # 如果是其他类型文件， 执行以下代码
        Write-Host "非图片文件：" $_.FullName
    }
}