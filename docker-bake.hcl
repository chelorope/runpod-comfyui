variable "RELEASE" {
    default = "0.0.1"
}

variable "COMFYUI_VERSION" {
    default = "v0.3.45"
}

variable "GITHUB_WORKSPACE" {
    default = "."
}

target "default" {
    context = "${GITHUB_WORKSPACE}"
    dockerfile = "Dockerfile"
    tags = ["chelorope/runpod-comfyui:${RELEASE}", "chelorope/runpod-comfyui:latest"]
    platforms = ["linux/amd64"]
    contexts = {
        scripts = "container-template"
        proxy = "container-template/proxy"
    }
    args = {
        COMFYUI_VERSION = "${COMFYUI_VERSION}"
        RELEASE = "${RELEASE}"
        GITHUB_WORKSPACE = "${GITHUB_WORKSPACE}"
    }
}
