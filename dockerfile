FROM jupyter/datascience-notebook:python-3.8

ENV PATH=/usr/local/cuda-11/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda-11/lib64:$LD_LIBRARY_PATH

# Update system-level dependencies
USER root
RUN apt-get update \
    && apt-get install -y \
        wget \
        gnupg2

# Install CUDA 11.2.2
RUN wget -qO /etc/apt/preferences.d/cuda-repository-pin-600 \
    https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin \
    && wget -qO cuda-repo.deb \
    https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda-repo-wsl-ubuntu-11-2-local_11.2.2-1_amd64.deb \
    && dpkg -i cuda-repo.deb \
    && apt-key add /var/cuda-repo-wsl-ubuntu-11-2-local/7fa2af80.pub \
    && apt-get update \
    && apt-get install -y --no-install-recommends cuda \
    && rm -rf /var/cuda-repo-wsl-ubuntu-11-2-local cuda-repo.deb

# Install cuDNN 8.1.1
RUN wget -qO cudnn.tgz \
    https://developer.download.nvidia.com/compute/redist/cudnn/v8.1.1/cudnn-11.2-linux-x64-v8.1.1.33.tgz \
    && tar -xzvf cudnn.tgz -C /usr/local --strip-components=1 \
    && rm cudnn.tgz

# Create and activate conda environment
RUN conda create --name my_first_env python=3.8 && \
    echo "conda activate my_first_env" >> ~/.bashrc


# Create a new user and change home directory
USER root
RUN useradd -ms /bin/bash new_user
ENV HOME /home/new_user
WORKDIR $HOME

# Install TensorRT 7.2.3
RUN pip3 install --upgrade setuptools pip \
    && pip3 install nvidia-pyindex \
    && pip3 install nvidia-tensorrt==7.2.3.4 \
    && sudo cp -R /opt/conda/lib/python3.8/site-packages/tensorrt/* /usr/local/cuda-11/lib64 \
    && sudo cp -R /opt/conda/lib/python3.8/site-packages/nvidia/cuda_nvrtc/lib/* /usr/local/cuda-11/lib64 \
    && sudo cp -R /opt/conda/lib/python3.8/site-packages/nvidia/cudnn/lib/* /usr/local/cuda-11/lib64

# Add user new_user to root group and grant sudo privileges
RUN usermod -aG root new_user \
    && echo "new_user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set the user to 'new_user' when the container starts
USER new_user

# Install packages from requirement.txt
COPY requirements.txt /tmp/requirements.txt
RUN /bin/bash -c "source activate my_first_env && pip3 install --no-warn-script-location -r /tmp/requirements.txt"

# Install IPython kernel for the environment
RUN ipython kernel install --user --name=my_first_env