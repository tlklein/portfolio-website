name: CodeQL
on:
  push: { branches: [ main ] }
  pull_request:
permissions:
  security-events: write
  contents: read
jobs:
  codeql:
    name: codeql
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: github/codeql-action/init@v3
        with: { languages: javascript }
      - uses: github/codeql-action/analyze@v3
