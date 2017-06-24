#!/bin/bash

# get jar file 

ips=(
192.168.86.71
192.168.86.69
)

ips2=(
192.168.86.72
192.168.86.70
)

apps=(
web-ocCrmFrontDCC7080
web-ocCrmFrontHttp7080
)

jars=(
oc-crm-front-dcc.jar
oc-crm-front-http.jar
)

shells=(
dcc_deploy_spring_boot.sh
http_deploy_spring_boot.sh    
)

source common.sh

app_install_root=/opt/upay/apps
get_jar(){
    i=0
    for ip in ${ips[@]}
    do
    scp $ip:${app_install_root}/${apps[$i]}/${jars[$i]} .
    scp $ip:${app_install_root}/${apps[$i]}/config/application-prod.properties  ./application-prod.properties.${ip}
    i=$((i+1))
    done 
}

put_jar(){
    ip_arr=$1
    i=0
    for ip in $(eval "echo $ip_arr")
    do
    # prepare_env $ip
    # scp ${jars[$i]}  $ip:${g_upload_root_dir}/${deploy_day}
    # scp application-prod.properties.${apps[$i]}  $ip:${g_upload_root_dir}/${deploy_day}/application-prod.properties
    # scp ${shells[$i]} $ip:${g_upload_root_dir}/${deploy_day}
    # scp common.sh $ip:${g_upload_root_dir}/${deploy_day}
    # i=$((i+1))
    echo $ips2
    done 
}

main(){
    put_jar '${ips[@]}'
    put_jar '${ips[@]}'
}

put_jar