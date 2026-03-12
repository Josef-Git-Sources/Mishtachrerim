'use client'

import type { ButtonHTMLAttributes } from 'react'

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary'
}

/**
 * Base button primitive.
 * Styling is intentionally minimal in Phase 1.
 * Replace with design system styles in Phase 2.
 */
export function Button({ variant = 'primary', children, ...props }: ButtonProps) {
  return (
    <button data-variant={variant} {...props}>
      {children}
    </button>
  )
}
