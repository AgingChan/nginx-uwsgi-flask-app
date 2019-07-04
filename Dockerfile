FROM tiangolo/uwsgi-nginx-flask:python3.6

# COPY ./src /app

RUN BUILD_PACKAGES="\
        build-essential \
        " \
    APT_PACKAGES="\
        nginx \
        uwsgi \
        vim " \
    PIP_PACKAGES="\
        Flask>=1.0.2 \
        flask-restplus \
        flask-jwt-extended>=3.18.2 \
        pyjks>=18.0.0 \
        Flask-Sqlalchemy>=2.4.0 \
        mysql-connector-python>=8.0.16 \
        sqlalchemy \
        dynaconf \
        requests \
        PyCrypto \
        Pillow \
        uwsgi \
        numpy \
        Cython \
        opencv-python \
        apscheduler \
        " \
    APT_INSTALL="apt-get install -y --no-install-recommends" \
    && PIP_INSTALL="python -m pip --no-cache-dir install --upgrade"  \
    && rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list  \
    && apt-get update  \
# ==================================================================
# tools
# ------------------------------------------------------------------
    && DEBIAN_FRONTEND=noninteractive $APT_INSTALL  ${BUILD_PACKAGES} \
    && DEBIAN_FRONTEND=noninteractive $APT_INSTALL  ${APT_PACKAGES} \
# ==================================================================
# pytorch
# ------------------------------------------------------------------
    && PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" \
    && $PIP_INSTALL http://download.pytorch.org/whl/cpu/torch-0.4.0-cp36-cp36m-linux_x86_64.whl \
        ${PIP_PACKAGES}  \ 
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    && ldconfig \
    && apt-get remove --purge --auto-remove -y ${BUILD_PACKAGES} \
    && apt-get clean \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* ~/* \
    && rm -f /var/cache/apt/archives/*.deb \
        /var/cache/apt/archives/partial/*.deb \
        /var/cache/apt/*.bin

ENV ROOT_PATH_FOR_DYNACONF "/config"
