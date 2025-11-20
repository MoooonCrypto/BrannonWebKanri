# 万能ウェブ管理ツール

LP構築とSNS管理を一元管理できるオールインワンプラットフォーム

## 🚀 プロジェクト概要

個人事業主・副業者向けの、LP構築とSNS管理を1つのツールで完結できるシンプルなウェブ管理ツールです。

### ターゲット
- 個人事業主（ネイルサロン、カフェ、コンサル等）
- 副業を始めたばかりの会社員
- フリーランス（デザイナー、ライター、コーチ等）

### 提供価値
- **時間節約**: 複数ツールの学習・管理時間を削減
- **コスト削減**: 複数サブスクを1つに統合（月額8,000円 → 2,000円想定）
- **簡単さ**: 5分でLP公開、10分でSNS予約投稿

## 📋 現在の実装状況

### ✅ 完了
- [x] Phase 1: 市場調査・競合分析
- [x] Phase 2: 機能設計とユーザーフロー定義
- [x] Phase 3: 技術スタック選定
- [x] Phase 4: データベース設計
- [x] Phase 5-1: Next.jsプロジェクト初期化
- [x] Phase 5-2: Supabase設定
- [x] Phase 5-3: マイグレーションSQL作成
- [x] Phase 5-4: 認証ページ実装
- [x] Phase 5-5: 認証Server Actions実装
- [x] Phase 5-6: ダッシュボード基礎実装

### 🚧 次のステップ（MVP完成まで）
- [ ] Phase 5-7: LP構築機能実装
  - LP一覧・作成・編集・削除
  - テンプレート選択
  - シンプルなビルダー
  - 公開/非公開切り替え
- [ ] Phase 5-8: SNS管理機能実装
  - Twitter/X連携
  - 予約投稿機能
  - 投稿カレンダー
- [ ] Phase 5-9: メディアライブラリ実装
  - 画像アップロード
  - 画像一覧表示
- [ ] Phase 5-10: UI/UX改善とレスポンシブ対応
- [ ] Phase 6: デプロイ準備とドキュメント整備
- [ ] Phase 7: ローンチ準備

## 🛠 技術スタック

| カテゴリ | 技術 |
|---------|------|
| フロントエンド | Next.js 14 (App Router)、React、TypeScript |
| バックエンド | Next.js Server Actions |
| データベース | Supabase (PostgreSQL) |
| 認証 | Supabase Auth |
| ストレージ | Supabase Storage |
| スタイリング | Tailwind CSS、shadcn/ui風コンポーネント |
| 状態管理 | Zustand（予定） |
| フォーム | React Hook Form + Zod（予定） |
| デプロイ | Vercel |

## 📁 プロジェクト構造

```
BrannonWebKanri/
├── docs/                          # ドキュメント
│   ├── 01_competitive_analysis.md # 競合分析
│   ├── 02_feature_design.md       # 機能設計
│   ├── 03_tech_stack.md           # 技術スタック
│   └── 04_database_design.md      # データベース設計
├── app/                           # Next.js App Router
│   ├── (auth)/                    # 認証関連
│   │   ├── login/
│   │   └── signup/
│   ├── (dashboard)/               # ダッシュボード（認証必須）
│   │   ├── dashboard/
│   │   ├── lp/                    # LP管理（実装予定）
│   │   ├── social/                # SNS管理（実装予定）
│   │   ├── media/                 # メディア（実装予定）
│   │   └── settings/              # 設定（実装予定）
│   └── layout.tsx
├── components/                    # Reactコンポーネント
│   └── ui/                        # UIコンポーネント
├── lib/                           # ライブラリ・設定
│   ├── supabase/                  # Supabaseクライアント
│   └── utils.ts
├── actions/                       # Server Actions
│   └── auth.ts
├── supabase/                      # Supabase設定
│   └── migrations/                # DBマイグレーション
└── types/                         # TypeScript型定義（予定）
```

## 🚀 セットアップ方法

### 前提条件
- Node.js 18.17+
- pnpm 8.10+
- Supabaseアカウント

### 手順

#### 1. リポジトリクローン
```bash
git clone <repository-url>
cd BrannonWebKanri
```

#### 2. 依存関係インストール
```bash
pnpm install
```

#### 3. Supabaseプロジェクト作成
1. [Supabase](https://supabase.com/)でプロジェクト作成
2. SQL Editorで以下を実行:
   ```bash
   # supabase/migrations/001_initial_schema.sql の内容をコピー&実行
   ```

#### 4. 環境変数設定
`.env.example`を`.env.local`にコピーして編集:
```bash
cp .env.example .env.local
```

以下を設定:
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

#### 5. 開発サーバー起動
```bash
pnpm dev
```

http://localhost:3000 でアクセス可能

## 📝 開発コマンド

```bash
# 開発サーバー起動
pnpm dev

# ビルド
pnpm build

# 本番環境起動
pnpm start

# 型チェック
pnpm type-check

# リント
pnpm lint

# フォーマット
pnpm format
```

## 🎯 MVP機能（予定）

### LP構築機能
- [x] LP一覧表示（実装予定）
- [x] LP作成・編集・削除（実装予定）
- [x] テンプレート選択（5種類）（実装予定）
- [x] シンプルなビルダー（実装予定）
- [x] 公開/非公開切り替え（実装予定）

### SNS管理機能
- [x] Twitter/X連携（実装予定）
- [x] 予約投稿（実装予定）
- [x] 投稿カレンダー（実装予定）
- [x] 投稿履歴（実装予定）

### その他
- [x] メディアライブラリ（実装予定）
- [x] プロフィール設定（実装予定）
- [x] ダッシュボード（✅ 基礎実装済み）

## 📚 ドキュメント

詳細な設計ドキュメントは`/docs`ディレクトリにあります：
- [01_competitive_analysis.md](docs/01_competitive_analysis.md) - 競合分析表
- [02_feature_design.md](docs/02_feature_design.md) - 機能一覧とユーザーフロー
- [03_tech_stack.md](docs/03_tech_stack.md) - 技術スタック構成
- [04_database_design.md](docs/04_database_design.md) - データベース設計

## 🔐 セキュリティ

- Supabase Row Level Security (RLS) 有効化
- Server Actions使用（CSRF保護）
- 環境変数は`.env.local`で管理（`.gitignore`に含む）

## 📄 ライセンス

（ライセンスを追加予定）

## 👨‍💻 開発者

（開発者情報を追加予定）

---

**作成日**: 2025-11-20
**最終更新**: 2025-11-20
