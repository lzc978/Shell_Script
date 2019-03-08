#!/bin/sh
#脚本执行需要3个参数
if [ $# -eq 3 ]
then
  echo "开始执行git脚本..."
  echo "项目名：$1 , git克隆地址：$2 ， 你的新建分支名称：$3"
else
  echo "脚本执行需要3个参数：项目名 git克隆地址 你的新建分支名称"
  exit -1
fi
#获取当前执行脚本路径
dir=`pwd`
#获取今天的日期,格式:yyyymmdd
time=`date +%Y%m%d`
#项目名
project=$1
#git clone 地址
gitcloneurl=$2
#你的本地分支名称
feature=$3
#删除目录,为新建目录做准备
rm -rf "${project}-${time}"
mkdir "$dir"/"${project}-${time}"
cd "$dir"/"${project}-${time}"
#git clone
git clone "$gitcloneurl"
if [ $? -ne 0 ]; then
  echo "git clone url 错误"
  exit -1
fi
#切换到项目根目录
cd "$dir"/"${project}-${time}"/"${project}"
#从master新建本地分支
git checkout -b "$feature"
#git push,创建远程分支
git push origin "$feature":"$feature"
if [ $? -ne 0 ]; then
 echo "git push 错误"
 exit -1
fi
#建立本地分支与远程分支的关联关系,为push做准备
git branch --set-upstream-to=origin/"$feature"
#查看分支建立情况
git branch -vv
echo "you can open Pycharm to write Python code..."
