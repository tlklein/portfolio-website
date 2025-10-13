set -e

echo "Running markdownlint..."
markdownlint "README.md" 

echo "Validating HTML structure..."
npx html-validate "public/**/*.html"

echo "Checking links..."
npx linkinator ./public --recurse --skip "localhost"

echo "All checks passed successfully!"