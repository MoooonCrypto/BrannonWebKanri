export default function HomePage() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center p-24">
      <h1 className="text-4xl font-bold mb-4">万能ウェブ管理ツール</h1>
      <p className="text-xl text-muted-foreground mb-8">
        LP構築とSNS管理を一元管理
      </p>
      <div className="flex gap-4">
        <a
          href="/login"
          className="px-6 py-3 bg-primary text-primary-foreground rounded-lg font-medium hover:opacity-90 transition-opacity"
        >
          ログイン
        </a>
        <a
          href="/signup"
          className="px-6 py-3 bg-secondary text-secondary-foreground rounded-lg font-medium hover:opacity-90 transition-opacity"
        >
          新規登録
        </a>
      </div>
    </div>
  )
}
