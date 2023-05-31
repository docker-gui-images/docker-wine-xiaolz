# docker-wine-xiaolz

docker-wine-xiaolz 可以使你通过 Wine 在 Docker 容器中运行 小栗子框架。本项目仅对 x86_64 平台提供支持，**暂不支持**树莓派、路由器等 Arm 架构硬件。

**因 小栗子框架 对GBK支持较好，故本项目使用zh_CN.GBK而非zh_CN.UTF-8，如遇相关问题，请自行搜寻通用解决方案**

即使该 dockerfile 仓库使用 GPL 发布，其中下载的软件仍然遵循其最终用户使用许可协议，请确认同意协议后再进行下载使用。

随着版本更新，wine 的 小栗子框架 并不保证总是可用。若你遇到不可用问题，在严格按照下述步骤执行后仍可复现，请通过 Issue 反馈。

该项目修改自docker-wine-coolq， 非常感谢相关贡献者做出的开创性工作。

## 下载使用

如果你在服务器上使用 `docker` 或者和 docker 兼容的服务，只需执行：

```bash
docker pull flyqie/docker-wine-xiaolz
mkdir xiaolz && cd xiaolz
docker run --rm -p 9000:9000 -v `pwd`:/home/user/xiaolz -e VNC_GEOMETRY="1280x720" flyqie/docker-wine-xiaolz
```

即可运行一个 docker-wine-xiaolz 实例。运行后，访问 `http://你的IP:9000` 可以打开 noVNC 页面，输入 `MAX8char` 作为密码后即可看到 小栗子框架公益版 已经启动。

小栗子框架 和其数据文件会保存在容器内的 `/home/user/xiaolz` 文件夹下，映射到主机上则为上述命令第二步创建的文件夹。调整 `-v` 的参数可以改变主机映射的路径。

## 常用示例

### 使用 小栗子框架 其他版本

```bash
# 请先自行删除老的 xiaolz 目录
mkdir xiaolz
docker run --name=xiaolz -d -p 9000:9000 -v `pwd`/xiaolz:/home/user/xiaolz -e VNC_GEOMETRY="1280x720" -e XIAOLZ_URL="其他版本直链下载地址" flyqie/docker-wine-xiaolz
```

### 使用 HTTP Basic Authentication 进行鉴权 (推荐)

```bash
docker run --name=xiaolz -d -p 9000:9000 -v `pwd`/xiaolz:/home/user/xiaolz -e VNC_GEOMETRY="1280x720" -e VNC_PASSWD="" -e HTTP_AUTH_USER="auth_username" -e HTTP_AUTH_PASSWD="auth_password" flyqie/docker-wine-xiaolz
```

### 使用 VNC 进行鉴权 (不推荐)

```bash
docker run --name=xiaolz -d -p 9000:9000 -v `pwd`/xiaolz:/home/user/xiaolz -e VNC_GEOMETRY="1280x720" -e VNC_PASSWD="12345678" flyqie/docker-wine-xiaolz
```

## 环境变量

在创建 docker 容器时，使用以下环境变量，可以调整容器行为。

* **`HTTP_AUTH_USER`** HTTP Basic Authentication 用户名
* **`HTTP_AUTH_PASSWD`** HTTP Basic Authentication 密码
* **`VNC_PASSWD`** 设置 VNC 密码。注意该密码不能超过 8 个字符,，超过8个字符后的所有内容均无效。
* **`XIAOLZ_URL`** 设置下载 小栗子框架 的地址(必须为直链)，默认为 `https://api.ooomn.com/api/lanzou?url=lanzoux.com%2Fi9ddC0alqzxg&type=down`，即 小栗子框架公益版(第三方蓝奏云直链解析)。请确保下载后的文件能解压出 `小栗子框架*.exe`

