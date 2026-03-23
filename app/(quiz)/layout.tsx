/**
 * Quiz layout.
 *
 * Minimal chrome — no full site nav — to keep users focused on the quiz flow.
 * No auth requirement: anonymous users can take the quiz and view results.
 *
 * Pages in this group:
 *   /quiz         quick quiz entry + flow
 *   /quiz/deep    deep quiz entry + flow
 *   /results/[id] result display (persistent, shareable)
 */
export default function QuizLayout({ children }: { children: React.ReactNode }) {
  return <main className="quiz-main">{children}</main>
}
