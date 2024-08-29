#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/humble/setup.bash"
source "/ws/install/setup.bash"
source "$HOME/.bashrc"
exec "ros2 launch oakd cam_C.launch.py"