#!/bin/bash

# 源路径
SOURCE_DIR="/Users/panfeng/coder/myProject/LABdependLibs/createAndroidLibs/app/build/intermediates/cxx/Debug/3h1pn1j4/obj"

# 目标路径
DEST_DIR="/Users/panfeng/coder/myProject/LABdependLibs/outPutLibs"


# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
  echo "源目录 $SOURCE_DIR 不存在！请检查路径。"
  exit 1
fi

# 创建目标目录
mkdir -p "$DEST_DIR"

# 遍历源目录下的所有 ABI 目录
for ABI_DIR in "$SOURCE_DIR"/*; do
  if [ -d "$ABI_DIR" ]; then
    ABI_NAME=$(basename "$ABI_DIR") # 获取 ABI 目录名
    TARGET_DIR="$DEST_DIR/$ABI_NAME" # 目标目录路径

    # 创建对应的 ABI 目标目录
    mkdir -p "$TARGET_DIR"

    # 复制 .so 文件
    find "$ABI_DIR" -type f -name "*.so" -exec cp {} "$TARGET_DIR" \;

    echo "已将 $ABI_NAME 的 .so 文件复制到 $TARGET_DIR"
  fi
done

echo "所有 .so 文件已复制完成！目标目录：$DEST_DIR"
