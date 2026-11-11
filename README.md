# React Native × TypeScript テンプレート（Docker）

Expo（SDK 58 / React Native 0.88 / TypeScript）の最小構成です。
PC に Node.js を入れずに、Docker だけで開発サーバー（Metro）を動かし、スマホの **Expo Go** アプリで画面を確認します。

- **Mac** → 「A-1. 最初の一回だけやること（Mac）」→「B. 毎回やること」
- **Windows** → 「A-2. 最初の一回だけやること（Windows）」→「B. 毎回やること」

確認には iPhone または Android の実機を使います。

---

## A-1. 最初の一回だけやること（Mac）

何も入っていない Mac から、初めて起動するまでの手順です。上から順に進めてください。

### 1. Mac の準備

- [ ] **Docker Desktop をインストールする**
  - https://www.docker.com/products/docker-desktop/ から Mac 用（Apple シリコンなら「Apple Silicon」、Intel Mac なら「Intel Chip」）をダウンロード
  - `.dmg` を開き、Docker のアイコンを「アプリケーション」フォルダへドラッグ
- [ ] **Docker Desktop を起動する**
  - アプリケーションから「Docker」を開く
  - 初回は利用規約への同意と、ヘルパーのインストール（Mac のパスワード入力）を求められるので進める
  - メニューバーにクジラのアイコンが出て、アイコンの動きが止まれば起動完了
- [ ] **ターミナルで Docker が動くか確認する**（「ターミナル」アプリを開いて実行）
  ```bash
  docker --version
  docker compose version
  ```
  どちらもバージョン番号が出れば OK。
- [ ] **`make` コマンドがあるか確認する**
  ```bash
  make --version
  ```
  「command not found」やインストールを促すダイアログが出たら、次を実行して「インストール」を押す（数分かかる）。
  ```bash
  xcode-select --install
  ```

### 2. スマホの準備

- [ ] 「[スマホの準備（Mac / Windows 共通）](#スマホの準備mac--windows-共通)」をやる

### 3. プロジェクトの準備

- [ ] **このフォルダを手元に置く**（git で管理しているなら `git clone`、そうでなければフォルダごとコピー）
- [ ] **ターミナルでこのフォルダに移動する**
  ```bash
  cd ~/Documents/GitHub/react-native-docker-template
  ```
  （置いた場所に合わせて変える。Finder からフォルダをターミナルにドラッグすると場所が入力される）
- [ ] **アプリ名を変える（任意）** → 「[アプリ名の変え方](#アプリ名の変え方任意)」

### 4. Docker イメージを作る

- [ ] **スマホの接続先になる IP が取れるか確認する**
  ```bash
  make ip
  ```
  `HOST_IP=192.168.x.x` のように出れば OK。
- [ ] **イメージをビルドする**
  ```bash
  make build
  ```
  初回は Node.js 本体と依存パッケージをダウンロードするので数分かかる。最後に `Built` と出れば完了。

### 5. 初回の起動と確認

- [ ] 下の「B. 毎回やること」の **起動する** に進む
- [ ] **Mac のファイアウォールの確認が出たら「許可」を押す**
  - ダイアログが出ずにスマホがつながらない場合: 「システム設定」→「ネットワーク」→「ファイアウォール」が有効なら、「オプション」で Docker の受信接続を許可する

---

## A-2. 最初の一回だけやること（Windows）

何も入っていない Windows から、初めて起動するまでの手順です。上から順に進めてください。

Windows では **WSL 2（Windows の中で動く Linux / Ubuntu）の中で開発** します。
コマンドはすべて「Ubuntu」のターミナルで打ち、プロジェクトも Ubuntu 側に置きます
（`C:\` に置くと、保存してもスマホの画面が自動で更新されないため）。

### 1. Windows の準備

- [ ] **Windows のバージョンを確認する**
  - Windows 11、または Windows 10（22H2 以降）であること
  - 確認方法: `Win + R` →「`winver`」と入力して Enter
- [ ] **仮想化が有効か確認する**
  - `Ctrl + Shift + Esc` でタスクマネージャーを開く →「パフォーマンス」→「CPU」→ 右下の「仮想化: 有効」を確認
  - 「無効」なら、PC の BIOS/UEFI 設定で仮想化（Intel なら「Intel VT-x / Virtualization Technology」、AMD なら「SVM / AMD-V」）を有効にする。設定画面の入り方は PC のメーカーごとに違うので、「機種名 仮想化 有効」で調べる
- [ ] **WSL 2 と Ubuntu をインストールする**
  - スタートメニューで「PowerShell」を検索 → 右クリック →「管理者として実行」
  - 次を実行する
    ```powershell
    wsl --install
    ```
  - 終わったら **PC を再起動** する
  - 再起動後に Ubuntu のウィンドウが開く（開かなければスタートメニューから「Ubuntu」を起動）
  - **Linux 用のユーザー名とパスワードを決めて入力する**（Windows のものとは別。パスワードは入力しても画面に表示されないが、そのまま打って Enter）
- [ ] **WSL 2 で動いているか確認する**（PowerShell で実行）
  ```powershell
  wsl -l -v
  ```
  `Ubuntu` の `VERSION` が `2` なら OK。
- [ ] **Docker Desktop をインストールする**
  - https://www.docker.com/products/docker-desktop/ から Windows 用をダウンロードして実行
  - 途中の「Use WSL 2 instead of Hyper-V（recommended）」は **チェックを入れたまま** 進める
  - 終わったら、求められればサインアウトまたは再起動する
- [ ] **Docker Desktop を起動する**
  - スタートメニューから「Docker Desktop」を開く
  - 初回は利用規約への同意を求められるので進める（Docker アカウントへのサインインは不要。スキップしてよい）
  - タスクバー右下（通知領域）にクジラのアイコンが出て、アイコンの動きが止まれば起動完了
- [ ] **Docker Desktop を Ubuntu から使えるようにする**
  - Docker Desktop の歯車アイコン（Settings）→「Resources」→「WSL integration」
  - 「Ubuntu」をオンにして「Apply & restart」
- [ ] **Ubuntu で Docker が動くか確認する**（スタートメニューから「Ubuntu」を開いて実行。以降のコマンドはすべてここで打つ）
  ```bash
  docker --version
  docker compose version
  ```
  どちらもバージョン番号が出れば OK。「command not found」なら、前の手順の WSL integration を確認して Ubuntu を開き直す。
- [ ] **`make` と `git` をインストールする**（Ubuntu で実行。パスワードは手順で決めた Linux のもの）
  ```bash
  sudo apt update
  sudo apt install -y make git
  ```
- [ ] **コードを書くエディタを用意する（推奨: VS Code）**
  - https://code.visualstudio.com/ から VS Code をインストール
  - VS Code の拡張機能で「WSL」（Microsoft 製）をインストール
  - あとで Ubuntu のプロジェクトフォルダで `code .` と打つと、Ubuntu 側のファイルを VS Code で開ける

### 2. スマホとネットワークの準備

- [ ] 「[スマホの準備（Mac / Windows 共通）](#スマホの準備mac--windows-共通)」をやる
- [ ] **Wi-Fi を「プライベート ネットワーク」にする**（「パブリック」のままだとスマホから PC につながらない）
  - 「設定」→「ネットワークとインターネット」→「Wi-Fi」→ 接続中の Wi-Fi のプロパティ
  - 「ネットワーク プロファイルの種類」を **プライベート ネットワーク** にする

### 3. プロジェクトの準備

- [ ] **このフォルダを Ubuntu のホーム（`~`）に置く**（`C:\` の下には置かない）
  - git で管理している場合（Ubuntu で実行）
    ```bash
    cd ~
    git clone <このリポジトリの URL>
    ```
  - フォルダをもらった場合: Windows のダウンロードフォルダなどから Ubuntu にコピーする
    ```bash
    cp -r /mnt/c/Users/<Windowsのユーザー名>/Downloads/react-native-docker-template ~/
    ```
- [ ] **Ubuntu でこのフォルダに移動する**
  ```bash
  cd ~/react-native-docker-template
  ```
- [ ] **VS Code で開く**（任意）
  ```bash
  code .
  ```
  エクスプローラーで見たいときは、アドレス欄に `\\wsl$\Ubuntu\home\<Linuxのユーザー名>\react-native-docker-template` と入れる。
- [ ] **アプリ名を変える（任意）** → 「[アプリ名の変え方](#アプリ名の変え方任意)」

### 4. Docker イメージを作る

- [ ] **スマホの接続先になる IP が取れるか確認する**
  ```bash
  make ip
  ```
  - `HOST_IP=192.168.x.x` のように出れば OK
  - 「自動で取れませんでした」と出たら、Windows の IP を調べて `.env` に書く
    1. PowerShell で `ipconfig` を実行し、「Wireless LAN adapter Wi-Fi」の「IPv4 アドレス」を見る
    2. Ubuntu で `cp .env.example .env` し、`.env` の `HOST_IP=` をその IP に書き換える
- [ ] **イメージをビルドする**
  ```bash
  make build
  ```
  初回は Node.js 本体と依存パッケージをダウンロードするので数分かかる。最後に `Built` と出れば完了。

### 5. 初回の起動と確認

- [ ] 下の「B. 毎回やること」の **起動する** に進む
- [ ] **「Windows セキュリティの重要な警告」（ファイアウォール）が出たら「許可」を押す**
  - 「プライベート ネットワーク」にチェックが入っていることを確認する
  - ダイアログが出ずにスマホがつながらない場合: 「Windows セキュリティ」→「ファイアウォールとネットワーク保護」→「ファイアウォールによるアプリケーションの許可」で、Docker Desktop の「プライベート」にチェックを入れる

---

## Mac / Windows 共通の準備

### スマホの準備（Mac / Windows 共通）

- [ ] **Expo Go アプリをインストールする**
  - iPhone: App Store で「Expo Go」を検索
  - Android: Google Play で「Expo Go」を検索
- [ ] **スマホを PC と同じ Wi-Fi につなぐ**
  - モバイル回線（4G/5G）のままだとつながらない
  - 社内 Wi-Fi やゲスト Wi-Fi は、端末同士の通信が禁止されていてつながらないことがある。その場合は自宅の Wi-Fi やスマホのテザリング（PC をスマホのテザリングにつなぐ）で試す

### アプリ名の変え方（任意）

- [ ] `app.json` の `name`（ホーム画面に出る名前）と `slug`（英数字とハイフン）を書き換える
- [ ] `package.json` の `name` も同じ slug にそろえる

---

## B. 毎回やること

コマンドは、Mac は「ターミナル」、Windows は「Ubuntu」で打ちます。

### 起動する

- [ ] Docker Desktop が起動しているか確認する（Mac はメニューバー、Windows はタスクバー右下にクジラのアイコン）
- [ ] スマホと PC が同じ Wi-Fi にいるか確認する
- [ ] このフォルダに移動して起動する
  ```bash
  cd ~/Documents/GitHub/react-native-docker-template   # Mac の例
  cd ~/react-native-docker-template                    # Windows（Ubuntu）の例
  make up
  ```
- [ ] ターミナルに QR コードと `› Metro: exp://192.168.x.x:8081` が出るのを待つ
  - ここが `exp://127.0.0.1:8081` になっていたら、PC の IP が取れていない（下の「うまくつながらないとき」を見る）
- [ ] **スマホで QR コードを読む**
  - iPhone: 標準の「カメラ」アプリで QR を写し、出てきた通知をタップ → Expo Go で開く
  - Android: Expo Go アプリを開き「Scan QR code」で読む
- [ ] スマホに「React Native × TypeScript」とカウンターが表示されれば成功（初回の読み込みは 30 秒〜1 分ほどかかる）

### 開発する

- [ ] `App.tsx` を編集して保存する → スマホの画面が自動で更新される
- [ ] 更新されないときは、`make up` を実行しているターミナルで `r` を押す（アプリを再読み込み）
- [ ] 型チェックをする（起動中なら別のターミナルタブで）
  ```bash
  make typecheck
  ```

### 止める

- [ ] `make up` を実行しているターミナルで `Ctrl + C`
- [ ] 念のため後片付けをするなら
  ```bash
  make down
  ```

### パッケージを追加したとき

- [ ] SDK に合う版を入れる（`npm install` ではなくこちらを使う）
  ```bash
  make install PKG=パッケージ名
  ```
  例: `make install PKG=expo-router`
- [ ] `package.json` と `package-lock.json` が書き換わるので、そのままコミットする
- [ ] イメージにも反映するため、次回起動の前に `make build` する

### 他の人が追加したパッケージを取り込んだとき（`git pull` で `package.json` が変わったとき）

- [ ] 古い依存を消して、作り直す
  ```bash
  make clean
  make build
  ```
- [ ] いつもどおり `make up` で起動する

---

## コマンド一覧

| コマンド | いつ使う | 内容 |
| --- | --- | --- |
| `make ip` | 初回・つながらないとき | スマホの接続先になる PC の IP を表示 |
| `make build` | 初回・依存が変わったとき | Docker イメージを作る |
| `make up` | 毎回 | 開発サーバーを起動（QR コードが出る） |
| `make down` | 終わるとき | 止める |
| `make typecheck` | 随時 | 型チェック（`tsc --noEmit`） |
| `make install PKG=<名前>` | パッケージ追加時 | SDK に合う版を `expo install` で入れる |
| `make sh` | 調べものをするとき | コンテナに入る |
| `make clean` | 依存がおかしいとき | node_modules ボリュームを消す（次に `make build`） |

IP を手で指定したいときは `make up HOST_IP=192.168.x.x` のように渡せます（優先順: コマンドで指定 ＞ 自動取得 ＞ `.env` ＞ `127.0.0.1`）。

### make を使わない場合

PC の LAN 内 IP を `HOST_IP` として渡す必要があります。

```bash
cp .env.example .env          # .env の HOST_IP を自分の IP に書き換える
docker compose build
docker compose run --rm --service-ports app
```

---

## うまくつながらないとき

- **`exp://127.0.0.1:8081` と出る / スマホで読み込みが終わらない**
  - PC の IP が取れていない。`make ip` で確認する
  - 取れていなければ、IP を調べて `make up HOST_IP=192.168.x.x` で起動するか、`.env` に書く
    - Mac: `ipconfig getifaddr en0`（有線 LAN なら `en1`）
    - Windows: PowerShell で `ipconfig` →「Wireless LAN adapter Wi-Fi」の「IPv4 アドレス」
- **スマホで「Could not connect to the server」**
  - スマホと PC が同じ Wi-Fi か確認する
  - ファイアウォールで Docker の受信接続が許可されているか確認する（Mac / Windows それぞれの「5. 初回の起動と確認」）
  - Windows: Wi-Fi が「プライベート ネットワーク」になっているか確認する
  - 社内 Wi-Fi など端末間通信が禁止されたネットワークでは使えない
- **`Cannot connect to the Docker daemon` / `docker: command not found` と出る**
  - Docker Desktop が起動していない。アプリを開いてクジラのアイコンが出るまで待つ
  - Windows: Docker Desktop の「Settings」→「Resources」→「WSL integration」で Ubuntu がオンか確認する
- **`port is already allocated`（8081 が使用中）と出る**
  - 前回のコンテナが残っている。`make down` してから `make up`
- **Windows で、保存してもスマホの画面が更新されない**
  - プロジェクトが `C:\`（Ubuntu から見て `/mnt/c/...`）の下にある。Ubuntu のホーム（`~`）に置き直す
- **依存を入れ替えた後に動かない / 変なエラーが出る / `EACCES`（権限エラー）が出る**
  - `make clean` → `make build` → `make up`

---

## 構成

```
.
├── App.tsx          # 画面（ここを編集）
├── index.ts         # エントリーポイント
├── app.json         # Expo の設定（アプリ名・アイコン等）
├── assets/          # アイコン・スプラッシュ画像
├── tsconfig.json
├── Dockerfile       # Node 24 + npm ci（node ユーザーで実行）
├── compose.yaml     # 8081 番を公開、node_modules はボリュームで分離
└── Makefile         # Mac / Windows（WSL 2）の IP 自動取得つき
```

## このテンプレートでできないこと

- iOS / Android のネイティブビルド（`expo run:ios` / `expo run:android`）は Docker 内ではできません。ストア配布用のビルドは EAS Build を使ってください。
