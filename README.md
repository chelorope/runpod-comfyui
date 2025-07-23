# RunPod ComfyUI Template

A ready-to-use RunPod template with [ComfyUI v0.3.10](https://github.com/comfyanonymous/ComfyUI/releases/tag/v0.3.10) and pre-installed AI models for Stable Diffusion workflows.

## What's Included

- **ComfyUI** with ComfyUI Manager for easy custom node installation
- **Pre-installed Models:**
  - FLUX.1 schnell
  - Stable Diffusion XL Base & Refiner 1.0
  - Stable Diffusion 1.5 & 2.1
- **Jupyter Lab** for additional development work
- **SSH access** for advanced users

## Quick Start

1. Deploy this template on RunPod
2. Once running, access ComfyUI at `https://[your-pod-id]-3000.proxy.runpod.net`
3. Access Jupyter Lab at `https://[your-pod-id]-8888.proxy.runpod.net`

## Adding Custom Content

This template uses symbolic links to map persistent storage directories to ComfyUI's expected locations. All content placed in `/workspace/ComfyUI/` will be automatically available to ComfyUI and persisted between pod sessions.

### Models

Place your models in these directories (auto-detected via symbolic links):

- **Models** (`/workspace/ComfyUI/models/`)  
  AI models (SDXL, SD 1.5, FLUX, etc.)

### Custom Nodes

- **Custom Nodes** (`/workspace/ComfyUI/custom_nodes/`)  
  Third-party extensions that add new functionality to ComfyUI

### Workflows

- **Workflows** (`/workspace/ComfyUI/workflows/`)  
  Saved ComfyUI workflow files (.json) for reusable generation pipelines

> **💡 Tip:** Use a RunPod Network Volume to persist all your models, custom nodes, and workflows between pod sessions.

## Ports

| Service     | Port | Access URL Pattern                       |
| ----------- | ---- | ---------------------------------------- |
| ComfyUI     | 3000 | `https://[pod-id]-3000.proxy.runpod.net` |
| Jupyter Lab | 8888 | `https://[pod-id]-8888.proxy.runpod.net` |
| SSH         | 22   | Use RunPod's SSH instructions            |

## Environment Variables

- `JUPYTER_PASSWORD` - Set custom password for Jupyter Lab (optional)

## Support

- [Project Repo](https://github.com/chelorope/runpod-comfyui)
- [RunPod Discord Community](https://discord.gg/cUpRmau42V)
- [ComfyUI GitHub](https://github.com/comfyanonymous/ComfyUI)
