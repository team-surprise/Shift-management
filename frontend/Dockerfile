FROM node:20

ARG UID=1000
ARG GID=1000

# 既存の node ユーザー/グループのIDをホストに合わせる
RUN groupmod -g $GID node && \
    usermod -u $UID -g $GID node

WORKDIR /app

# /app ディレクトリを node ユーザーに権限付与
USER root
RUN chown -R node:node /app

# package*.json をコピーして権限変更
COPY package*.json ./
RUN chown node:node package*.json

# node ユーザーで npm install
USER node
RUN npm install --no-audit --no-fund

# 残りのソースをコピー（権限も合わせる）
USER root
COPY . .
RUN chown -R node:node /app

USER node
CMD ["npm", "run", "dev", "--", "--host"]
