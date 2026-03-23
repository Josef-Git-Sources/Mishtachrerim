/**
 * Public layout.
 * Wraps all public-facing pages with the site Header and Footer.
 * Pages in this group are indexed by search engines and statically generated.
 */
import { Header } from '@/components/layout/Header'
import { Footer } from '@/components/layout/Footer'

export default function PublicLayout({ children }: { children: React.ReactNode }) {
  return (
    <>
      <Header />
      <main className="page-main">{children}</main>
      <Footer />
    </>
  )
}
