module github.com/tlklein/portfolio-website

go 1.20

require (
    github.com/mrmierzejewski/hugo-theme-console v0.0.0-20250713183642-e68b718c8732 // indirect
    github.com/opencontainers/selinux v1.13.0
)

// Force selinux to v1.13.0 even if a transitive dependency requires an older version
replace github.com/opencontainers/selinux => github.com/opencontainers/selinux v1.13.0
