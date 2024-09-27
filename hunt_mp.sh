#! /bin/bash

echo "The script will now enable EAC ipv4 ping for current session" && sleep 2
echo

gid=$(id -g)
sudo sysctl -w net.ipv4.ping_group_range="0 $gid"
echo

echo "EAC ping is enabled for this session" && sleep 2
echo

read -p "Do you wish to enable ipv4 ping for your user account by default? (y/n) " yn  


case $yn in
    [Yy]* )
        ping_allow_write=net.ipv4.ping_group_range="0 $gid"
        echo "$ping_allow_write;" | sudo tee /etc/sysctl.d/local.conf
        echo "The process is finished. \n"
        read -rsn1 -p"Press enter to close"
        ;;
    [Nn]* )
        echo "The process is finished."
        read -rsn1 -p"Press enter to close"
        ;;
    * )
        echo "Please answer yes or no."
        echo "invalid response - please execute the script again"
        read -rsn1 -p"Press enter to close"
        ;;
esac

