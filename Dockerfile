FROM runpod/base:0.7.0-noble-cuda1290

ARG COMFYUI_VERSION
ENV COMFYUI_DIR=/ComfyUI
ENV RP_COMFYUI_WORKSPACE=${RP_WORKSPACE}${COMFYUI_DIR}

# Create model directories and download models and custom nodes first (this layer will be cached)
RUN mkdir -p ${RP_COMFYUI_WORKSPACE}/models/{checkpoints,clip,clip_vision,controlnet,diffusers,embeddings,loras,upscale_models,vae}
RUN mkdir -p ${RP_COMFYUI_WORKSPACE}/custom_nodes
RUN mkdir -p ${RP_COMFYUI_WORKSPACE}/workflows

# Setup Python and pip symlinks
RUN ln -sf /usr/bin/python3.10 /usr/bin/python && \
    ln -sf /usr/bin/python3.10 /usr/bin/python3 && \
    python -m pip install --upgrade pip && \
    ln -sf /usr/local/bin/pip3.10 /usr/local/bin/pip

# Install ComfyUI and ComfyUI Manager
RUN mkdir -p ${COMFYUI_DIR} && cd ${COMFYUI_DIR} && \
    git init && \
    git remote add origin https://github.com/comfyanonymous/ComfyUI.git && \
    git fetch --depth 1 origin tag ${COMFYUI_VERSION} && \
    git checkout FETCH_HEAD && \
    pip install -r requirements.txt && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager && \
    cd custom_nodes/ComfyUI-Manager && \
    pip install -r requirements.txt

# Install missing dependencies
RUN /usr/bin/python -m uv pip install \
    "timm" \
    "segment-anything" \
    "scikit-image" \
    "piexif" \
    "opencv-python-headless" \
    "scipy>=1.11.4" \
    "numpy<2" \
    "dill" \
    "matplotlib" \
    "git+https://github.com/facebookresearch/sam2"


# Create user directory
RUN mkdir -p ${COMFYUI_DIR}/user/default

# Replace ComfyUI directories with symlinks to workspace
RUN rm -rf ${COMFYUI_DIR}/models && ln -sf ${RP_COMFYUI_WORKSPACE}/models ${COMFYUI_DIR}
RUN rm -rf ${COMFYUI_DIR}/custom_nodes && ln -sf ${RP_COMFYUI_WORKSPACE}/custom_nodes ${COMFYUI_DIR}
RUN rm -rf ${COMFYUI_DIR}/user/default/workflows && ln -sf ${RP_COMFYUI_WORKSPACE}/workflows ${COMFYUI_DIR}/user/default

# Copy the README.md, extra_model_paths.yml and start script
COPY README.md /usr/share/nginx/html/README.md
COPY --chmod=755 pre_start.sh /pre_start.sh

CMD [ "/start.sh" ]