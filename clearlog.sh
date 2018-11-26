#!/bin/bash

echo "Please wait..."
    #path="/home/logs/manager/"  #日志文件路径
    path=$1  #日志文件路径,脚本给入参数
    m1=`date -d "1 months ago" +%Y-%m`  #获取上个月的yyyy-mm格式的日期字符串
    m2=`date -d "1 months ago" +%Y-%m`
    index=0
    f=`ls $path -1 -c`  #获取日志文件下的文件列表
    for name in $f
    do
        n=`expr "$name" : '.*\([0-9]\{4\}-[0-9]\{2\}\).*'`  #从文件名称中提取yyyy-mm格式日期
        if [ "$n" != "" ] && [ "$n" = "$m1" ]
        then
		        #f[$index]=$path$name  #logs文件夹下符合要求的文件名称放入数组
		        f[$index]=$path$name/*  #logs文件夹下符合要求的文件名称放入数组
        else
                f[$index]=""
        fi
        (( index ++ ))
    done
    echo "$f"
    str=${f[@]}  #如果大于0
    if [ "${#str}" -gt 0 ]
    then
        zip $path/$m2.zip $str  #压缩数组中的文件为yyyy-mm.zip文件，打包放在日志所在文件路径下
    else
        exit 0
    fi
        #rm -rf $str  #删除已打包文件,针对一级路径结构
        rm -rf $path$m1-*  #删除已打包文件,针对多级路径结构
        exit 0
