sudo docker run -itd -v /dev/bus/usb:/dev/bus/usb -v /home/ubuntu:/recordings --device-cgroup-rule='c 189:* rmw' --name oakd --restart=always oakd
