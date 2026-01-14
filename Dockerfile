FROM ubuntu:22.04

# 设置非交互模式
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装基础依赖
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    gnupg \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm \
    firefox \
    xvfb \
    x11vnc \
    fluxbox \
    supervisor \
    novnc \
    websockify \
    && rm -rf /var/lib/apt/lists/*

# 安装 VS Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \
    && install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt-get update \
    && apt-get install -y code \
    && rm -rf /var/lib/apt/lists/*

# 安装 OpenCode
RUN npm install -g opencode

# 安装 Claude Code CLI
RUN npm install -g @anthropic-ai/claude-cli

# 安装 Cursor (通过下载AppImage)
RUN wget -O /tmp/cursor.AppImage https://download.cursor.sh/linux/appImage/x64 \
    && chmod +x /tmp/cursor.AppImage \
    && mv /tmp/cursor.AppImage /usr/local/bin/cursor

# 创建用户目录结构
RUN useradd -m -s /bin/bash developer \
    && echo 'developer:developer' | chpasswd \
    && usermod -aG sudo developer

# 设置工作目录
WORKDIR /home/developer

# 复制配置文件
COPY config/ /home/developer/.config/
COPY scripts/ /home/developer/scripts/
COPY desktop/ /home/developer/desktop/
COPY novnc/ /home/developer/novnc/

# 设置文件权限
RUN chown -R developer:developer /home/developer

# 复制supervisor配置
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# 暴露端口
EXPOSE 6080 5901

# 启动命令
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]