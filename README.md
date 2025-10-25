# X-Accelerated Docker Containers

This repository provides a comprehensive solution for creating and running X-accelerated Docker containers with a noVNC frontend. Designed for a range of applications, these containers are available in multiple flavors, from lightweight CPU-only environments to full desktop experiences with NVIDIA GPU acceleration.

## Getting Started

To get started, you can use one of the pre-built Docker images from [Docker Hub](https://hub.docker.com/r/twobombs/deploy-nvidia-docker).

### With NVIDIA Docker

```bash
docker run --gpus all --device=/dev/kfd --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker
```

### Docker Only

```bash
docker run --device=/dev/dri:/dev/dri -d twobombs/deploy-nvidia-docker
```

### Minimal CPU-Only

```bash
docker run -d twobombs/deploy-nvidia-docker:minimal
```

**Initial vnc password is `00000000`**
- **noVNC website is avaliable at port `6080`**
- **xRDP running at port `3389` to vnc `127.0.0.1:5900`**

## Dockerfiles

This repository includes three distinct Dockerfile flavors, each tailored to specific requirements:

| Dockerfile            | Description                                                                                                                              |
| --------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **`Dockerfile`**      | The main image, featuring NVIDIA drivers, a full XFCE desktop environment, and a suite of pre-installed applications.                        |
| **`Dockerfile-dev`**  | A development-focused image that extends the main image with additional tools and libraries essential for software development.            |
| **`Dockerfile-minimum`** | A lightweight, CPU-only image that offers a minimal desktop environment, ideal for basic tasks and resource-constrained systems.        |

## Scripts

The following scripts are used to run and manage the Docker containers:

| Script                        | Description                                                                                                                      |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| **`run`**                     | The entrypoint for the Docker-only container, responsible for launching the XFCE desktop and noVNC frontend.                          |
| **`run-nv`**                  | The entrypoint for the NVIDIA Docker container, which initializes the GPU-accelerated environment.                                  |
| **`run-minimum`**             | The entrypoint for the minimal CPU-only container, which starts a lightweight desktop environment.                                    |
| **`deploy-nvidia-docker2.sh`** | A utility script for setting up the host environment to ensure compatibility with NVIDIA Docker.                                     |

## Configuration

The container's environment can be customized using the following configuration files:

| File              | Description                                                                                                                                      |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| **`xorg.conf`**   | The X server configuration file, which defines the display settings and ensures proper rendering.                                                  |
| **`xstartup`**    | The VNC startup script, responsible for launching the desktop environment and applications when a VNC session begins.                               |
| **`passwd`**      | The VNC password file, which stores the password for accessing the noVNC frontend.                                                                |

This refined documentation provides a clearer and more comprehensive overview of the repository, making it easier for users to get started and customize their containers.
