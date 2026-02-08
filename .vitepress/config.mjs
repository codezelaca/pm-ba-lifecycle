import { defineConfig } from "vitepress";
import { withMermaid } from "vitepress-plugin-mermaid";

// SEO and Branding Configuration
const SITE_URL = "https://codezelaca.github.io/pm-ba-lifecycle";
const SITE_TITLE = "PM & BA Lifecycle";
const SITE_DESCRIPTION =
  "Complete Learning Resource for Product Management and Business Analysis by Codezela Career Accelerator";
const BRAND = "Codezela Career Accelerator";

export default withMermaid(
  defineConfig({
    title: SITE_TITLE,
    description: SITE_DESCRIPTION,

    // GitHub Pages base path
    base: "/pm-ba-lifecycle/",

    // Clean URLs
    cleanUrls: true,

    // Last updated timestamps
    lastUpdated: true,

    // Sitemap generation for SEO
    sitemap: {
      hostname: SITE_URL,
    },

    // Head tags - SEO, Favicon, Open Graph, Twitter Cards
    head: [
      // Favicon
      [
        "link",
        {
          rel: "icon",
          type: "image/png",
          sizes: "32x32",
          href: "/pm-ba-lifecycle/logo.png",
        },
      ],
      [
        "link",
        {
          rel: "icon",
          type: "image/png",
          sizes: "16x16",
          href: "/pm-ba-lifecycle/logo.png",
        },
      ],
      [
        "link",
        {
          rel: "apple-touch-icon",
          sizes: "180x180",
          href: "/pm-ba-lifecycle/logo.png",
        },
      ],

      // Theme color
      ["meta", { name: "theme-color", content: "#3b82f6" }],
      ["meta", { name: "msapplication-TileColor", content: "#3b82f6" }],

      // SEO Meta Tags
      ["meta", { name: "author", content: BRAND }],
      ["meta", { name: "robots", content: "index, follow" }],
      ["meta", { name: "googlebot", content: "index, follow" }],
      [
        "meta",
        {
          name: "keywords",
          content:
            "product management, business analysis, PM, BA, agile, scrum, requirements engineering, user stories, portfolio, career, learning, BABOK, product owner",
        },
      ],

      // Open Graph (Facebook, LinkedIn)
      ["meta", { property: "og:type", content: "website" }],
      [
        "meta",
        { property: "og:site_name", content: `${SITE_TITLE} | ${BRAND}` },
      ],
      ["meta", { property: "og:title", content: SITE_TITLE }],
      ["meta", { property: "og:description", content: SITE_DESCRIPTION }],
      ["meta", { property: "og:url", content: SITE_URL }],
      ["meta", { property: "og:image", content: `${SITE_URL}/logo.png` }],
      ["meta", { property: "og:image:width", content: "512" }],
      ["meta", { property: "og:image:height", content: "512" }],
      ["meta", { property: "og:locale", content: "en_US" }],

      // Twitter Card
      ["meta", { name: "twitter:card", content: "summary_large_image" }],
      ["meta", { name: "twitter:title", content: SITE_TITLE }],
      ["meta", { name: "twitter:description", content: SITE_DESCRIPTION }],
      ["meta", { name: "twitter:image", content: `${SITE_URL}/logo.png` }],

      // Canonical URL
      ["link", { rel: "canonical", href: SITE_URL }],

      // Preconnect for performance
      ["link", { rel: "preconnect", href: "https://fonts.googleapis.com" }],
      [
        "link",
        {
          rel: "preconnect",
          href: "https://fonts.gstatic.com",
          crossorigin: "",
        },
      ],

      // Google Fonts - Inter for modern look
      [
        "link",
        {
          href: "https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap",
          rel: "stylesheet",
        },
      ],

      // JSON-LD Structured Data for SEO
      [
        "script",
        { type: "application/ld+json" },
        JSON.stringify({
          "@context": "https://schema.org",
          "@type": "WebSite",
          name: SITE_TITLE,
          description: SITE_DESCRIPTION,
          url: SITE_URL,
          publisher: {
            "@type": "Organization",
            name: BRAND,
            logo: {
              "@type": "ImageObject",
              url: `${SITE_URL}/logo.png`,
            },
          },
          potentialAction: {
            "@type": "SearchAction",
            target: `${SITE_URL}/?search={search_term_string}`,
            "query-input": "required name=search_term_string",
          },
        }),
      ],

      // Educational Course structured data
      [
        "script",
        { type: "application/ld+json" },
        JSON.stringify({
          "@context": "https://schema.org",
          "@type": "Course",
          name: "PM & BA Lifecycle Complete Learning Resource",
          description:
            "Comprehensive curriculum covering Product Management and Business Analysis from fundamentals to portfolio-ready skills",
          provider: {
            "@type": "Organization",
            name: BRAND,
          },
          educationalLevel: "Beginner to Advanced",
          isAccessibleForFree: true,
          teaches: [
            "Requirements Engineering",
            "Agile Methodology",
            "Business Analysis",
            "Product Management",
            "Data Analytics",
            "Technical Fluency",
          ],
        }),
      ],
    ],

    // Theme configuration
    themeConfig: {
      logo: "/logo.png",
      siteTitle: "PM & BA Lifecycle",

      // Navigation bar
      nav: [
        { text: "Home", link: "/" },
        { text: "Curriculum", link: "/01-curriculum/" },
        { text: "ReserveEasy", link: "/02-reserve-easy-project/" },
        { text: "Toolkit", link: "/03-toolkit/" },
        { text: "Career", link: "/04-career-portfolio/" },
        {
          text: "Resources",
          items: [
            { text: "Learning Paths", link: "/01-curriculum/learning-paths" },
            { text: "Glossary", link: "/glossary" },
            { text: "Exercises", link: "/exercises" },
            { text: "External Resources", link: "/resources" },
          ],
        },
      ],

      // Sidebar configuration
      sidebar: {
        "/": [
          {
            text: "🏠 Getting Started",
            items: [
              { text: "Introduction", link: "/" },
              { text: "Learning Paths", link: "/01-curriculum/learning-paths" },
              { text: "Glossary", link: "/glossary" },
              { text: "External Resources", link: "/resources" },
              { text: "Practice Exercises", link: "/exercises" },
            ],
          },
          {
            text: "📚 Curriculum",
            collapsed: false,
            items: [
              { text: "Overview", link: "/01-curriculum/" },
              {
                text: "1. Requirements Engineering",
                link: "/01-curriculum/01-requirements-engineering",
              },
              {
                text: "2. Agile Execution",
                link: "/01-curriculum/02-agile-execution",
              },
              {
                text: "3. Strategy & Analysis",
                link: "/01-curriculum/03-strategy-analysis",
              },
              {
                text: "4. Data & Analytics",
                link: "/01-curriculum/04-data-analytics",
              },
              {
                text: "5. Product Process",
                link: "/01-curriculum/05-product-process",
              },
              {
                text: "6. Quality Assurance",
                link: "/01-curriculum/06-quality-assurance",
              },
              {
                text: "7. Technical Fluency",
                link: "/01-curriculum/07-technical-fluency",
              },
            ],
          },
          {
            text: "🏗️ ReserveEasy Project",
            collapsed: false,
            items: [
              { text: "Project Overview", link: "/02-reserve-easy-project/" },
              {
                text: "Discovery",
                collapsed: true,
                items: [
                  {
                    text: "Market Analysis",
                    link: "/02-reserve-easy-project/01-discovery/market-analysis",
                  },
                  {
                    text: "User Personas",
                    link: "/02-reserve-easy-project/01-discovery/user-personas",
                  },
                  {
                    text: "Opportunity Tree",
                    link: "/02-reserve-easy-project/01-discovery/opportunity-tree",
                  },
                ],
              },
              {
                text: "Specifications",
                collapsed: true,
                items: [
                  {
                    text: "Business Requirements (BRD)",
                    link: "/02-reserve-easy-project/02-specs/BRD-v1.0",
                  },
                  {
                    text: "Functional Spec (FSD)",
                    link: "/02-reserve-easy-project/02-specs/FSD-booking-mod",
                  },
                  {
                    text: "API Specs",
                    link: "/02-reserve-easy-project/02-specs/API-specs/webhooks",
                  },
                ],
              },
              {
                text: "Design",
                collapsed: true,
                items: [
                  {
                    text: "Process Maps",
                    link: "/02-reserve-easy-project/03-design/process-maps",
                  },
                ],
              },
              {
                text: "Delivery",
                collapsed: true,
                items: [
                  {
                    text: "Product Backlog",
                    link: "/02-reserve-easy-project/04-delivery/product-backlog",
                  },
                  {
                    text: "Sprint 15 Goal",
                    link: "/02-reserve-easy-project/04-delivery/sprints/sprint-15-goal",
                  },
                ],
              },
              {
                text: "Analytics",
                collapsed: true,
                items: [
                  {
                    text: "North Star Metric",
                    link: "/02-reserve-easy-project/05-analytics/north-star-metric",
                  },
                ],
              },
              {
                text: "Quality Assurance",
                collapsed: true,
                items: [
                  {
                    text: "Master Test Plan",
                    link: "/02-reserve-easy-project/06-qa/master-test-plan",
                  },
                  {
                    text: "Test Case: Guest Booking",
                    link: "/02-reserve-easy-project/06-qa/test-cases/TC-001-guest-booking",
                  },
                  {
                    text: "Bug Report: SMS Fail",
                    link: "/02-reserve-easy-project/06-qa/bug-reports/BUG-234-sms-fail",
                  },
                ],
              },
            ],
          },
          {
            text: "🛠️ Toolkit",
            collapsed: false,
            items: [
              { text: "Overview", link: "/03-toolkit/" },
              { text: "AI Prompts", link: "/03-toolkit/ai-prompts" },
              {
                text: "Templates",
                collapsed: true,
                items: [
                  {
                    text: "BRD Template",
                    link: "/03-toolkit/templates/brd-template",
                  },
                  {
                    text: "FSD Template",
                    link: "/03-toolkit/templates/fsd-template",
                  },
                  {
                    text: "User Story Card",
                    link: "/03-toolkit/templates/user-story-card",
                  },
                  {
                    text: "User Stories Library",
                    link: "/03-toolkit/templates/user-stories-library",
                  },
                  {
                    text: "Test Case Template",
                    link: "/03-toolkit/templates/test-case",
                  },
                ],
              },
              {
                text: "Checklists",
                collapsed: true,
                items: [
                  {
                    text: "Definition of Ready",
                    link: "/03-toolkit/checklists/definition-of-ready",
                  },
                  {
                    text: "Definition of Done",
                    link: "/03-toolkit/checklists/definition-of-done",
                  },
                  {
                    text: "AI Ethics Checklist",
                    link: "/03-toolkit/checklists/ai-ethics-checklist",
                  },
                ],
              },
            ],
          },
          {
            text: "💼 Career Portfolio",
            collapsed: false,
            items: [
              { text: "Overview", link: "/04-career-portfolio/" },
              {
                text: "PM Portfolio Guide",
                link: "/04-career-portfolio/pm-portfolio-guide",
              },
              {
                text: "BA Portfolio Guide",
                link: "/04-career-portfolio/ba-portfolio-guide",
              },
              {
                text: "Interview Preparation",
                link: "/04-career-portfolio/interview-preparation",
              },
              {
                text: "Resume Templates",
                link: "/04-career-portfolio/resume-templates",
              },
              {
                text: "Case Study Framework",
                link: "/04-career-portfolio/case-study-framework",
              },
              {
                text: "LinkedIn Optimization",
                link: "/04-career-portfolio/linkedin-optimization",
              },
            ],
          },
        ],
      },

      // Social links
      socialLinks: [
        {
          icon: "github",
          link: "https://github.com/codezelaca/pm-ba-lifecycle",
        },
      ],

      // Footer with Codezela branding
      footer: {
        message: `A <a href="https://github.com/codezelaca" target="_blank">${BRAND}</a> Learning Resource`,
        copyright: `© ${new Date().getFullYear()} ${BRAND}. Released under MIT License.`,
      },

      // Search with enhanced options
      search: {
        provider: "local",
        options: {
          detailedView: true,
          miniSearch: {
            searchOptions: {
              fuzzy: 0.2,
              prefix: true,
              boost: {
                title: 4,
                text: 2,
                titles: 1,
              },
            },
          },
          _render(src, env, md) {
            const html = md.render(src, env);
            if (env.frontmatter?.title)
              return md.render(`# ${env.frontmatter.title}`) + html;
            return html;
          },
        },
      },

      // Edit link
      editLink: {
        pattern:
          "https://github.com/codezelaca/pm-ba-lifecycle/edit/main/:path",
        text: "Edit this page on GitHub",
      },

      // Last updated
      lastUpdated: {
        text: "Last updated",
        formatOptions: {
          dateStyle: "medium",
          timeStyle: "short",
        },
      },

      // Doc footer navigation
      docFooter: {
        prev: "Previous",
        next: "Next",
      },

      // Outline (Table of Contents)
      outline: {
        level: [2, 3],
        label: "On this page",
      },

      // Return to top
      returnToTopLabel: "Back to top",

      // External link icon
      externalLinkIcon: true,
    },

    // Mermaid configuration
    mermaid: {
      theme: "default",
    },

    // Markdown configuration
    markdown: {
      lineNumbers: true,
      theme: {
        light: "github-light",
        dark: "github-dark",
      },
      // Enable anchor links
      anchor: {
        permalink: true,
      },
    },

    // Ignore dead links for flexibility
    ignoreDeadLinks: true,

    // Vue configuration
    vue: {
      template: {
        compilerOptions: {
          isCustomElement: (tag) => tag.includes("-"),
        },
      },
    },
  }),
);
