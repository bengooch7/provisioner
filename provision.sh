#!/usr/bin/env bash

# This script is intended to stage the host for running ansible,
# which will finish the provisioning process.

# check_exit_status() {

#     if [ $? -eq 0 ]
#     then
#         echo
#         echo "Success"
#         echo
#     else
#         echo
#         echo "[ERROR] Process Failed!"
#         echo
		
#         read -p "The last command exited with an error. Exit script? (y/n) " answer

#         if [ "$answer" == "y" ]
#         then
#             exit 1
#         fi
#     fi
# }

# update() {

#     sudo apt update;
#     check_exit_status

#     sudo apt upgrade -y;
#     check_exit_status
# }

# housekeeping() {

#     sudo apt-get autoremove -y;
#     check_exit_status

#     sudo apt-get autoclean -y;
#     check_exit_status
# }

# echo "running updates..."
# update
# housekeeping
# echo "done... updating"

choice=""

while [[ $choice != 'p' && $choice != 'w' ]]
do
    echo -e "Personal ('p') or Work ('w') environment? \n (p/w) > "

    read choice

    if [[ $choice == 'p' ]]
    then
        echo "Provisioning for a personal device"
        personal=1
    else
        personal=0
    fi
done

main() {
    DEBIAN_FRONTEND=noninteractive sudo apt install -y software-properties-common
    apt-add-repository -y --update ppa:ansible/ansible
    DEBIAN_FRONTEND=noninteractive sudo apt install -y ansible git
    ansible-pull -U https://github.com/bengooch7/provisioner -e personal=$personal
}

main
