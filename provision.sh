#!/usr/bin/env bash


# For colorization
RED='\033[0;31m'  # Red for error messages
YLW='\033[0;33m' # Yellow for notes
NO_COLOR='\033[0m'      # Revert terminal back to no color

welcome() {

    echo -e "${RED}    ___                _     _                        ${NO_COLOR}"
    echo -e "${RED}   / _ \\_ __ _____   _(_)___(_) ___  _ __   ___ _ __  ${NO_COLOR}"
    echo -e "${RED}  / /_)/ '__/ _ \\ \\ / / / __| |/ _ \\| '_ \\ / _ \\ '__| ${NO_COLOR}"
    echo -e "${RED} / ___/| | | (_) \\ V /| \\__ \\ | (_) | | | |  __/ |    ${NO_COLOR}"
    echo -e "${RED} \\/    |_|  \\___/ \\_/ |_|___/_|\\___/|_| |_|\\___|_|    ${NO_COLOR}"
    echo -e "${RED}                                                      ${NO_COLOR}"

    echo -e "${YLW}Welcome to Ben's Provisioner!\n\n${NO_COLOR}"


    choice=""

    while [[ $choice != 'p' && $choice != 'w' ]]
    do
        echo -e "Are you setting up a ${RED}Personal${NO_COLOR} ('${RED}p${NO_COLOR}') or ${YLW}Work${NO_COLOR} ('${YLW}w${NO_COLOR}') environment? \n (${RED}p${NO_COLOR}/${YLW}w${NO_COLOR}) > "

        read choice

        if [[ $choice == 'p' ]]
        then
            echo -e "Provisioning for a ${RED}personal${NO_COLOR} device\n\n"
            personal=1
        else
            echo -e "Provisioning for a ${YLW}work${NO_COLOR} device\n\n"
            personal=0
        fi
    done

}

main() {
    DEBIAN_FRONTEND=noninteractive sudo apt install -y software-properties-common
    echo -e "Adding Ansible PPA...\n"
    apt-add-repository -y --update ppa:ansible/ansible
    echo -e "Installing Ansible...\n"
    DEBIAN_FRONTEND=noninteractive sudo apt install -y ansible git

    echo "localhost" >> /etc/ansible/hosts


    echo -e "Ready to go! Running Ansible playbooks now.\n\n\n"

    ansible-pull -k -U https://github.com/bengooch7/provisioner -e personal=$personal
}

welcome

main
