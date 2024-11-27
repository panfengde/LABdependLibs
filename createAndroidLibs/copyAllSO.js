const fs = require("fs");
const path = require("path");
const { mkdirSync, copyFileSync, existsSync, readdirSync, statSync } = fs;

// 源路径和目标路径
const SOURCE_DIR = "E:\\code\\LAB\\LABdependLibs\\createAndroidLibs\\app\\build\\intermediates\\cxx\\RelWithDebInfo";
const DEST_DIR = "E:\\code\\LAB\\LABdependLibs\\outPutLibs";

// 检查路径是否存在
if (!existsSync(SOURCE_DIR)) {
  console.error(`源目录 ${SOURCE_DIR} 不存在！请检查路径。`);
  process.exit(1);
}

// 创建目标目录（如果不存在）
mkdirSync(DEST_DIR, { recursive: true });

// 遍历源目录的子目录
readdirSync(SOURCE_DIR).forEach((moduleName) => {
  const modulePath = path.join(SOURCE_DIR, moduleName);

  if (statSync(modulePath).isDirectory()) {
    console.log(`处理模块目录：${modulePath}`);

    const objDir = path.join(modulePath, "obj");

    if (existsSync(objDir)) {
      console.log(`找到 obj 文件夹：${objDir}`);

      // 遍历 ABI 目录
      readdirSync(objDir).forEach((abiName) => {
        const abiDir = path.join(objDir, abiName);

        if (statSync(abiDir).isDirectory()) {
          const targetDir = path.join(DEST_DIR, abiName);

          // 创建目标 ABI 目录
          mkdirSync(targetDir, { recursive: true });

          // 查找并复制所有 .so 文件
          readdirSync(abiDir).forEach((file) => {
            const filePath = path.join(abiDir, file);
            if (statSync(filePath).isFile() && file.endsWith(".so")) {
              copyFileSync(filePath, path.join(targetDir, file));
              console.log(`已将 ${file} 从 ${filePath} 复制到 ${targetDir}`);
            }
          });
        }
      });
    } else {
      console.log(`跳过模块：${modulePath}，因为没有找到 obj 文件夹`);
    }
  }
});

console.log(`所有 .so 文件已复制完成！目标目录：${DEST_DIR}`);
