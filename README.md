# 🚄 Shinkansen Ghost: Advanced V2X Telemetry Gateway Pentest & Hardening Simulation
# 🚄 新幹線ゴースト：高度なV2Xテレメトリゲートウェイのペネトレーションテストおよび要塞化シミュレーション

## 🛡️ Project Domain Integration / プロジェクト領域の統合
*   **Industry Classification / 業界分類:** Smart Mobility / Automated Transport Infrastructure (Automotive Grid Emulation) / スマートモビリティ・自動輸送インフラ（自動車グリッドエミュレーション）
*   **Testing Core Framework / 検証フレームワーク:** Advanced OSCP Black-Box Methodology & Purple-Team Hardening Lifecycle / 高度OSCPブラックボックステスト手法＆パープルチーム・ハーデニング・ライフサイクル
*   **Target Laboratory Environment / 対象実験環境:** Isolated Kubernetes (k3s) Microservice Grid deployed on Rocky Linux Node / Rocky Linuxノード上に展開された隔離されたKubernetes (k3s) マイクロサービスグリッド

---

## 📝 Executive Summary & Operational Narrative / エグゼクティブサマリーと運用の概要

### English
Project **Shinkansen Ghost** simulates a comprehensive, inside-out security assessment targeting a critical **V2X (Vehicle-to-Everything) Telemetry Gateway** microservice. In an automated smart-mobility ecosystem, these edge applications parse high-speed telematics updates from autonomous transit units and roadside sensors.

Operating strictly under a **Black-Box Methodology**, this assessment evaluates the resilience of the innermost infrastructure layers under the assumption that external network perimeters have been tap-compromised. By chaining custom automation scripts, the project identifies an authentication bypass flaw on the web border, maps backend logical structures, uncovers a severe unhandled type-casting exception within the token validation matrix, and applies multi-layered Blue Team security mitigations to enforce zero-trust segmentation.

### 日本語
プロジェクト**「新幹線ゴースト」**は、重要な**V2X（Vehicle-to-Everything）テレメトリゲートウェイ**マイクロサービスを対象とした、包括的なインサイドアウト型セキュリティ評価をシミュレートするものである。自動化されたスマートモビリティのエコシステムにおいて、これらのエッジアプリケーションは、自動運転輸送ユニットや路側センサーからの高速テレマティクス更新を解析する。

本評価は、外部ネットワークの境界が盗聴（タップ）により侵害されたという想定のもと、厳格な**ブラックボックス手法**に基づいて最インフラ層の弾力性を検証する。カスタム自動化スクリプトを連鎖させることで、Web境界における認証バイパスの欠陥を特定し、バックエンドの論理構造をマッピングした。さらに、トークン検証マトリクス内の深刻な未処理の型キャスト例外を明らかにし、ゼロトラストセグメンテーションを強制する多層的なブルーチームセキュリティ緩和策を適用した。

---

## 🛠️ Systemic Repository Tree Architecture / リポジトリのシステム構成ツリー
```text
shinkansen-ghost/
├── .github/
│   └── workflows/
│       └── pipeline-audit.yaml     # DevSecOps workflow template
├── attack-node/
│   └── probe.sh                    # Custom Bash reconnaissance utility
├── defense-node/
│   ├── host-firewall-rules.sh      # Sōteigai no haiju automation script
│   └── telemetry-security-policy.yaml # Kubernetes NetworkPolicy manifest
└── README.md                       # Comprehensive engineering report
```

---

> ⚠️ **Environment Configuration Note / 環境設定に関する注意:**
> The IP addresses utilized in this documentation (`192.168.1.168` for the target server and `192.168.1.15` for the attack node) are mapped to a specific local subnet architecture. External operators reproducing this simulation must substitute these coordinates with their own local node interface IP strings.
> （本ドキュメントで使用されているIPアドレス（ターゲットサーバーの`192.168.1.168`および攻撃ノードの`192.168.1.15`）は、特定のローカルサブネット構成にマッピングされています。このシミュレーションを再現する外部のオペレータは、これらの座標をご自身のローカルノードのインターフェースIP文字列に置き換える必要があります。）


## 📊 Phase-by-Phase Technical Breakdown / フェーズごとの技術的解説

### Phase 1: Reconnaissance & Structural Boundary Mapping / フェーズ1：偵察と構造境界のマッピング
*   **English:** The attack node initiated systematic perimeter probing targeting the containerized gateway service on NodePort `30085`. Manual header analysis and automated verb testing revealed an insecure verb handling configuration. The target path returned an HTTP `405 Method Not Allowed` header while explicitly leaking allowed operational communication options: `Allow: GET, OPTIONS, HEAD`.
*   **日本語:** 攻撃ノードは、NodePort `30085`上のコンテナ化されたゲートウェイサービスを対象に、系統的な境界プロービングを開始した。手動によるヘッダー分析と自動化された動詞（メソッド）テストにより、不安全なHTTPメソッド処理構成が判明した。対象のパスはHTTP `405 Method Not Allowed`を返したものの、許可された運用通信オプションである `Allow: GET, OPTIONS, HEAD` を明示的に漏洩していた。
*   **Engineering Rationale / 技術的根拠:** Exploiting the `OPTIONS` request pattern allows a black-box tester to query the server's communication parameters directly without a session pass, as web developers frequently leave this configuration path unauthenticated to allow browsers to read API parameters freely. / `OPTIONS`リクエストパターンを悪用することで、ブラックボックステスターはセッションパスなしでサーバーの通信パラメータを直接クエリできる。これは、Web開発者がブラウザにAPIパラメータを自由に読み取らせるために、この設定パスを未認証のまま残すことが多いためである。

### Phase 2: Authentication Gate Bypass / フェーズ2：認証ゲートのバイパス
*   **English:** Using custom Bash automation engines, the attack node executed a targeted `POST` request delivering an empty JSON structure (`{}`) to the `/v1/auth/guest-token` path. Because the backend logic lacked strict input parameters validation and failed to enforce cryptographic authentication boundaries, it blindly accepted the blank request and generated a signed **JSON Web Token (JWT)** string mapping us to a low-privileged `guest_rider` status profile.
*   **日本語:** カスタムのBash自動化エンジンを使用して、攻撃ノードは `/v1/auth/guest-token` パスに対して空のJSON構造（ `{}` ）を送信する標的型 `POST` リクエストを実行した。バックエンドのロジックに厳格な入力パラメータの検証が欠落しており、暗号認証境界を強制できなかったため、システムは空のリクエストを盲目的に受け入れ、低権限の `guest_rider` ステータスプロファイルにマッピングされた署名付きの**JSON Web Token (JWT)** 文字列を生成した。

### Phase 3: Root Cause Investigation — Cryptographic Type Crash / フェーズ3：根本原因の究明 — 暗号型クラッシュ
*   **Japanese Engineering Concept:** **根本原因の究明 (*Konpon gen-in no kyūmei*)** — Root Cause Investigation (The "5 Whys") / 根本原因の究明（5つのなぜ）。
*   **English:** To evaluate privilege boundaries, the token payload claims were extracted and decoded using a custom Linux piping conveyor pipeline (`echo "<payload>" | base64 -d`), exposing the structural permission keys: `{"user":"guest_rider","role":"rider"}`. Attempting to feed this token into the protected `/v1/telemetry/999` and `/v1/intersection/emergency-override` paths triggered a strict HTTP `403 FORBIDDEN` crash containing an unhandled Python backend exception error string: `{"error":"Invalid token type. Token must be a <class 'bytes'> "}`.
*   **日本語:** 権限境界を評価するため、カスタムのLinuxパイピングコンベアライン（ `echo "<payload>" | base64 -d` ）を使用してトークンのペイロードクレームを抽出し、デコードした。これにより、構造的な権限キー `{"user":"guest_rider","role":"rider"}` が露出した。このトークンを保護された `/v1/telemetry/999` および `/v1/intersection/emergency-override` パスに投入しようとしたところ、未処理のPythonバックエンド例外エラー文字列を含む厳格なHTTP `403 FORBIDDEN` クラッシュがトリガーされた： `{"error":"Invalid token type. Token must be a <class 'bytes'> "}` 。
*   **Technical Rationale / 技術的根拠:** The application code suffers from an unhandled data-type validation exception. In modern Python 3, cryptographic verification libraries require verification keys and token inputs to be handled strictly as raw binary data (`bytes`). Because the web gateway parsed the inbound header data directly as a standard text string, the internal token parser panicked, rendering the path completely inaccessible to any remote operator over the network. / アプリケーションコードに未処理のデータ型検証例外が存在する。現代のPython 3では、暗号検証ライブラリは検証キーとトークン入力を厳格に生のバイナリデータ（ `bytes` ）として処理することを要求する。Webゲートウェイがインバウンドのヘッダーデータを標準のテキスト文字列として直接解析したため、内部のトークンパーサーがパニックを起こし、ネットワーク上の正当なリモートオペレータであってもパスに完全にアクセスできない状態になっていた。

---

## 🛡️ Blue Team Hardening & Microsector Isolation / ブルーチームの要塞化とマイクロセクターの隔離

### 1. Enforcing Perimeter Guarding / 1. 境界防御の強化
*   **Japanese Engineering Concept:** **想定外の排除 (*Sōteigai no haiju*)** — Eliminating the Unexpected / 想定外の排除。
*   **English:** To isolate the broken application from unmanaged network tapping, host-level firewall access control lists (ACLs) were burned permanently into the Rocky Linux interface layer using `firewalld`. This rich-rule enforces a strict whitelist policy that drops all inbound packets hitting port `30085` unless they explicitly originate from the authorized attack node IP address (`192.168.1.15`).
*   **日本語:** 破損したアプリケーションを管理外のネットワーク盗聴から隔離するため、 `firewalld` を使用してホストレベルのファイアウォールアクセス制御リスト（ACL）をRocky Linuxのインターフェース層に永久的に書き込んだ。このリッチルールは、承認された攻撃ノードのIPアドレス（ `192.168.1.15` ）から明示的に送信されたものでない限り、ポート `30085` にヒットするすべてのインバウンドパケットを破棄する厳格なホワイトリストポリシーを強制する。

```bash
# host-firewall-rules.sh
sudo firewall-cmd --permanent --zone=public --add-rich-rule='
rule family="ipv4" 
source address="192.168.1.15" 
port protocol="tcp" port="30085" 
accept'
sudo firewall-cmd --reload
```

### 2. Autonomous Zero-Trust Container Segmentation / 2. 自律的なゼロトラストコンテナセグメンテーション
*   **Japanese Engineering Concept:** **自律・分散・協調 (*Jiritsu, Bunsan, Kyōchō*)** — Autonomous, Distributed, Coordinated Infrastructure Resilience / 自律・分散・協調。
*   **English:** To protect the internal cluster mesh from lateral movement if an edge boundary falls, a declarative Kubernetes NetworkPolicy manifest was deployed inside `k3s`. This policy shifts the microservice container to a default-drop stance, allowing network entry strictly if traffic originates from an explicitly trusted proxy broker pod on an isolated internal gateway port.
*   **日本語:** エッジの境界が破られた場合に内部クラスターメッシュ内での横移動（ラテラルムーブメント）を防ぐため、宣言的なKubernetes NetworkPolicyマニフェストを `k3s` 内部にデプロイした。このポリシーは、マイクロサービスコンテナをデフォルトドロップ（拒否）のスタンスに移行させ、隔離された内部ゲートウェイポート上の明示的に信頼されたプロキシブローカーポッドからトラフィックが送信された場合にのみ、ネットワークへの侵入を許可する。

```yaml
# defense-node/telemetry-security-policy.yaml
apiVersion: networking.k3s.io/v1
kind: NetworkPolicy
metadata:
  name: isolate-v2x-telemetry
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: v2x-telemetry-gateway
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: internal-broker-proxy
    ports:
    - protocol: TCP
      port: 8085
```

---

## 📈 Final Validation Metrics & Verification Records / 最終検証メトリクスと検証ログ
*   **Japanese Engineering Concept:** **異常検知の即時性 (*Ijō kenchi no sokujisei*)** — Immediacy of Anomaly Detection / 異常検知の即時性。
*   **English:** Executing the final `./probe.sh` script automation loop from the authorized Chromebook interface (`192.168.1.15`) verified that authorized traffic routes cleanly through the firewall layer while alternative uninvited network addresses hit silent packet drops instantly. Real-time data telemetry monitoring spikes were tracked and validated with zero visibility lag via the **Netdata Embedded Engine Dashboard** on host management port `19999`, confirming complete administrative control over the cluster interface profile.
