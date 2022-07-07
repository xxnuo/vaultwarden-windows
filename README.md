# vaultwarden-windows

bitwarden 服务器的开源实现 vaultwarden 的 Windows 部署


[方式一：通过 WSL（1、2均可） 直接部署官方版本](%E6%96%B9%E5%BC%8F%E4%B8%80%EF%BC%9A%E9%80%9A%E8%BF%87%20WSL%EF%BC%881%E3%80%812%E5%9D%87%E5%8F%AF%EF%BC%89%20%E7%9B%B4%E6%8E%A5%E9%83%A8%E7%BD%B2%E5%AE%98%E6%96%B9%E7%89%88%E6%9C%AC)

[方式二：使用本仓库构建二进制 exe 文件运行](%E6%96%B9%E5%BC%8F%E4%BA%8C%EF%BC%9A%E4%BD%BF%E7%94%A8%E6%9C%AC%E4%BB%93%E5%BA%93%E6%9E%84%E5%BB%BA%E4%BA%8C%E8%BF%9B%E5%88%B6%20exe%20%E6%96%87%E4%BB%B6%E8%BF%90%E8%A1%8C)

### 方式一：通过 WSL（1、2均可） 直接部署官方版本

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
