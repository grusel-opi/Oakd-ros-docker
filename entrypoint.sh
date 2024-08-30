#!/bin/bash
set -e

source "/opt/ros/humble/setup.bash"
source "/ws/install/setup.bash"
source "/turtlebot4_ws/install/setup.bash"
exec "$@"

