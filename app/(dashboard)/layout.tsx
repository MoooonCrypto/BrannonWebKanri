import { redirect } from 'next/navigation'
import { getUser, logout } from '@/actions/auth'
import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const user = await getUser()

  if (!user) {
    redirect('/login')
  }

  return (
    <div className="flex min-h-screen bg-gray-50">
      {/* Sidebar */}
      <aside className="w-64 bg-white border-r">
        <div className="p-6">
          <h1 className="text-xl font-bold">万能ウェブ管理ツール</h1>
        </div>
        <nav className="px-4 space-y-2">
          <Link
            href="/dashboard"
            className="block px-4 py-2 rounded hover:bg-gray-100"
          >
            ダッシュボード
          </Link>
          <Link
            href="/lp"
            className="block px-4 py-2 rounded hover:bg-gray-100"
          >
            LP管理
          </Link>
          <Link
            href="/social"
            className="block px-4 py-2 rounded hover:bg-gray-100"
          >
            SNS管理
          </Link>
          <Link
            href="/media"
            className="block px-4 py-2 rounded hover:bg-gray-100"
          >
            メディア
          </Link>
          <Link
            href="/settings"
            className="block px-4 py-2 rounded hover:bg-gray-100"
          >
            設定
          </Link>
        </nav>
        <div className="absolute bottom-0 w-64 p-4 border-t">
          <div className="text-sm text-gray-600 mb-2">{user.email}</div>
          <form action={logout}>
            <Button variant="outline" size="sm" className="w-full">
              ログアウト
            </Button>
          </form>
        </div>
      </aside>

      {/* Main Content */}
      <main className="flex-1 p-8">{children}</main>
    </div>
  )
}
