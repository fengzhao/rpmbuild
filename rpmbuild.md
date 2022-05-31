# 浅谈RPM包的制作


源码包有源码包的灵活，RPM包有RPM包的方便，一些比较常用的生产工具包，打成RPM包还是比较方便的。

当我们在 Linux 服务器中安装软件时，有两种方式，一种是用 RPM 包安装，另外一种是自己编译源码包来安装。

众所周知，编译源码包安装是异常的麻烦，而我们用 RPM 安装确实很简单的事，只需一条命令就 OK 了。

但我们所用的 RPM 包可都是别人封装好的，说句不好听的话，谁知道它里面有没有病毒呢？于是，在一些比较注重安全的企业中，一般都会用自己封装的 RPM 包进行安装。






# 构建过程

```shell
# 在centos7中构建oprensty的rpm包
# 将当前项目克隆在主机的root目录下，因为rpmbuild有不少变量是基于家目录来做的。
git clone https://github.com/fengzhao/rpmbuild.git


# 配置源
yum -y install yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo


# 构建rpm包所需相关工具
yum -y install rpm-build redhat-rpm-config rpmdevtools


# 编译openresty所需依赖
yum -y install gcc gcc-c++ systemtap-sdt-devel openresty-zlib-devel \
    openresty-openssl-devel openresty-pcre-devel gd-devel openresty-openssl111-devel ccache

# 下载spec中定义的源码文件
cd /root/rpmbuild/SPECS/openresty/   &&  spectool -g -R openresty.spec

# 执行打包命令
rpmbuild -ba openresty.spec



# 当看到最后结果返回值为0时，则说明构建成功。如果有报错，则根据报错信息进行具体应对工作。
# 成功之后，会在 /root/rpmbuild/RPMS 目录中生成构建好的rpm包。



# 查看当前构建包信息
cd /root/rpmbuild/RPMS/x86_64  &&  rpm -qpi openresty-1.19.9.1-1.eryajf.el7.x86_64.rpm

Name        : openresty
Version     : 1.19.9.1
Release     : 1.eryajf.el7
Architecture: x86_64
Install Date: (not installed)
Group       : System Environment/Daemons
Size        : 3714763
License     : BSD
Signature   : (none)
Source RPM  : openresty-1.19.9.1-1.eryajf.el7.src.rpm
Build Date  : Thu Oct 21 23:00:12 2021
Build Host  : 13264c814536
Relocations : (not relocatable)
Packager    : https://github.com/eryajf
URL         : https://openresty.org/
Summary     : OpenResty, scalable web platform by extending NGINX with Lua
Description :
This package contains the core server for OpenResty. Built for production
uses.

OpenResty is a full-fledged web platform by integrating the standard Nginx
core, LuaJIT, many carefully written Lua libraries, lots of high quality
3rd-party Nginx modules, and most of their external dependencies. It is
designed to help developers easily build scalable web applications, web
services, and dynamic web gateways.

By taking advantage of various well-designed Nginx modules (most of which
are developed by the OpenResty team themselves), OpenResty effectively
turns the nginx server into a powerful web app server, in which the web
developers can use the Lua programming language to script various existing
nginx C modules and Lua modules and construct extremely high-performance
web applications that are capable to handle 10K ~ 1000K+ connections in
a single box.

```

##
