#!/bin/bash
CURRENT_LOAD=85
function cpu_check(){
        if [ $CURRENT_LOAD -gt 80 ];then
                echo "Result: CPU Critical"
        elif [ $CURRENT_LOAD -gt 60 ] && [ $CURRENT_LOAD -le 80 ];then
                echo "Result: CPU Elevated"
        else
                echo "Result: CPU Normal"
        fi
}
function log_check(){
        if [ -f "/var/log/syslog" ];then
                echo "Result: Log Active"
        else
                echo "Result: Log Missing"
        fi
}
if [ "$1" = "cpu" ];then
        cpu_check
elif [ "$1" = "log" ];then
        log_check
else
        echo "Error: Invalid selection"
fi