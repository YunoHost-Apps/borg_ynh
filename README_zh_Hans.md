<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 的 Borg Backup

[![集成程度](https://dash.yunohost.org/integration/borg.svg)](https://dash.yunohost.org/appci/app/borg) ![工作状态](https://ci-apps.yunohost.org/ci/badges/borg.status.svg) ![维护状态](https://ci-apps.yunohost.org/ci/badges/borg.maintain.svg)

[![使用 YunoHost 安装 Borg Backup](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=borg)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Borg Backup。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

A [Borg](https://borgbackup.readthedocs.io/en/stable/index.html#what-is-borgbackup) implementation to backup a YunoHost server.

This is the Borg Backup App to be installed on a server to backup. It works together with a [Borg Server App](https://github.com/YunoHost-Apps/borgserver_ynh) installed on a host server.


**分发版本：** 1.2.8~ynh1
## 文档与资源

- 官方应用网站： <https://borgbackup.readthedocs.io>
- YunoHost 商店： <https://apps.yunohost.org/app/borg>
- 报告 bug： <https://github.com/YunoHost-Apps/borg_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/borg_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
或
sudo yunohost app upgrade borg -u https://github.com/YunoHost-Apps/borg_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
