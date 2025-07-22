variable "RELEASE" {
    default = "0.0.0"
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
    tags = ["chelorope/runpod-comfyui:${RELEASE}"]
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
