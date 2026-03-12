/**
 * Root layout.
 *
 * Wraps the entire application. Sets the HTML lang and dir attributes
 * for the Hebrew-language platform. All other layouts nest inside this one.
 *
 * Title template: page titles will render as "Page Title | משתחררים".
 * Metadata description is a site-wide default; individual pages override it.
 */
import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: {
    default: 'משתחררים',
    template: '%s | משתחררים',
  },
  description: 'פלטפורמת קריירה למשתחררי צבא — גלה את הכיוון המקצועי שלך',
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="he" dir="rtl">
      <body>{children}</body>
    </html>
  )
}
