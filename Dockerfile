FROM public.ecr.aws/lambda/python:3.9  
RUN yum --assumeyes --quiet install \
deltarpm
RUN yum --assumeyes --quiet install \
cmake3 \
gcc10 \
gcc10-c++ \
libX11-devel \
libXi-devel \
libXxf86vm-devel \
libXrandr-devel \
mesa-libGL-devel \
kernel-devel \
git \
subversion
RUN svn --quiet checkout https://svn.blender.org/svnroot/bf-blender/tags/blender-2.93-release/lib/linux_centos7_x86_64 lib/linux_centos7_x86_64
RUN git clone -b blender-v2.93-release https://git.blender.org/blender.git blender
RUN make -C blender update
RUN mkdir ${LAMBDA_TASK_ROOT}/build
WORKDIR ${LAMBDA_TASK_ROOT}/build
RUN cmake3 \
-DCMAKE_CXX_COMPILER=/usr/bin/gcc10-c++ \
-DCMAKE_C_COMPILER=/usr/bin/gcc10-cc \
-DPYTHON_SITE_PACKAGES=/var/lang/lib/python3.9/site-packages \
-C ../blender/build_files/cmake/config/bpy_module.cmake &> /dev/null \
../blender \
&& make &> /dev/null \
&& make install &> /dev/null
WORKDIR ${LAMBDA_TASK_ROOT}
RUN rm -rf build && rm -rf blender && rm -rf lib
RUN yum --assumeyes --quiet remove \
cmake3 \
gcc10 \
gcc10-c++ \
libX11-devel \
libXi-devel \
libXxf86vm-devel \
libXrandr-devel \
mesa-libGL-devel \
kernel-devel \
git \
subversion
COPY app.py ./
CMD [ "app.lambda_handler" ]