/**
 * Lead submission endpoint — POST /api/leads
 *
 * Receives and persists a lead form submission from a course detail page
 * or career page CTA.
 *
 * Phase 2 implementation steps:
 *   1. Parse and validate the request body (email, phone, name, source_page, course_id)
 *   2. Apply spam protection / rate limiting
 *   3. Insert a record into the leads table
 *   4. Optionally trigger a notification or CRM webhook
 *   5. Return { success: true }
 *
 * Phase 1: stub — returns 501.
 */
import { NextResponse } from 'next/server'

export async function POST() {
  // TODO Phase 2: implement lead submission
  return NextResponse.json(
    { error: 'Lead submission not yet implemented' },
    { status: 501 }
  )
}
