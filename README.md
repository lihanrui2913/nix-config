# NixOS 配置

这是当前 `nixos` 主机的 NixOS Flake 配置，包含由 Home Manager 管理的 `void` 用户软件包。

## 重建

在此目录执行：

```sh
sudo nixos-rebuild switch --flake .#nixos
```

首次使用时，配置自身会启用 `nix-command` 与 `flakes`。若当前 Nix 尚未启用这两个实验性功能，可先执行：

```sh
sudo nixos-rebuild switch --extra-experimental-features 'nix-command flakes' --flake .#nixos
```

## 结构

- `flake.nix`：锁定当前系统使用的 nixpkgs 提交，并集成 Home Manager。
- `modules/system.nix`：可跨主机复用的引导、网络和基础系统设置。
- `apps/`：系统级应用与桌面组件；每个软件各自一个模块文件。
- `home/void/void.nix`：`void` 用户的 Home Manager 主模块。
- `home/void/apps/`：`void` 用户软件包；每个软件各自一个模块文件。
- `hosts/nixos/`：当前主机名、用户和硬件配置。

## 其他机器

`hosts/nixos/hardware-configuration.nix` 包含当前电脑的磁盘 UUID、Btrfs 子卷和 AMD 硬件模块。因此本目录可在任意位置执行，但不能原样用于不同硬件的安装。

在另一台 NixOS 机器上，先用 `nixos-generate-config` 生成该机器的硬件配置，再替换 `hosts/nixos/hardware-configuration.nix`；通用系统和 Home Manager 配置保持不变。若要为多台机器保留不同硬件定义，应新增 `hosts/<hostname>/` 并在 `flake.nix` 中添加对应的 `nixosConfigurations` 条目。
