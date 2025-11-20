-- UUID拡張を有効化
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ======================================
-- 1. profiles テーブル
-- ======================================
CREATE TABLE profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name TEXT,
  avatar_url TEXT,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザーは自分のプロフィールのみ閲覧可能"
ON profiles FOR SELECT USING (auth.uid() = id);

CREATE POLICY "ユーザーは自分のプロフィールのみ更新可能"
ON profiles FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "ユーザーは自分のプロフィールを作成可能"
ON profiles FOR INSERT WITH CHECK (auth.uid() = id);

-- ======================================
-- 2. landing_pages テーブル
-- ======================================
CREATE TABLE landing_pages (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  slug TEXT NOT NULL,
  settings JSONB NOT NULL DEFAULT '{}'::jsonb,
  is_published BOOLEAN NOT NULL DEFAULT false,
  published_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, slug)
);

CREATE INDEX idx_landing_pages_user_id ON landing_pages(user_id);
CREATE INDEX idx_landing_pages_slug ON landing_pages(slug);
CREATE INDEX idx_landing_pages_is_published ON landing_pages(is_published);
CREATE INDEX idx_landing_pages_user_id_slug ON landing_pages(user_id, slug);

ALTER TABLE landing_pages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザーは自分のLPのみ閲覧可能"
ON landing_pages FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "公開LPは誰でも閲覧可能"
ON landing_pages FOR SELECT USING (is_published = true);

CREATE POLICY "ユーザーは自分のLPを作成可能"
ON landing_pages FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のLPのみ更新可能"
ON landing_pages FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のLPのみ削除可能"
ON landing_pages FOR DELETE USING (auth.uid() = user_id);

-- ======================================
-- 3. lp_sections テーブル
-- ======================================
CREATE TABLE lp_sections (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  landing_page_id UUID NOT NULL REFERENCES landing_pages(id) ON DELETE CASCADE,
  section_type TEXT NOT NULL,
  order_index INTEGER NOT NULL,
  content JSONB NOT NULL DEFAULT '{}'::jsonb,
  styles JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (landing_page_id, order_index)
);

CREATE INDEX idx_lp_sections_landing_page_id ON lp_sections(landing_page_id);
CREATE INDEX idx_lp_sections_landing_page_id_order ON lp_sections(landing_page_id, order_index);

ALTER TABLE lp_sections ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザーは自分のLPのセクションのみ閲覧可能"
ON lp_sections FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM landing_pages
    WHERE landing_pages.id = lp_sections.landing_page_id
    AND landing_pages.user_id = auth.uid()
  )
);

CREATE POLICY "公開LPのセクションは誰でも閲覧可能"
ON lp_sections FOR SELECT
USING (
  EXISTS (
    SELECT 1 FROM landing_pages
    WHERE landing_pages.id = lp_sections.landing_page_id
    AND landing_pages.is_published = true
  )
);

CREATE POLICY "ユーザーは自分のLPのセクションを作成可能"
ON lp_sections FOR INSERT
WITH CHECK (
  EXISTS (
    SELECT 1 FROM landing_pages
    WHERE landing_pages.id = lp_sections.landing_page_id
    AND landing_pages.user_id = auth.uid()
  )
);

CREATE POLICY "ユーザーは自分のLPのセクションのみ更新可能"
ON lp_sections FOR UPDATE
USING (
  EXISTS (
    SELECT 1 FROM landing_pages
    WHERE landing_pages.id = lp_sections.landing_page_id
    AND landing_pages.user_id = auth.uid()
  )
);

CREATE POLICY "ユーザーは自分のLPのセクションのみ削除可能"
ON lp_sections FOR DELETE
USING (
  EXISTS (
    SELECT 1 FROM landing_pages
    WHERE landing_pages.id = lp_sections.landing_page_id
    AND landing_pages.user_id = auth.uid()
  )
);

-- ======================================
-- 4. social_accounts テーブル
-- ======================================
CREATE TABLE social_accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  platform TEXT NOT NULL,
  account_id TEXT NOT NULL,
  account_name TEXT NOT NULL,
  account_username TEXT,
  access_token TEXT NOT NULL,
  refresh_token TEXT,
  token_expires_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (user_id, platform, account_id)
);

CREATE INDEX idx_social_accounts_user_id ON social_accounts(user_id);
CREATE INDEX idx_social_accounts_platform ON social_accounts(platform);

ALTER TABLE social_accounts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザーは自分のSNSアカウントのみ閲覧可能"
ON social_accounts FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のSNSアカウントを作成可能"
ON social_accounts FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のSNSアカウントのみ更新可能"
ON social_accounts FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のSNSアカウントのみ削除可能"
ON social_accounts FOR DELETE USING (auth.uid() = user_id);

-- ======================================
-- 5. social_posts テーブル
-- ======================================
CREATE TABLE social_posts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  social_account_id UUID NOT NULL REFERENCES social_accounts(id) ON DELETE CASCADE,
  status TEXT NOT NULL DEFAULT 'draft',
  content TEXT NOT NULL,
  media_urls JSONB NOT NULL DEFAULT '[]'::jsonb,
  scheduled_at TIMESTAMPTZ,
  published_at TIMESTAMPTZ,
  external_id TEXT,
  metrics JSONB,
  error_message TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_social_posts_user_id ON social_posts(user_id);
CREATE INDEX idx_social_posts_social_account_id ON social_posts(social_account_id);
CREATE INDEX idx_social_posts_status ON social_posts(status);
CREATE INDEX idx_social_posts_scheduled_at ON social_posts(scheduled_at) WHERE status = 'scheduled';
CREATE INDEX idx_social_posts_user_id_status ON social_posts(user_id, status);

ALTER TABLE social_posts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザーは自分の投稿のみ閲覧可能"
ON social_posts FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分の投稿を作成可能"
ON social_posts FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分の投稿のみ更新可能"
ON social_posts FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分の投稿のみ削除可能"
ON social_posts FOR DELETE USING (auth.uid() = user_id);

-- ======================================
-- 6. media テーブル
-- ======================================
CREATE TABLE media (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  file_name TEXT NOT NULL,
  file_path TEXT NOT NULL,
  file_type TEXT NOT NULL,
  file_size INTEGER NOT NULL,
  width INTEGER,
  height INTEGER,
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_media_user_id ON media(user_id);
CREATE INDEX idx_media_file_type ON media(file_type);

ALTER TABLE media ENABLE ROW LEVEL SECURITY;

CREATE POLICY "ユーザーは自分のメディアのみ閲覧可能"
ON media FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のメディアを作成可能"
ON media FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "ユーザーは自分のメディアのみ削除可能"
ON media FOR DELETE USING (auth.uid() = user_id);

-- ======================================
-- トリガー: updated_at自動更新
-- ======================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at
BEFORE UPDATE ON profiles
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_landing_pages_updated_at
BEFORE UPDATE ON landing_pages
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lp_sections_updated_at
BEFORE UPDATE ON lp_sections
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_social_accounts_updated_at
BEFORE UPDATE ON social_accounts
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_social_posts_updated_at
BEFORE UPDATE ON social_posts
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();

-- ======================================
-- トリガー: 新規ユーザー登録時にプロフィール自動作成
-- ======================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, avatar_url, updated_at)
  VALUES (
    NEW.id,
    NEW.raw_user_meta_data->>'full_name',
    NEW.raw_user_meta_data->>'avatar_url',
    NOW()
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE FUNCTION public.handle_new_user();
