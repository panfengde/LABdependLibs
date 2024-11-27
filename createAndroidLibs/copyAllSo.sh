#!/bin/bash

# 源路径（包含多个子目录，每个子目录中有 ABI 目录）
SOURCE_DIR="/Users/panfeng/coder/myProject/LABdependLibs/createAndroidLibs/app/build/intermediates/cxx/Debug"

# 目标路径（将 .so 文件复制到的路径）
DEST_DIR="/Users/panfeng/coder/myProject/LABdependLibs/outPutLibs"

# 检查源目录是否存在
if [ ! -d "$SOURCE_DIR" ]; then
  echo "源目录 $SOURCE_DIR 不存在！请检查路径。"
  exit 1
fi

# 创建目标目录
mkdir -p "$DEST_DIR"

# 遍历源目录下的所有子目录
for MODULE_DIR in "$SOURCE_DIR"/*; do
  if [ -d "$MODULE_DIR" ]; then
    echo "处理模块目录：$MODULE_DIR"

    # 定位到 obj 文件夹
    OBJ_DIR="$MODULE_DIR/obj"
    if [ -d "$OBJ_DIR" ]; then
      echo "找到 obj 文件夹：$OBJ_DIR"

      # 遍历 obj 文件夹下的所有 ABI 目录
      for ABI_DIR in "$OBJ_DIR"/*; do
        if [ -d "$ABI_DIR" ]; then
          ABI_NAME=$(basename "$ABI_DIR") # 获取 ABI 目录名
          TARGET_DIR="$DEST_DIR/$ABI_NAME" # 目标路径下的 ABI 目录

          # 创建目标 ABI 目录
          mkdir -p "$TARGET_DIR"

          # 复制 .so 文件
          find "$ABI_DIR" -type f -name "*.so" -exec cp {} "$TARGET_DIR" \;

          echo "已将 $ABI_NAME 的 .so 文件从 $ABI_DIR 复制到 $TARGET_DIR"
        fi
      done
    else
      echo "跳过模块：$MODULE_DIR，因为没有找到 obj 文件夹"
    fi
  fi
done

echo "所有 .so 文件已复制完成！目标目录：$DEST_DIR"