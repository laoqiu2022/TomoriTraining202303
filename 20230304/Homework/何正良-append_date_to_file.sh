#!/bin/bash
#
#Append date befor the filename in directory $arg[1]
#Usage: append_date_to_file.sh 引数1(ディレクトリ)
#

#set variable
SHELL_NAME="`basename $0`"
DATE="`date +%x$X`"
TARGET_DIR="$1"
BASE_LINE="======================================================================================================================================="
FILE_DATE=""
FILE_NAME=""
FILE_CNT=0

#
#set function
BEGIN(){
    echo $BASE_LINE
    echo "The shell name: $SHELL_NAME date: $DATE BEGIN"
    echo "`uname -a`"
    echo $BASE_LINE
    echo
}
GET_FILE_DATE(){
    FILE_DATE="`stat -c %w $1 | awk -F'.' '{print $1}' | sed 's/[-:]//g;s/ /_/g'`"
}
RENAME_FILE(){
    mv "$1" "$2"
    if [[ $? -ne 0 ]];then
        FILE_NAME="$1"
        END 4
    fi
}
RENAME_FILES(){
    cd "$1"
    for i in `ls`
    do
        if [[ -d "$i" ]];then
            echo "$i はディレクトリです。リネームしません。"
#ファイルの初めのキャラクターで判断する場合
#        elif [[ "$i" =~ ^t.* ]];then
        elif [[ "$i" =~ [1-9][0-9]{3}[0-1][0-9][0-3][0-9]_[0-2][0-9][0-6][0-9][0-6][0-9]-.* ]];then
           continue
        else
            echo -en "$i \t rename-to \t"
            GET_FILE_DATE "$i"
            NEWFILE_NAME=$FILE_DATE-$i
            RENAME_FILE "$i" "$NEWFILE_NAME"
            echo "$NEWFILE_NAME"
            FILE_CNT="`expr $FILE_CNT + 1`"
        fi
    done
    echo "$FILE_CNT 個ファイルをリネームしました。"
}
END(){
    case $1 in
        1)
        echo "$SHELL_NAMEの引数がエラーです。"
        echo
        echo "Usage: $SHELL_NAME ディレクトリ名"
        echo $BASE_LINE
        echo "ディレクトリ$TARGET_DIR のファイルのリネームを失敗しました。"
        echo "The shell name: $SHELL_NAME date: $DATE ABNORMAL END"
        echo $BASE_LINE
        exit 1
        ;;
        2)
        echo "ディレクトリ$TARGET_DIR 存在しません。"
        echo
        echo $BASE_LINE
        echo "ディレクトリ$TARGET_DIR のファイルのリネームを失敗しました。"
        echo "The shell name: $SHELL_NAME date: $DATE ABNORMAL END"
        echo $BASE_LINE
        exit 2
        ;;
        3)
        echo "ディレクトリ$TARGET_DIR 実行または書込権限ありません。"
        echo
        echo $BASE_LINE
        echo "ディレクトリ$TARGET_DIR のファイルのリネームを失敗しました。"
        echo "The shell name: $SHELL_NAME date: $DATE ABNORMAL END"
        echo $BASE_LINE
        exit 3
        ;;
        4)
        echo "$FILE_NAME のリネームを失敗しました。"
        echo
        echo $BASE_LINE
        echo "ディレクトリ$TARGET_DIR のファイルのリネームを失敗しました。"
        echo "The shell name: $SHELL_NAME date: $DATE ABNORMAL END"
        echo $BASE_LINE
        exit 4
        ;;
        0)
        echo
        echo $BASE_LINE
        echo "ディレクトリ$TARGET_DIR のファイルのリネームを成功しました。"
        echo "The shell name: $SHELL_NAME date: $DATE NORMAL END"
        echo $BASE_LINE
        exit 0
        ;;
    esac
}

#処理START
BEGIN
if [[ $# -ne 1 ]];then
    END 1
fi
if [[ ! -d $1 ]];then
    END 2
fi
if [ ! -x "$1" -o ! -w "$1" ];then
    END 3
fi
RENAME_FILES $TARGET_DIR
END 0
#処理END
