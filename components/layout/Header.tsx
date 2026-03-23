/**
 * Site header — rendered in the (public) layout.
 * Phase 12A: sticky header with logo + nav.
 * No hardcoded domain. No external URLs.
 */
import Link from 'next/link'

export function Header() {
  return (
    <header className="site-header">
      <div className="container">
        <Link href="/" className="site-logo">משתחררים</Link>
        <nav className="site-nav">
          <Link href="/guides">מדריכים</Link>
          <Link href="/career">מסלולים</Link>
          <Link href="/quiz">שאלון</Link>
          <Link href="/courses">קורסים</Link>
          <Link href="/checklist">צ׳קליסט</Link>
          <Link href="/dashboard">האזור שלי</Link>
        </nav>
      </div>
    </header>
  )
}
