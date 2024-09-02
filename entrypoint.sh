#!/bin/bash
set -e

source "/opt/ros/humble/setup.bash"
source "/ws/install/setup.bash"
source "/turtlebot4_ws/install/setup.bash"

ros2 launch oakd cam_C.launch.py &>/tmp/oakd.log &
PID=$!
echo "$PID">/tmp/oakd.pid
exec "$@"

