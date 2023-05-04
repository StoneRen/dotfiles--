#!/usr/bin/env bash

## 自身配置
echo -e "Installing StoneRen Dotfiles..."
## 本文件本身所在的位置
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo -e "环境检测："
echo "当前文件所在位置：$DOTFILES_DIR"

### 函数：判断当前环境是否是debug环境
function is_debug() {
  if [[ $DEBUG == "true" ]]; then
    echo -e "当前环境: DEBUG"
    return 0
  else
    return 1
  fi
}

### 函数：判断程序是否存在
function is_installed() {
  which $1 &> /dev/null
  return $?
}


## Nvim
echo -e "\nInstalling Nvim...\n"
NVIM_SHARE_DIR=~/.local/share/nvim

### 判断是否安装nvim
if is_installed nvim; then
  echo -e "nvim已经安装，跳过安装"
else
  echo -e "nvim还没有安装，先安装nvim..."
  brew install nvim
fi


### 判断配置文件是否存在
if [[ -d ~/.config/nvim ]]; then
  echo -e "配置文件存在，先备份配置文件..."
  mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d%H%M%S)
  mkdir -p ~/.config/nvim
fi

### 判断共享文件是否存在
if [[ ! $(is_debug) && -d $nvim_share_dir ]]; then
  echo -e "共享文件存在，先备份共享文件..."
  mv $nvim_share_dir $nvim_share_dir.bak.$(date +%y%m%d%h%m%s)
fi

ln -s $DOTFILES_DIR/nvim/* ~/.config/nvim/

