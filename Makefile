# 実機の Expo Go が接続しに来る、この PC の LAN 内 IP を自動で拾う
#   Mac                      : ipconfig getifaddr
#   Windows（WSL 2 の Ubuntu）: powershell.exe で Windows 側の IP を取る
# 優先順: make up HOST_IP=... ＞ 自動取得 ＞ .env の HOST_IP ＞ 127.0.0.1
ifeq ($(origin HOST_IP),undefined)
  ifeq ($(shell uname -s),Darwin)
    HOST_IP := $(shell ipconfig getifaddr en0 2>/dev/null || ipconfig getifaddr en1 2>/dev/null)
  else ifneq ($(shell grep -qi microsoft /proc/version 2>/dev/null && echo wsl),)
    HOST_IP := $(shell powershell.exe -NoProfile -Command '(Get-NetIPConfiguration | Where-Object { $$_.IPv4DefaultGateway -ne $$null -and $$_.NetAdapter.Status -eq "Up" } | Select-Object -First 1).IPv4Address.IPAddress' 2>/dev/null | tr -d '\r')
  endif
endif

# 取れたときだけ渡す（空で渡すと .env の HOST_IP が使われなくなるため）
ifneq ($(strip $(HOST_IP)),)
  export HOST_IP
endif

.PHONY: ip build up down sh typecheck install clean

ip: ## Expo Go の接続先になる IP を表示
	@if [ -n "$(HOST_IP)" ]; then echo "HOST_IP=$(HOST_IP)"; else echo "自動で取れませんでした。.env に HOST_IP=192.168.x.x を書くか、make up HOST_IP=192.168.x.x で指定してください"; fi

build: ## イメージを作る
	docker compose build

up: ## 開発サーバーを起動（QR コードが表示される）
	docker compose run --rm --service-ports app

down: ## 止める
	docker compose down

sh: ## コンテナに入る
	docker compose run --rm app bash

typecheck: ## 型チェック
	docker compose run --rm app npm run typecheck

install: ## パッケージを追加（例: make install PKG=expo-router）
	docker compose run --rm app npx expo install $(PKG)

clean: ## node_modules ボリュームごと消す（依存を入れ直したいとき）
	docker compose down -v
