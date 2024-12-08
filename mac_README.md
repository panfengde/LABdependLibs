```shell
brew install autoconf automake libtool
```

./autogen.sh #生成配置文件
./configure CFLAGS="-arch arm64" --prefix=/Users/panfeng/coder/myProject/learn/libffi-master/result  --enable-debug --disable-docs
make
sudo make install

make distclean #清除缓存等