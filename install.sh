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
NVIM_CONFIG_DIR=~/.config/nvim
NVIM_SHARE_DIR=~/.local/share/nvim

echo $NVIM_SHARE_DIR

### 判断是否安装nvim
if is_installed nvim; then
  echo -e "nvim已经安装，跳过安装"
else
  echo -e "nvim还没有安装，先安装nvim..."
  brew install nvim
fi


### 判断配置文件是否存在
if [[ -d $NVIM_CONFIG_DIR ]]; then
  echo -e "配置文件存在，先备份配置文件..."
  mv $NVIM_CONFIG_DIR $NVIM_CONFIG_DIR.bak.$(date +%Y%m%d%H%M%S)
  mkdir -p $NVIM_CONFIG_DIR
fi


### 判断共享文件是否存在
if [[ -d $NVIM_SHARE_DIR ]]; then
  echo -e "共享文件存在，先备份共享文件..."
  mv $NVIM_SHARE_DIR $NVIM_SHARE_DIR.bak.$(date +%Y%m%d%H%M%S)
fi

ln -s $DOTFILES_DIR/nvim/* $NVIM_CONFIG_DIR/

### lua-language-server
if is_installed lua-language-server; then
  echo -e "lua-language-server已经安装，跳过安装"
else
  echo -e "lua-language-server还没有安装，先安装lua-language-server..."
  brew install lua-language-server
fi

### fzf
if is_installed fzf; then
  echo -e "fzf已经安装，跳过安装"
else
  echo -e "fzf还没有安装，先安装fzf..."
  brew install fzf
fi


## Tmux
echo -e "\nInstalling Tmux Configure...\n"
TMUX_CONFIG_FILE=~/.tmux.conf

### 判断是否安装tmux
if is_installed tmux; then
  echo -e "tmux已经安装，跳过安装"
else
  echo -e "tmux还没有安装，先安装tmux..."
  brew install tmux
fi

### 判断配置文件是否存在
if [[ -f $TMUX_CONFIG_FILE ]]; then
  echo -e "配置文件存在，先备份配置文件..."
  mv $TMUX_CONFIG_FILE $TMUX_CONFIG_FILE.bak.$(date +%Y%m%d%H%M%S)
fi

### 注意：不能用软链接
ln $DOTFILES_DIR/tmux/.tmux.conf $TMUX_CONFIG_FILE