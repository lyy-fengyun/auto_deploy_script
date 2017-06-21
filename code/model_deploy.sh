#!/bin/bash

#
#

# load common variable and function
. common.sh

app_name=''


tomact_app_name=''
webapp_name=''



start_shell_name="startup.sh"
init_upload_workspace(){
    cd $g_upload_root_dir
    cd $deploy_day
    pwd
}

init_app_workspace(){
    cd $g_app_install
    cd $app_name
    pwd 
}

init_webapp_workspace(){
    init_app_workspace
    cd 
}


# function 
backup(){
    full_backup
    add_backup
}

# 
full_backup(){

}

add_backup(){

}


startup(){

}

shutdown (){

}

restart (){
    shutdown
    startup
}

rollback (){

}

deploy (){

}

check_deploy(){

}
