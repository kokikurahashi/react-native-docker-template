FROM node:24-bookworm-slim

WORKDIR /app
RUN chown node:node /app

# root ではなく node ユーザー（UID 1000）で動かす。
# WSL 2 ではコンテナが root で作ったファイル（package-lock.json 等）が root 所有になり、
# 手元で編集できなくなるのを防ぐ
USER node

# 依存だけ先に入れて、ソース変更時のビルドキャッシュを効かせる
COPY --chown=node:node package.json package-lock.json ./
RUN npm ci

COPY --chown=node:node . .

# Metro（開発サーバー）
EXPOSE 8081

CMD ["npx", "expo", "start"]
