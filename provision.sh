#!/usr/bin/env bash


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
