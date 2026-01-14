# CodeChat
CodeChat - Docker container with mainstream programming tools accessible via noVNC

![Docker Pulls](https://img.shields.io/docker/pulls/land007/codechat)
![GitHub Actions](https://img.shields.io/github/actions/workflow/status/land007/codechat/docker-build.yml)
![License](https://img.shields.io/github/license/land007/codechat)

## Quick Start

### Pull and Run
```bash
docker pull land007/codechat:latest
docker run -d -p 6080:6080 -p 5901:5901 --name codechat land007/codechat:latest
```

### Access
- **Web Interface**: http://localhost:6080 (noVNC)
- **VNC Client**: localhost:5901 (password: password)

### Build from Source
```bash
git clone https://github.com/land007/codechat.git
cd codechat
docker-compose up -d
```

## Project Structure
```
CodeChat/
├── .github/workflows/ # GitHub Actions CI/CD
├── scripts/          # Installation and setup scripts
├── config/           # Configuration files
├── desktop/          # Desktop environment files
├── novnc/            # noVNC configuration
├── Dockerfile        # Main Docker container definition
├── docker-compose.yml # Docker compose for easy deployment
└── README.md         # This file
```

## Tools Included
- **OpenCode** - CLI-based coding assistant
- **Cursor** - AI-powered code editor
- **Claude Code CLI** - Anthropic's Claude CLI tool
- **VS Code** - Microsoft's code editor
- **Firefox** - Web browser
- **Fluxbox** - Lightweight window manager

## Features
- 🌐 Web-based access via noVNC
- 🐳 Containerized environment
- 🛠️ Multiple programming tools in one place
- 🔄 Automatic Docker builds on GitHub
- 📱 Mobile-friendly VNC access
- 🔐 Password-protected VNC access

## Configuration
Set the following in your GitHub repository secrets:
- `DOCKER_USERNAME`: Your Docker Hub username
- `DOCKER_PASSWORD`: Your Docker Hub password or access token

## Usage Tips
1. The container starts with a Fluxbox desktop environment
2. Access tools through the desktop menu or terminal
3. Your workspace is mounted at `/home/developer/workspace`
4. Default VNC password: `password`