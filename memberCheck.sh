#!/bin/bash

######################################################################################
#     Authors     : Francisco Ramirez
#     Version     : 1.0.0
#     Description : Check Membership information on Linux Servers
#     Contributors:
######################################################################################

list_all_users_and_groups() {
    echo "Listing all users and their groups:"
    getent passwd | cut -d: -f1 | while read user; do
        groups=$(id -nG "$user")
        echo "$user: $groups"
    done
}

query_user_groups() {
    if [ -z "$1" ]; then
        echo "Please provide a username to query."
        return 1
    fi
    echo "Groups for user $1:"
    id -nG "$1"
}
list_users_in_group() {
    if [ -z "$1" ]; then
        echo "Please provide a group name to query."
        return 1
    fi
    echo "Users in group $1:"
    getent group "$1" | cut -d: -f4
}
if [ "$1" == "--all" ]; then
    list_all_users_and_groups
elif [ "$1" == "--user" ] && [ -n "$2" ]; then
    query_user_groups "$2"
elif [ "$1" == "--group" ] && [ -n "$2" ]; then
    list_users_in_group "$2"
    elif [ "$1" == "--help" ]; then
        echo "Usage: $0 [--all | --user <username> | --group <groupname> | --help]"
        echo
        echo "Options:"
        echo "  --all         List all users and their groups"
        echo "  --user        Query groups for a specific user"
        echo "  --group       List all users in a specified group"
        echo "  --help        Display this help message"
        exit 0
    fi
    exit 1
fi
