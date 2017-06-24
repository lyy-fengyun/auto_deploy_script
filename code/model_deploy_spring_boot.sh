#!/bin/bash

#
#

# load common variable and function
. common.sh

# spring boot
app_name=''

$app_start_sh='start.sh'
app_stop_sh='stop.sh'

# workspace init
init_upload_workspace(){
    cd $g_upload_root_dir
    cd $deploy_day
    pwd
}

init_backup_workspace(){
    cd $g_backup_root_dir
    cd $deploy_day
    pwd
}

#-------------sprint boot-------------------
init_app_workspace(){
    cd $g_app_install
    cd $app_name
}

init_app_config_workspcae(){
    init_app_workspace
    cd config
}

# function 
backup(){
    full_backup
    add_backup
}

# 
full_backup(){
    init_app_workspace
    cd ../
    tar -cvf ${g_backup_root_dir}/${deploy_day}/${app_name}.${deploy_day}.tar $app_name 
}

add_backup(){
    init_web_classes_dir_workspace

}


startup(){
    init_app_workspace
    bash $app_start_sh
    sleep 3
    tail -n 50 ./logs/stdout.log
}

shutdown(){
    init_app_workspace
    bash $app_stop_sh
    sleep 3
    app_num='ps -ef| grep -v grep| grep $app_name | wc -l'
    if [[ $app_num -eq 0 ]];then
        echo "$app_name procress has bean shutdown."
    elif [[ $app_num -eq '1' ]]
        ps -ef| grep -v grep| grep $app | awk '{print $2}' | kill -9
        echo "$app_name procress has bean shutdown."
    else 
        ps -ef| grep -v grep| grep $app
        echo "$app progress can't be kill,find more than one progress"
        echo "please kill $app_name"
        pause
    fi
}

restart (){
    shutdown
    startup
}

rollback (){
    shutdown

    startup
}

deploy (){
    init_upload_workspace

}

check_deploy(){
    init_app_workspace
    
}
