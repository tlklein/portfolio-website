export const siteConfig = {
  name: "Trinity Klein",
  title: "Cloud & DevOps Engineer",
  description: "Portfolio website of Trinity Klein",
  accentColor: "#0066CC", 
  social: {
    resume: "/trinity-klein-resume.pdf",
    linkedin: "https://linkedin.com/in/trinity-klein",
    github: "https://github.com/tlklein",
    email: "trinitylklein@outlook.com"
  },
  aboutMe:
    "I am a Cloud & DevOps Engineer (B.S., Computer Information Systems - Cum Laude) and AWS Certified Cloud Practitioner who architects, deploys, and automates scalable cloud infrastructure and full-stack systems. My specialties include serverless architectures (Lambda, API Gateway, S3, DynamoDB), Infrastructure as Code (Terraform), CI/CD pipelines (GitHub Actions), and security-focused design. I'm experienced with Python, Node.js, Vue.js, database engineering, and network architecture.",
  skills: [
    "Terraform",
    "CI/CD ",
    "Python",
    "Serverless Architecture",
    "Full-Stack"
  ],
  projects: [
    {
      name: "AWS Serverless Cloud Platform",
      description:
        "A fully serverless, end-to-end web application showcasing cloud-native design and automation. Built on AWS using S3, CloudFront, Lambda, and DynamoDB, deployed via Terraform with GitHub Action CI/CD pipelines.",
      link: "https://github.com/tlklein/portfolio-website",
      skills: ["Infrastructure-as-Code CI/CD", "DevOps", "AWS"],
    },
    {
      name: "Innov8 Barber Shop Management System",
      description:
        "A full-stack web application built for a local barbershop owner, featuring a public-facing site and a private dashboard to manage clients, services, and appointments.",
      link: "https://github.com/tlklein/CIS-4375-Team3-CapstoneProject",
      skills: ["Vue.js", "RDS", "Node.js", "AWS"],
    },
    {
      name: "Full-Stack Enterprise Data Platform",
      description:
        "A full-stack data platform built with Vue 3 and Node.js to manage events, services, and client data. Features role-based access control, interactive data visualizations, and a modular MEVN architecture designed for maintainability and real-world scalability.",
      link: "https://github.com/tlklein/mongodb-data-platform-project",
      skills: ["MongoDB", "Express", "Vue.js", "Node.js"],
    },
    {
      name: "Resume Automation System",
      description:
        "Automated generation of my professional resume using Docker, LaTeX, with ATS optimized formatting.",
      link: "https://github.com/tlklein/resume",
      skills: ["Docker", "LaTex", "pdflatex"],
    },
    {
      name: "IT Asset Management Database",
      description:
        "A production-oriented relational database with constraints, automation, cloud migration, and performance tuning.",
      link: "https://github.com/tlklein/oracle-sql-db-project",
      skills: ["Oracle SQL", "PL/SQL", "Oracle SQL Developer", "Oracle Cloud Infrastructure"],
    },
    {
      name: "Multi-Step Cyber Attack Simulation",
      description:
        "A end-to-end penetration testing exercise covering reconnaissance, exploitation, reverse engineering, and privilege escalation.",
      link: "https://github.com/tlklein/multi-step-cyber-attack",
      skills: ["Bookstore CTF", "TryHackMe Lab", "Penetration Testing", "Exploit Development"],
    },
    {
      name: "College Apartment Network Design",
      description:
        "A high-performance network architecture for a luxury college apartment complex - hospitality-grade connectivity, segmented security, and operational manageability.",
      link: "https://github.com/tlklein/college-apartment-network-design",
      skills: ["Cisco Meraki", "VLAN Segmentation", "SD-WAN", "Layered Routing"],
    }
  ],
  experience: [
    {
      company: "Southeast Hypnosis",
      title: "Automation Engineer (Digital Transformation)",
      dateRange: "Mar. 2020 - Dec. 2024",
      bullets: [
        "Architected and deployed automated appointment scheduling and reminder workflows using a white-labeled automation/CRM platform with webhook integrations, reducing manual scheduling effort by 50% and lowering client no-shows by 20%.",
        "Migrated corporate website from SiteGround to optimized WordPress infrastructure with caching, CDN integration, and database tuning, improving page load times by 40% and maintaining high availability.",
        "Consolidated and normalized 300+ client records into a centralized, secure database; implemented access controls, data validation, and backup procedures to enhance data integrity and operational reporting.",
        "Integrated AI-driven chatbot and automated lead-nurture workflows to qualify inbound traffic and trigger follow-ups, increasing qualified leads by 25% and improving client retention.",
        "Authored technical documentation, runbooks, and standard operating procedures; collaborated with executive stakeholders to translate business requirements into maintainable, scalable solutions."
      ],
    }
  ],
  education: [
    {
      school: "University of Houston",
      degree: "Bachelor of Science, Computer Information Systems",
      dateRange: "Aug. 2020 - May 2025",
      achievements: [
        "GPA: 3.5 / 4.0; Cum Laude"
      ],
    }
  ],
  volunteer: [
    {
      company: "Greater Business of Pearland",
      title: "Community Business Ambassador",
      dateRange: "Nov. 2021 - May 2024",
      bullets: [
        "Analyzed engagement data from 1,500+ participants using Excel to inform outreach strategies, delivering 3,000+ increase in event attendance through data-driven targeting and community partnerships."
      ]
    }
  ]
};
