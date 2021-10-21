yum -y install yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/repo/Centos-7.repo
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo

yum install rpm-build redhat-rpm-config rpmdevtools -y

yum -y install gcc gcc-c++ systemtap-sdt-devel openresty-zlib-devel openresty-openssl-devel openresty-pcre-devel gd-devel openresty-openssl111-devel ccache

spectool -g -R openresty.spec

rpmbuild -ba openresty.spec