FROM arm64v8/ros:humble-ros-base

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
   && apt-get -y install --no-install-recommends software-properties-common git libusb-1.0-0-dev wget python3-colcon-common-extensions


RUN sudo wget -qO- https://raw.githubusercontent.com/luxonis/depthai-ros/main/install_dependencies.sh | sudo bash


ENV WS=/ws
RUN mkdir -p $WS/src
RUN git clone https://github.com/grusel-opi/depthai-ros.git
COPY ./depthai-ros .$WS/src/depthai-ros
RUN cd .$WS/ && rosdep install --from-paths src --ignore-src  -y

RUN cd .$WS/ && . /opt/ros/humble/setup.sh && ./src/depthai-ros/build.sh -s 1 -r 1 -m 1 

RUN echo "if [ -f ${WS}/install/setup.bash ]; then source ${WS}/install/setup.bash; fi" >> $HOME/.bashrc

RUN git clone https://github.com/grusel-opi/turtlebot4_ws.git -b oakd
COPY ./turtlebot4_ws .$WS/src/turtlebot4_ws
RUN cd .$WS/ && . /opt/ros/humble/setup.sh && colcon build --symlink-install

COPY ./run_oakd.sh ./
RUN [ "./run_oakd.sh" ]





