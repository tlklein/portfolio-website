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
    "Cloud Developer with a B.S. in Computer Information Systems (Cum Laude) from the University of Houston and AWS Cloud Practitioner certification. Experienced in designing, deploying, and automating cloud-native applications using AWS services (Lambda, S3, DynamoDB, CloudFront), serverless computing, and CI/CD pipelines with Terraform and GitHub Actions. Delivered measurable impact through full-stack application development, workflow automation, and AI-integrated solutions that optimize performance, scalability, and operational efficiency.",
  skills: [
    "AWS (Certified Cloud Practitioner, Lambda, S3, DynamoDB, CloudFront)",
    "Terraform & Infrastructure as Code",
    "CI/CD Pipelines (GitHub Actions)",
    "Python",
    "Node.js & React",
    "API Design & Integration",
    "Cloud Security & IAM",
    "Serverless Architecture",
    "Linux / Bash",
    "Cisco Essentials Data Analytics"
  ],
  projects: [
    {
      name: "Cloud Resume Challenge",
      description:
        "Built a full-stack serverless resume website using AWS infrastructure, while automating deployment with CI/CD pipelines via GitHub Actions, and Terraform.",
      link: "https://github.com/tlklein/portfolio-website",
      skills: ["Infrastructure-as-Code CI/CD", "DevOps Practices", "AWS"],
    },
    {
      name: "Innov8 Barber Shop Management System",
      description:
        "Served as APM to deliver a full-stack management platform for a local barbershop.",
      link: "https://github.com/tlklein/CIS-4375-Team3-CapstoneProject",
      skills: ["Vue.js", "RDS", "Node.js", "AWS"],
    },
    {
      name: "Enterprise Data Platform",
      description:
        "Full-stack application using Vue Composition API and featuring interactive data visualizations.",
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
        "Deployed an automated appointment system, reducing scheduling workload by approximately 50% and client no-shows by 20%.",
        "Migrated corporate site to WordPress, boosting performance by 40% and reducing downtime",
        "Centralized around 1,000 client records into a digital database, improving accuracy and accessibility.",
        "Integrated AI chatbot and automated reminder funnels, increasing client leads by 25% and retention rates.",
        "Partnered with leadership to refine branding, streamline processes, expand the online presence across platforms, and align digital strategy with business growth objectives.",
        "Created data-driven marketing campaigns, integrating visual design and analytics to strengthen conversion strategy."
      ],
    }
  ],
  education: [
    {
      school: "University of Houston",
      degree: "Bachelor of Science in Computer Information Systems",
      dateRange: "2020 - 2025",
      achievements: [
        "Graduated Cum Laude with 3.5 GPA",
        "Dean's List 3 times",
        "Member of Future Information Technology Professionals (FITP)",
      ],
    }
  ],
  volunteer: [
    {
      company: "Greater Business of Pearland",
      title: "Ambassador",
      dateRange: "Mar. 2020 - Dec. 2024",
      bullets: [
        "The Greater Businesses of Pearland (GB Pearland) nonprofit's mission is to provide a variety of avenues that equally support business growth and prosperity and the greater good of the community.",
        "Strengthened community partnerships, contributing to a 3,000+ increase in event attendance.",
        "Conducted demographic analysis of 1,500+ attendees using Excel to inform strategy."
      ],
    }
  ]
};
