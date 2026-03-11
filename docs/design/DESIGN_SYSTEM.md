# DESIGN_SYSTEM.md

Design System
Project: משתחררים (Mishtachrerim)

This document defines the design system used across the product.

The goal is to ensure:

- visual consistency
- fast UI development
- reusable components
- clear hierarchy
- clean UX

The design should feel:

Modern  
Simple  
Trustworthy  
Professional  

The UI should resemble a **smart decision tool**, not a blog or marketing site.

---

# 1. Core Design Principles

The design must prioritize:

Clarity  
Readability  
Focus on decisions  
Minimal distraction  

Users should quickly understand:

What the page is about  
What they should do next  

Every page must have a clear CTA.

---

# 2. Layout Principles

The layout should be:

Clean  
Centered  
Easy to scan  

Use consistent page width.

Recommended container width:

max-width: 1100px

---

# 3. Spacing System

Spacing should follow a consistent scale.

Spacing scale:

4px  
8px  
16px  
24px  
32px  
48px  
64px

Common usage:

Small spacing → 8px  
Component spacing → 16px  
Section spacing → 48px  

---

# 4. Typography

Typography must prioritize readability.

---

## Primary Font

Recommended:

Inter

Fallback:

system-ui  
Arial

---

## Font Sizes

H1

36px  
Bold

Used for page titles.

---

H2

28px  
Semi-bold

Used for section headings.

---

H3

22px  
Semi-bold

Used for subsections.

---

Body text

16px  
Regular

Primary reading text.

---

Small text

14px

Used for disclaimers and metadata.

---

# 5. Color Palette

Colors should feel calm and trustworthy.

Avoid overly aggressive marketing colors.

---

## Primary Color

Blue

Example:

#2563EB

Used for:

Primary buttons  
Links  
Important highlights

---

## Secondary Color

Soft gray

Example:

#6B7280

Used for:

Secondary text  
Descriptions

---

## Background Color

White

#FFFFFF

---

## Section Background

Light gray

#F9FAFB

Used to separate page sections.

---

## Accent Color

Soft green

Example:

#10B981

Used for:

Success indicators  
Positive signals

---

## Warning Color

Example:

#F59E0B

Used for:

Disclaimers  
Important notes

---

# 6. Buttons

Buttons must be clear and visible.

---

## Primary Button

Used for main actions.

Examples:

Start Quiz  
View Courses

Style:

Blue background  
White text  
Rounded corners

Example:

padding: 12px 20px  
border-radius: 8px

---

## Secondary Button

Used for secondary actions.

Example:

View Guide  
Learn More

Style:

White background  
Blue border

---

# 7. Card Components

Cards are used for:

Career results  
Courses  
Guides

---

## Card Style

White background

Border:

1px solid #E5E7EB

Border radius:

10px

Padding:

20px

Shadow:

Soft shadow

Example:

box-shadow: 0 4px 10px rgba(0,0,0,0.05)

---

# 8. Career Result Card

Used on results page.

Content:

Career name  
Short description  
Salary range  
CTA

Layout:

Vertical card

---

# 9. Course Card

Content:

Course name  
Provider  
Duration  
Learning mode  
Editorial rating  
CTA

Cards should be consistent across all pages.

---

# 10. Section Headers

Each page section should include:

Title  
Short intro (optional)

Example:

איך להתחיל בתחום

Short intro:

יש כמה דרכים להתחיל לעבוד בתחום.

---

# 11. CTA Placement

Important CTAs should appear:

Above the fold  
After key sections  
At the bottom of pages

Examples:

Start quiz  
View career path  
View courses

---

# 12. Quiz Design

Quiz should feel:

Fast  
Clear  
Low friction  

Each screen should show:

One question  
4 answers  

Large clickable answer cards.

---

# 13. Progress Indicator

Quiz must include progress indicator.

Example:

Question 3 of 10

Or

Progress bar

---

# 14. Results Page Layout

Results page should highlight:

Top 3 careers.

Layout:

3 cards side-by-side (desktop)

Stacked cards (mobile)

Each card includes:

Career name  
Short explanation  
Salary range  
CTA

---

# 15. Checklist UI

Checklist items should include:

Checkbox  
Title  
Short explanation

Example layout:

[ ] Register with National Insurance  
Short explanation text

---

# 16. Tables

Tables should be used for:

Course comparison.

Columns example:

Course  
Duration  
Learning mode  
Difficulty  
Rating

Tables must be responsive.

---

# 17. Icons

Use icons sparingly.

Examples:

Checklist items  
Benefits  
Warnings

Avoid excessive decorative icons.

---

# 18. Disclaimers

Disclaimers must be visible but not intrusive.

Example content:

Salary estimates  
Affiliate disclosure

Style:

Light gray box  
Small text

---

# 19. Mobile Design

Mobile UX is critical.

Most users will arrive from mobile search.

Design rules:

Single-column layout  
Large touch targets  
Readable text

Buttons must be easy to tap.

---

# 20. Accessibility

Ensure accessibility basics.

Include:

Readable contrast  
Keyboard navigation  
Alt text for images

---

# 21. Animation

Use minimal animation.

Allowed:

Button hover  
Card hover  
Smooth transitions

Avoid heavy animations.

---

# 22. Design Consistency

All pages must follow the same visual rules.

This ensures:

Professional look  
User trust  
Fast development

---

# 23. Future Design Extensions

Possible additions:

Dark mode  
Advanced visual dashboards  
Interactive career comparisons

These are not required for Phase 1.