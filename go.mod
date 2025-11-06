module github.com/tlklein/portfolio-website

go 1.13

require (
    github.com/mrmierzejewski/hugo-theme-console v0.0.0-20250713183642-e68b718c8732 // indirect
    github.com/opencontainers/selinux v1.12.0 // indirect, original vulnerable version
)

replace github.com/opencontainers/selinux => github.com/opencontainers/selinux v1.13.0