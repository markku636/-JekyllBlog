$hostname = "blog"
$containerName = "blog-1"
$containerUrl = "tcp://192.168.50.52:2376"
$imageName = "blog"
$containerMacAddress = "00:0C:29:E8:24:F4"
$containerIpAddress = "192.168.0.142"
$logsVolumePath = "/share/Container/Logs"
$dockerfile = "./Dockerfile"

# 本地建置映像檔
docker build -t $hostname . -f $dockerfile

docker save -o C:\Project\$hostname.tar $imageName  # save 要搭配 load ; import 搭配 export

# 遠端建置映像檔 (nas 比本機電腦慢，這個就不建議了)
# docker  --tls -H="$containerUrl" build -t shopcart . -f ./Comma.Web/Dockerfile

# 停用容器
docker --tls -H="$containerUrl" ps -a -f ancestor=$containerName --no-trunc -q | foreach-object { docker --tls -H="$containerUrl" stop $_ }
docker --tls -H="$containerUrl" ps -a -f name=$containerName --no-trunc -q | foreach-object { docker --tls -H="$containerUrl" stop $_ }

# 移除容器
docker --tls -H="$containerUrl" ps -a -f ancestor=$containerName* --no-trunc -q | foreach-object { docker --tls -H="$containerUrl" rm -f $_ }
docker --tls -H="$containerUrl" ps -a -f name=$containerName* --no-trunc -q | foreach-object { docker --tls -H="$containerUrl" rm -f $_ }

# 移除映像檔

$existingImages = docker --tls -H="$containerUrl" images $imageName
If ($existingImages.count -gt 1) {
write-host "[Removing image]Removing the existing image.."
docker --tls -H="$containerUrl" rmi -f $imageName
} else {
write-host "[Removing image]The image does not exist"
}
Write-Host ”將本地的映像檔匯入 Docker 主機”
# 將本地的映像檔匯入 Docker 主機
docker --tls -H="$containerUrl" load --input  "C:\Project\$imageName.tar"

Write-Host ”建立及啟動容器應用”				
# 建立及啟動容器應用
docker --tls -H="$containerUrl" run -d --name $containerName --restart=always -p 49184:4000 $imageName				

pause

# 建立容器 ( port 號 map 不起來 )
# docker --tls -H="$containerUrl" `
# create `
# --hostname $hostname `
# --name $containerName `
# --workdir '/app' `
# --publish-all=true `
# --net bridge `
# --volume "$($logsVolumePath):/app/Logs:rw" `
# --publish "0.0.0.0::80" `
# -t `
# -i $imageName

# 啟動遊戲
# docker --tls -H="$containerUrl" start $containerName



