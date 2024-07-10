FROM ubuntu:22.04

LABEL com.github.actions.name="rocm-setup"
LABEL com.github.actions.description="Setup AMD ROCm™ Platform for GPUs"
LABEL com.github.actions.icon="box"
LABEL com.github.actions.color="red"

LABEL repository="https://github.com/neoblizz/rocm-setup"
LABEL maintainer="Muhammad Awad <mawad@duck.com>"

# Install dependencies
RUN apt update && apt -y install wget build-essential git cmake

# Install ROCm
RUN wget https://repo.radeon.com/amdgpu-install/6.1.3/ubuntu/jammy/amdgpu-install_6.1.60103-1_all.deb
RUN apt -y install ./amdgpu-install_6.1.60103-1_all.deb
RUN apt update
RUN apt -y install rocm-hip-runtime-dev hipfft-dev

# Set environment variables
ENV PATH="$PATH:/opt/rocm/bin:/opt/rocm/rocprofiler/bin:/opt/rocm/hip/bin"
ENV LD_LIBRARY_PATH="/opt/rocm/lib:/opt/rocm/llvm/lib:/opt/rocm/hip/lib"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
