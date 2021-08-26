# kiran-qdbusxml2cpp

有Qt5中带的qdbusxml2cpp二次开发而来，为了解决qdbusxml2cpp通过xml生成代理cpp代码时未提供属性变化信号  

目前暂时加入功能:
- 针对dbus xml描述中会发出改变信号的属性在生成的接口代理类中的属性中加入NOTIFY方法(本地不会存储属性的值、判断属性是否真实变化。所有信号由dbus服务发出，只负责转发)

## 使用

### 编译

1. 安装编译依赖

```bash
$ sudo yum install qt5-qtbase-devel cmake3
```

2. 在源码根目录下创建构建目录并进入构建目录

```bash
$ mkdir build && cd build
```

3. 运行cmake生成makefile

```bash
$ cmake -DCMAKE_INSTALL_PREFIX=/usr ..
```

4. make进行构建

```bash
$ make -j4
```

### 安装

```bash
$ sudo make install
```

### 运行

使用流程于qdbusxml2cpp一样，具体使用详情可使用'--help进行查看'

```bash
$ kiran-qdbusxml2cpp --help
```

### cmake项目中使用方法
```cmake
find_package(KiranDBusGenerate REQUIRED)
set(KSD_ACCOUNTS_XML data/com.kylinsec.Kiran.SystemDaemon.Accounts.xml)
#kiran_qt5_add_dubs_interface使用方法等同于qt5_add_dbus_interface
#具体更详细使用方法请查看qt5_add_dbus_interface的官方文档
kiran_qt5_add_dbus_interface(KSD_ACCOUNTS_SRC ${KSD_ACCOUNTS_XML} ksd_accounts_proxy)
```



