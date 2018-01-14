FROM ukyoda/ubuntu_pyenv:14.04_anaconda3

# Dependencies Components
RUN    apt-get install -y cmake gcc g++ git \
                          libjpeg-dev libpng-dev libtiff5-dev \
                          libavcodec-dev libavformat-dev libswscale-dev \
                          pkg-config libgtk2.0-dev libopenblas-dev libatlas-base-dev liblapack-dev \
                          libeigen3-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev \
                          sphinx-common libtbb-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev \
                          libopenexr-dev libgstreamer-plugins-base1.0-dev \
                          libavcodec-dev libavutil-dev libavfilter-dev libavformat-dev libavresample-dev \
                          ffmpeg wget liblapacke-dev \
    && apt-get clean

# Boost Install for conda
RUN conda install -c conda-forge boost=1.66.0

# OpenCV install
RUN    install_version=3.2.0 \
    && mkdir /opt/opencv \
    && cd /opt/opencv \
    && wget https://github.com/opencv/opencv/archive/${install_version}.tar.gz -O opencv-${install_version}.tar.gz \
    && wget https://github.com/opencv/opencv_contrib/archive/${install_version}.tar.gz -O contrib-${install_version}.tar.gz \
    && mkdir opencv_${install_version} && tar xvzf opencv-${install_version}.tar.gz -C opencv_${install_version} --strip-components 1 \
    && mkdir contrib_${install_version} && tar xvzf contrib-${install_version}.tar.gz -C contrib_${install_version} --strip-components 1 \
    && opencv_src_dir=opencv_${install_version} \
    && opencv_contrib_dir=contrib_${install_version} \
    && cd ${opencv_src_dir} \
    && mkdir release \
    && cd release \
    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
             -D CMAKE_INSTALL_PREFIX=/usr/local \
             -D BUILD_opencv_java=OFF \
             -D WITH_IPP=OFF \
             -D WITH_1394=OFF \
             -D WITH_FFMPEG=OFF \
             -D BUILD_EXAMPLES=OFF \
             -D BUILD_TESTS=OFF \
             -D BUILD_PERF_TESTS=OFF \
             -D BUILD_DOCS=OFF \
             -D BUILD_opencv_python2=OFF \
             -D BUILD_opencv_python3=ON \
             -D BUILD_opencv_video=OFF \
             -D PYTHON3_EXECUTABLE=/usr/local/pyenv/shims/python \
             -D PYTHON_INCLUDE_DIR=/usr/local/pyenv/versions/anaconda3-5.0.1/include/python3.6m \
             -D PYTHON3_LIBRARY=/usr/local/pyenv/versions/anaconda3-5.0.1/lib \
             -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/pyenv/versions/anaconda3-5.0.1/lib/python3.6/site-packages/numpy/core/include \
             -D PYTHON3_PACKAGES_PATH=/usr/local/pyenv/versions/anaconda3-5.0.1/lib/python3.6/site-packages \
             -D OPENCV_EXTRA_MODULES_PATH=../../${opencv_contrib_dir}/modules \
             .. \
    && make -j \
    && make install \
    && rm /opt/opencv/*.tar.gz
