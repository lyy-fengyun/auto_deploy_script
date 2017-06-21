# global variable
g_app_install='/opt/upay/apps/'
g_upload_root_dir='/opt/upay/upload/'
g_backup_root_dir='/opt/upay/backup/'
today=$(date +%Y%m%d)
deploy_day=${deploy_day:-${today}}


# common function
# assert the function  args numbers
# usage: check_args_num nums $#
check_args_num(){
    args_num=$1
    num=$2
    if [[ ! "$args_num" -eq "$num" ]]
    then
        echo " $LINENO: the num of args is not equal to  $num "
        echo " function or script need $1 args."
        exit $E_PARAMETER
    fi
}

# wait for press Enter
pause(){
	read -p "press Enter to continue" RAN
}

# prepare environment for remote host, mkdir some necessary dir
# usage: prepare_env $ip
prepare_env()
{
check_args_num $# 1
ip=$1
echo "prepare dirs for $ip"
ssh $ip <<EEE
	[ ! -e "${g_upload_root_dir}${deploy_day}" ] && mkdir -p ${g_upload_root_dir}${deploy_day}
	[ ! -e "${g_backup_root_dir}${deploy_day}" ] && mkdir -p ${g_backup_root_dir}${deploy_day}
EEE
echo "prepare env finish!"
}
