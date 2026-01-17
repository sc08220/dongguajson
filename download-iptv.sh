#!/bin/bash
set -e  # 遇到错误立即退出

# ========== 已配置你的下载地址 ==========
DOWNLOAD_URL="https://live.ottiptv.cc/iptv.m3u?userid=637740173&sign=66a346c99703c9f92bda35dd4e54759812d0146988ab1c523582ac5b597a5c7a428caedbc097d157b5fcf4642c584ae9fecdd9630dde658abe5792f9575bd29ae5962fda6c9b&auth_token=37da0bd8e2bae76de5cba684042d4011"
TARGET_FILE="IPTV.m3u"
# =======================================

# 创建临时目录（确保环境干净）
mkdir -p ./temp

echo "开始下载m3u文件..."
# 模拟浏览器请求下载，适配防盗链
curl -L -s \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
  -H "Referer: https://live.ottiptv.cc/" \
  -o "./temp/temp.m3u" "$DOWNLOAD_URL"

# 检查文件是否下载成功且非空
if [ -f "./temp/temp.m3u" ] && [ -s "./temp/temp.m3u" ]; then
    echo "文件下载成功，开始重命名..."
    mv -f "./temp/temp.m3u" "./$TARGET_FILE"  # 覆盖并重命名
    echo "文件已重命名为 $TARGET_FILE"
    
    # 清理临时目录
    rm -rf ./temp
else
    echo "错误：文件下载失败或文件为空！可能是网址无效、token过期或被防盗链拦截"
    exit 1
fi

echo "操作完成！"
