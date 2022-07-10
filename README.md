# vaultwarden-windows

bitwarden 服务器的开源实现 vaultwarden 的 Windows 部署

[方式一：使用本仓库构建的二进制 exe 文件运行](#方式一使用本仓库构建的二进制-exe-文件运行)

[方式二：通过 WSL（1、2均可） 直接部署官方版本](#方式二通过-wsl12均可直接部署官方版本)


## 方式一：使用本仓库构建的二进制 exe 文件运行

### GitHub Action 自动构建 // TODO

### 本地构建

下载地址：[https://github.com/BigTear/vaultwarden-windows/releases](https://github.com/BigTear/vaultwarden-windows/releases)

> 已集成官方构建的 web-vault ，开箱即用

本地自行构建方法：

1. 安装 Windows OpenSSL 并配置环境变量
   > 参考方法：[windows上rust使用OpenSSL](https://blog.csdn.net/qq_44639125/article/details/124202994)

2. 重启终端或 IDE ，执行
   
   ```bash
   cargo build --features sqlite --release
   ```
   
   主程序构建完成，位置 `arget\release\vaultwarden.exe`

   其他构建选项和 web-vault 构建方法具体内容参考 [https://github.com/dani-garcia/vaultwarden/wiki/Building-binary](https://github.com/dani-garcia/vaultwarden/wiki/Building-binary) 自行构建即可

3. 构建后目录结构参考

   ```
   .\
   .\data            \\ 自行创建的文件夹
   .\web-vault       \\ web 界面
   .\vaultwarden.exe \\ 主程序
   ```


## 方式二：通过 WSL（1、2均可）直接部署官方版本

按步骤执行下方代码即可

1. 打开已有的 WSL 内的终端
2. 通过Wiki [https://github.com/dani-garcia/vaultwarden/wiki/Pre-built-binaries](https://github.com/dani-garcia/vaultwarden/wiki/Pre-built-binaries "https://github.com/dani-garcia/vaultwarden/wiki/Pre-built-binaries") 内的方法获取官方预构建的 docker 文件

   ```bash
   mkdir vw-image
   cd vw-image
   wget https://raw.githubusercontent.com/jjlin/docker-image-extract/main/docker-image-extract
   chmod +x docker-image-extract
   ./docker-image-extract vaultwarden/server:alpine
   ```
3. 执行命令打包

   ```bash
   cd output
   tar -cvf rootfs.tar.gz ./
   ```
4. 现在获得了一个可以安装为 WSL 的一个 Alpine 系统包，可以使用我下面的方法安装，自行调用 `wsl.exe` 安装了可直接跳过到第九步启动
5. 将 `rootfs.tar.gz` 拷贝到 Windows 系统目录中（目录自行选择）

   ```bash
   mkdir /mnt/d/vaultwarden
   cp ./rootfs.tar.gz /mnt/d/vaultwarden/rootfs.tar.gz
   ```
6. 下载 [https://github.com/yuk7/wsldl/releases/latest](https://github.com/yuk7/wsldl/releases/latest) 内的 [wsldl.exe](https://github.com/yuk7/wsldl/releases/download/22020900/wsldl.exe) 到 `D:\vaultwarden\` 文件夹内

   > 该文件下现在有 `wsldl.exe` 、 `rootfs.tar.gz` 两个文件
   >
7. 在资源管理器的地址栏中输入 `cmd` 打开命令提示符
8. 执行命令安装 WSL

   ```bash
   copy wsldl.exe vaultwarden.exe
   vaultwarden.exe install
   ```
9. 等待安装完成，输入命令进入该 WSL 中并启动 vaultwarden

   ```bash
   vaultwarden.exe
   REM 执行 `wsl.exe -d vaultwarden` 效果相同
   REM 进入子系统中，切换到根目录启动服务
   cd /
   ./start.sh
   ```
10. 屏幕会显示后台地址，比如我用的WSL1显示 [http://127.0.0.1:8000/](http://127.0.0.1:8000/) 访问没问题说明能用了，后续使用服务保持运行即可
11. 在 Windows 下启动该服务的命令

    ```bash
    .\vaultwarden.exe run cd /;/start.sh
    ```

可以将 exe 路径改成绝对路径，然后设为计划任务/服务/pm2来使他保持运行，ojbk