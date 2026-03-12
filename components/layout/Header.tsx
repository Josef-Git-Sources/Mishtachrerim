/**
 * Site header — rendered in the (public) layout.
 * Phase 1: minimal navigation skeleton with relative internal links.
 * No hardcoded domain. No external URLs.
 */
import Link from 'next/link'

export function Header() {
  return (
    <header>
      <nav>
        <Link href="/">משתחררים</Link>
        <Link href="/guides">מדריכים</Link>
        <Link href="/career">מסלולים</Link>
        <Link href="/quiz">שאלון</Link>
        <Link href="/courses">קורסים</Link>
        <Link href="/checklist">צ׳קליסט</Link>
        <Link href="/dashboard">האזור שלי</Link>
      </nav>
    </header>
  )
}
