name: Site Quality
on:
  pull_request:
jobs:
  markdownlint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - run: |
          npm i -g markdownlint-cli
          markdownlint "**/*.md"

  html-proofer:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: peaceiris/actions-hugo@v2
        with: { hugo-version: '0.125.4' }
      - run: hugo
      - uses: chabad360/htmlproofer@v1.1
        with:
          directory: ./public
          arguments: --allow_hash_href --url-ignore "/localhost/"

  terraform-validate:
    if: ${{ hashFiles('infra/**/*.tf') != '' }}
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: hashicorp/setup-terraform@v3
      - run: |
          terraform -chdir=infra fmt -check
          terraform -chdir=infra init -backend=false
          terraform -chdir=infra validate
