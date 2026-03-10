# COMPONENT_LIST.md

Component List
Project: משתחררים (Mishtachrerim)

This document defines the UI component architecture of the product.

The goal is to keep the UI:

- modular
- reusable
- easy to maintain
- consistent across pages

All components should follow a **composition-based design**.

Components should be small, reusable, and focused.

---

# 1. Component Architecture Philosophy

Components should follow these principles:

Reusable  
Single responsibility  
Composable  

Avoid large monolithic components.

Prefer:

Small components combined into sections.

---

# 2. Component Categories

The UI components are divided into categories:

Layout Components  
Navigation Components  
Quiz Components  
Career Components  
Course Components  
Checklist Components  
Guide Components  
User Components  
Utility Components

---

# 3. Layout Components

These components define the global layout.

---

## AppLayout

Used across the entire site.

Responsibilities:

Header  
Footer  
Main content container

Example usage:

<AppLayout>
  Page content
</AppLayout>

---

## Container

Provides consistent page width.

Props:

children

Used in most pages.

---

## Section

Defines vertical spacing between page sections.

Props:

title  
children

Example:

<Section title="איך להתחיל">
  content
</Section>

---

# 4. Navigation Components

---

## Header

Top navigation bar.

Elements:

Logo  
Main navigation  
Quiz CTA  

Links:

Guides  
Careers  
Checklist  
Quiz

---

## Footer

Site footer.

Contains:

Important links  
Legal links  
Top guides

---

## Breadcrumbs

Used on:

Guide pages  
Career pages  
Course pages

Example:

Home
→ Careers
→ QA Tester

---

# 5. Quiz Components

Quiz is one of the core flows of the product.

---

## QuizStart

Intro screen before the quiz.

Elements:

Title  
Description  
Start button

---

## QuizQuestion

Displays a question.

Props:

questionText  
answers  
onSelect

---

## QuizAnswerOption

Clickable answer card.

Props:

text  
selected  
onClick

---

## QuizProgressBar

Shows quiz progress.

Example:

Question 3 / 10

---

## QuizResults

Displays the final results.

Shows:

Top 3 careers

---

## CareerResultCard

Displays a career recommendation.

Elements:

Career name  
Short description  
Salary range  
CTA

---

# 6. Career Components

Used in career pages.

---

## CareerHero

Top section of career page.

Elements:

Career title  
Short description  
Salary range

---

## CareerOverview

Explains what the job is.

---

## CareerFitSection

Explains who the career is suitable for.

Uses bullet list.

---

## CareerSalary

Displays salary range.

Important:

Must include disclaimer.

---

## CareerProsCons

Two-column layout.

Pros  
Cons

---

## CareerHowToStart

Explains ways to enter the field.

---

## CareerCoursesSection

Displays related courses.

Uses CourseCard components.

---

# 7. Course Components

---

## CourseCard

Displays course summary.

Elements:

Course name  
Provider  
Duration  
Learning mode  
Editorial rating  
CTA

---

## CourseHero

Top section of course page.

Displays key info.

---

## CourseDetails

Shows course description.

---

## CourseComparisonTable

Used in editorial pages.

Columns:

Course  
Duration  
Learning mode  
Difficulty  
Editorial rating

---

## CourseCTA

Displays conversion options.

Buttons:

View provider  
Leave details

---

# 8. Checklist Components

---

## ChecklistContainer

Main checklist wrapper.

---

## ChecklistItem

Single checklist item.

Elements:

Title  
Description  
Checkbox

---

## ChecklistProgress

Displays progress.

Example:

3 / 5 tasks completed

---

# 9. Guide Components

Used for SEO guides.

---

## GuideHero

Page title and intro.

---

## GuideSection

Content section.

Props:

title  
content

---

## GuideCTA

Inline CTA block.

Examples:

Start quiz  
View careers  
Open checklist

---

# 10. User Components

Used when user is logged in.

---

## SavedCareersList

Displays saved careers.

---

## SavedCoursesList

Displays saved courses.

---

## UserDashboard

Main dashboard layout.

---

# 11. Form Components

---

## LeadForm

Collects user contact information.

Fields:

Name  
Email  
Phone

---

## NewsletterSignup

Optional future feature.

---

# 12. Utility Components

---

## CTAButton

Reusable call-to-action button.

Variants:

primary  
secondary

---

## RatingBadge

Displays editorial rating.

Example:

4.2 / 5

---

## InfoBox

Used for disclaimers.

Example:

Salary disclaimer  
Affiliate disclosure

---

# 13. Component Folder Structure

Suggested structure:

/components

/layout
  AppLayout
  Header
  Footer
  Container
  Section

/navigation
  Breadcrumbs

/quiz
  QuizStart
  QuizQuestion
  QuizAnswerOption
  QuizProgressBar
  QuizResults

/career
  CareerHero
  CareerOverview
  CareerFitSection
  CareerSalary
  CareerProsCons
  CareerHowToStart
  CareerCoursesSection

/course
  CourseCard
  CourseHero
  CourseDetails
  CourseComparisonTable
  CourseCTA

/checklist
  ChecklistContainer
  ChecklistItem
  ChecklistProgress

/guides
  GuideHero
  GuideSection
  GuideCTA

/user
  SavedCareersList
  SavedCoursesList
  UserDashboard

/ui
  CTAButton
  RatingBadge
  InfoBox

---

# 14. Component Design Principles

Components must be:

Reusable  
Composable  
Stateless where possible

State should live higher in the tree.

---

# 15. Accessibility

Components should support:

Keyboard navigation  
ARIA labels  
Readable contrast

Accessibility improves UX and SEO.

---

# 16. Future Components

Potential future additions:

AI recommendation widget  
Career demand indicator  
Job examples section

These are not required for Phase 1.