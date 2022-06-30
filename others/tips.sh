#!/bin/bash

# 环境
SHELL=SHELL
PATH=/usr/bin:

# 时间
current=$(date "+%H:%M")

# 确定提示的关键词
keyword=

if [ $current = "11:57" ]
then
    keyword="午餐"
elif [ $current = "18:55" ]
then
    keyword="下班"
elif [ $current = "15:00" ]
then
    keyword="定晚餐"
elif [ $current = "21:50" ]
then
    keyword="加班打车"
else
    keyword="休息"
fi

title="${keyword}提示"

time=$(date "+%Y-%m-%d %H:%M:%S")


# zenity 弹窗
zenity --question --width=320 --height=240  --title=$title  --text="现在是北京时间:
	${time}
	${keyword}时间快到了,您确认要继续吗？"


# crontab定时   * * * * *   export DISPLAY=:0.0; 绝对路径/tips.sh

