#!/bin/bash

#
#

# load common variable and function
. common.sh

# spring boot
app_name=''

# tomcat 
tomact_app_name=''
webapp_name=''
start_shell_name="startup.sh"

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

#-------------tomcat-------------------
# project which used springboot
init_tomcat_workspace(){
    cd $g_app_install
    cd $tomact_app_name
    pwd 
}

# project which used tomcat 
init_webapp_workspace(){
    init_tomcat_workspace
    cd webapps
    cd $webapp_name
    pwd
}

# 进入 classes
init_web_classes_dir_workspace(){
    init_webapp_workspace
    cd WEB-INFO
    cd classes
    pwd
}
# ---------------



# function 
backup(){
    full_backup
    add_backup
}

# 
full_backup(){
    init_webapp_workspace
    cd ../
    tar -cvf ${g_backup_root_dir}/${deploy_day}/${webapp_name}.${deploy_day}.tar $webapp_name 
}

add_backup(){
    init_web_classes_dir_workspace

}


startup(){
    init_tomcat_workspace
    cd bin
    bash $start_shell_name
    sleep 3
    cd ../
    find . -name catalina.out -exec tail -n 10 {} \;
}

shutdown(){
    app=$1
    app_num='ps -ef| grep -v grep| grep $app | wc -l'
    if [[ $app_num -eq '1' ]];then
        ps -ef| grep -v grep| grep $app | awk '{print $2}' | kill -9
        echo "killed $app progress"
    else 
        ps -ef| grep -v grep| grep $app
        echo "$app progress can't be kill,find more than one progress"
        echo "please kill $app"
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

}

check_deploy(){

}
