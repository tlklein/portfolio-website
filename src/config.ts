export const siteConfig = {
  name: "Trinity Klein",
  title: "Cloud Developer",
  description: "Portfolio website of Trinity Klein",
  accentColor: "#0066CC", 
  social: {
    resume: "/trinity-klein-resume.pdf",
    linkedin: "https://linkedin.com/in/trinity-klein",
    github: "https://github.com/tlklein",
    devto: "https://dev.to/tlklein",
  },
  aboutMe:
    "Trinity Klein is a Cloud Developer (B.S., Computer Information Systems - Cum Laude) and an AWS Certified Cloud Practitioner who designs, deploys, and automates cloud-native applications. Specialties include serverless architectures (Lambda, S3, CloudFront, DynamoDB), Infrastructure as Code (Terraform), and CI/CD pipelines with GitHub Actions. Experienced with Python, SQL, and infrastructure hardening.",
  skills: [
    "Terraform",
    "CI/CD ",
    "Python",
    "SQL",
    "Automation"
  ],
  projects: [
    {
      name: "Cloud Resume Challenge",
      description:
        "A fully serverless, end-to-end web application showcasing cloud-native design and automation. Built on AWS using S3, CloudFront, Lambda, and DynamoDB, deployed via Terraform with GitHub Action CI/CD pipelines.",
      link: "https://github.com/tlklein/portfolio-website",
      skills: ["Infrastructure-as-Code CI/CD", "DevOps Practices", "AWS"],
    },
    {
      name: "Innov8 Barber Shop Management System",
      description:
        "A full-stack web application built for a local barbershop owner, featuring a public-facing site and a private dashboard to manage clients, services, and appointments.",
      link: "https://github.com/tlklein/CIS-4375-Team3-CapstoneProject",
      skills: ["Vue.js", "RDS", "Node.js", "AWS"],
    },
    {
      name: "Enterprise Data Platform",
      description:
        "A full-stack data platform built with Vue 3 and Node.js to manage events, services, and client data. Features role-based access control, interactive data visualizations, and a modular MEVN architecture designed for maintainability and real-world scalability.",
      link: "https://github.com/tlklein/mongodb-data-platform-project",
      skills: ["MongoDB", "Express", "Vue.js", "Node.js"],
    },
  ],
  experience: [
    {
      company: "Southeast Hypnosis",
      title: "Digital Systems Engineer",
      dateRange: "Mar. 2020 - Dec. 2024",
      bullets: [
        "Southeast Hypnosis offers professional hypnosis services to help clients achieve personal goals, with a focus on leveraging digital systems to enhance customer experience.",
        "Architected and deployed automated appointment scheduling and reminder workflows (white-labeled automation platform), reducing manual scheduling effort and lowering client no-shows by approximately 20%.",
        "Migrated and optimized corporate website to WordPress from Site Grounds, improving site performance and availability by approximately 40% and reducing downtime through performance tuning and configuration best practices.",
        "Consolidated and normalized approximately 1,000 client records into a centralized, secure digital database improving data accuracy, reporting and operational effectiveness.",
        "Integrated AI-powered chatbot workflows and automated lead-nurture funnels, increasing inbound leads by approximately 25%, and improving client retention via automated follow-ups.",
        "Designs and executed data-driven marketing campaigns using analytics to iterate creative and targeting, improving conversion and engagement metrics.",
        "Partnered with executive leadership to align digital strategy with branding, streamline operational processes, and scale multi-channel digital presences.",
        "Documented system architecture, runbooks, and process flows to support handoffs, compliance, and maintainability."
      ],
    }
  ],
  education: [
    {
      school: "University of Houston",
      degree: "Bachelor of Science in Computer Information Systems",
      dateRange: "2020 - 2025",
      achievements: [
        "Relevant Coursework: Database Management, Network Infrastructure, Application Development, Cloud Computing, Information Security, Systems Analysis",
        "Cum Laude (GPA: 3.5)",
        "Dean's List (3x)"
      ],
    }
  ]
  /*
  volunteer: [
    {
      company: "Greater Business of Pearland",
      title: "Ambassador",
      dateRange: "Mar. 2020 - Dec. 2024",
      bullets: [
        "The Greater Businesses of Pearland (GB Pearland) nonprofit's mission is to provide a variety of avenues that equally support business growth and prosperity and the greater good of the community.",
        "Analyzed engagement data from 1,500+ participants using Excel to inform outreach strategy, contributing to a 3,000+ increase in event attendance through data-backed targeting and stakeholder coordination."
      ],
    }
  ] */
};
