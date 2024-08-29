#!/bin/bash

set -e

# Not sure if already included in humble-perception
sudo apt install libopencv-dev

# Pull, build and install depthai core; add USB dev rules
RUN sudo wget -qO- https://raw.githubusercontent.com/luxonis/depthai-ros/main/install_dependencies.sh | sudo bash

# needed to build depthai-ros
RUN sudo apt install python3-rosdep
RUN sudo rosdep init
RUN rosdep update

# build
mkdir -p dai_ws/src
cd dai_ws/src
git clone https://github.com/grusel-opi/depthai-ros.git
cd ..
rosdep install --from-paths src --ignore-src -r -y
source /opt/ros/<ros-distro>/setup.bash
./src/build.sh -r 1 -m 1 -s 0

