export const siteConfig = {
  name: "Trinity Klein",
  title: "Cloud Engineer",
  description: "Portfolio website of Trinity Klein",
  accentColor: "#0066CC", 
  social: {
    resume: "/Trinity_Klein_Resume.pdf",
    linkedin: "https://linkedin.com/in/trinity-klein",
    github: "https://github.com/tlklein",
    email: "trinitylklein@outlook.com"
  },
  aboutMe:
    "Started in operations at Southeast Hypnosis managing intake, billing, and scheduling, where I rebuilt the manual workflow into an automated custom CRM platform in GoHighLevel and transitioned into Automation Engineer. B.S. in Computer Information Systems, Cum Laude from the University of Houston and AWS Certified Cloud Practitioner."
    ,
  skills: [
    "AWS - S3 / CloudFront OAC / Lambda / DynamoDB / IAM",
    "Terraform (IaC) / Remote State & Locking",
    "CI/CD - GitHub Actions + OIDC",
    "Python / Node.js / TypeScript",
    "Serverless & REST APIs",
    "Git / GitHub",
    "SQL & Database Design",
    "Systems Analysis / InfoSec Fundamentals"
  ],
  projects: [
    {
      name: "Serverless Portfolio Website - trinityklein.dev",
      description:
        "Production-grade Cloud Resume Challenge built as a real AWS Organization (prod + test OUs). Astro static site hosted on S3 with CloudFront OAC, server-side encryption, versioning, and lifecycle rules. Serverless visitor counter via API Gateway + Lambda + DynamoDB. IaC with modular Terraform (remote state S3/DynamoDB locking), OIDC-secured GitHub Actions CI/CD, Playwright E2E, CodeQL, SBOM (Syft/Grype/OSV), and billing alerts.",
      link: "https://github.com/tlklein/portfolio-website",
      skills: ["AWS Organizations", "S3 + CloudFront OAC", "Terraform", "GitHub Actions OIDC", "Lambda/DynamoDB", "Playwright"],
    },
    {
      name: "Innov8 Barber Shop Management System - Capstone",
      description:
        "Full-stack management platform prototype for a real local Houston barbershop. Centralizes appointment scheduling, client management, and business workflows to eliminate manual conflicts. Vue.js frontend + Node/Express REST API, MySQL on AWS RDS, role-based workflows, ERD, swim-lane diagrams, and full project governance docs (WBS, RACI, Risk, Requirements Traceability). I was Associate PM, leading requirements -> architecture -> delivery.",
      link: "https://github.com/tlklein/CIS-4375-Team3-CapstoneProject",
      skills: ["Vue.js", "Node.js / Express", "MySQL / AWS RDS", "REST APIs", "ERD / Systems Design"],
    },
    {
      name: "Full-Stack Enterprise Data Platform",
      description:
        "MEVN data platform refactored from academic prototype into production-ready app for Community Health Worker workflows. Rewrote frontend to Vue 3 Composition API + Pinia + Tailwind, replaced static data with dynamic CRUD APIs (Mongoose), added role-based access control (Viewer/Editor), form validation with Vuelidate, and interactive dashboards (bar/donut charts) for client/event metrics. Modular REST design for maintainability.",
      link: "https://github.com/tlklein/mongodb-data-platform-project",
      skills: ["Vue 3 / Pinia", "Node.js / Express", "MongoDB / Mongoose", "RBAC", "Tailwind CSS"],
    },
    {
      name: "Resume Automation Pipeline",
      description:
        "LaTeX resume compiled to ATS-optimized PDF via Docker for reproducible builds. Automated with GitHub Actions: build on every commit, generate PDF artifact, and auto-commit. Makefile for local builds. Eliminates manual formatting drift and ensures version-controlled, deterministic output.",
      link: "https://github.com/tlklein/resume",
      skills: ["Docker", "LaTeX", "GitHub Actions", "Make", "ATS Optimization"],
    },
    {
      name: "IT Asset Management Database - Oracle",
      description:
        "Production-oriented ITAM relational database in Oracle SQL/PL-SQL. Modeled business-critical assets (computers, servers, peripherals, employees, departments) with PK/FK, UNIQUE, CHECK, NOT NULL for defensive integrity. Automated ops with PL/SQL functions, stored procedures, and triggers. Simulated cloud migration to OCI with RBAC/least-privilege users, and performance tuning via indexes and execution plan analysis.",
      link: "https://github.com/tlklein/oracle-sql-db-project",
      skills: ["Oracle SQL / PL-SQL", "Data Modeling / ERD", "RBAC / Least Privilege", "OCI", "Performance Tuning"],
    },
    {
      name: "Multi-Step Cyber Attack Simulation",
      description:
        "End-to-end adversary emulation on TryHackMe Bookstore CTF in controlled lab. Chain: RustScan/Gobuster recon -> API fuzzing to find v1 endpoint -> file inclusion via .bash_history -> Werkzeug debugger PIN extraction -> Python reverse shell via Netcat -> privilege escalation by reverse engineering try-harder binary in Ghidra to extract magic number -> root. Documented TTPs, commands, and full lab report.",
      link: "https://github.com/tlklein/multi-step-cyber-attack",
      skills: ["Penetration Testing", "REST API Fuzzing", "Privilege Escalation", "Ghidra / Reverse Engineering", "TryHackMe"],
    },
    {
      name: "College Apartment Network Design",
      description:
        "Enterprise-grade network architecture for luxury high-density college apartments (thousands of concurrent users, IoT, multimedia). Designed layered Core->Distribution->Access with Cisco Meraki MR53/MR30H, MX250 SD-WAN (active/active), C9300/C9500 fabric. VLAN segmentation for Residents/Guests/Staff/IoT/Mgmt with ACLs, DHCP/NAT planning, channel planning 1/6/11, QoS, and Meraki cloud ops for zero-touch provisioning and monitoring. Includes floor diagrams, Visio, BOM with licensing costs.",
      link: "https://github.com/tlklein/college-apartment-network-design",
      skills: ["Cisco Meraki", "VLAN / ACL Segmentation", "SD-WAN / MX250", "Layered Routing", "Network Design"],
    },
  ],
  experience: [
    {
      company: "Southeast Hypnosis",
      title: "Automation Engineer (Digital Transformation)",
      dateRange: "Sept. 2021 - Dec. 2024",
      bullets: [
        "Architected end-to-end RevOps automation on GoHighLevel (HighLevel) - engineered custom CRM pipelines, scheduling logic, intake forms, and multi-channel nurture sequences with webhook/API integrations, eliminating 15+ hrs/week of manual admin and reducing client no-show rates by 30\%+.",
        "Built and deployed an AI-powered inbound qualification system with chat widget, SMS/email follow-up workflows, and conditional logic to triage, nurture, and auto-book leads, increasing lead-to-appointment conversion and ensuring 24/7 response time.",
        "Rebuilt and optimized corporate WordPress website on SiteGround (\$20/mo plan), improving page load speed by >60\%, achieving 99.9\% uptime, and streamlining organic booking UX through caching, image optimization, and workflow automation.",
        "Centralized and cleaned 300+ client records into a single source-of-truth CRM with automated data collection, verification, and reporting dashboards, improving data integrity and enabling downstream automation and retention campaigns."
      ],
    },
    {
      company: "Southeast Hypnosis",
      title: "Office Manager",
      dateRange: "Mar. 2020 - Sept. 2021",
      bullets: [
        "Managed end-to-end front-office operations (scheduling, intake, confidential client records, billing, and client communications) while auditing manual workflows for failure points, data loss, and time sinks.",
        "Partnered with ownership to map lead-to-cash bottlenecks and proposed CRM-driven automation roadmap for scheduling and intake, catalyzing promotion to Automation Engineer and full digital transformation."
      ]
    }
  ],
  education: [
    {
      school: "University of Houston",
      degree: "Bachelor of Science, Computer Information Systems",
      dateRange: "Aug. 2020 - May 2025",
      achievements: [
        "Cum Laude; GPA 3.5; Dean's List (3x); Active FITP member — tech workshops, competitions, \& networking;"
      ],
    }
  ],
  volunteer: [
    {
      company: "Greater Business of Pearland",
      title: "Community Business Ambassador",
      dateRange: "Nov. 2021 - May 2024",
      bullets: [
        "Built and maintained attendee demographics dashboard in Excel from 1,500+ Eventbrite registrations to analyze audience trends and inform data-driven outreach, partnerships, and programming decisions driving measurable growth in event attendance",
        "Served as Board liaison, producing executive-level meeting minutes, action items, and attendance reports for the Board of Directors to ensure governance compliance and operational follow-through."
      ]
    }
  ]
};
