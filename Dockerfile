FROM arm64v8/ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get -y install --no-install-recommends software-properties-common git libusb-1.0-0-dev wget python3-colcon-common-extensions udev

ENV WS=/ws
RUN mkdir -p $WS/src
RUN cd $WS/src && git clone https://github.com/grusel-opi/depthai-ros.git
RUN cd .$WS/ && rosdep install --from-paths src --ignore-src  -y
RUN cd .$WS/ && . /opt/ros/humble/setup.sh && ./src/depthai-ros/build.sh -s 1 -r 1 -m 1 

RUN echo "if [ -f ${WS}/install/setup.bash ]; then source ${WS}/install/setup.bash; fi" >> $HOME/.bashrc

RUN git clone https://github.com/grusel-opi/turtlebot4_ws.git -b oakd
RUN cd turtlebot4_ws && . /opt/ros/humble/setup.sh && . ${WS}/install/setup.sh && colcon build --symlink-install

RUN echo "if [ -f /turtlebot4_ws/install/setup.bash ]; then source /turtlebot4_ws/install/setup.bash; fi" >> $HOME/.bashrc

ENV ROS_LOCALHOST_ONLY=1

COPY ./entrypoint.sh ./
RUN ["./entrypoint.sh"]
CMD ["bash"]
