npx playwright test tests/
hugo build --minify --baseURL "https://d2d06xlq6t9xmp.cloudfront.net/"
wscat "https://d2d06xlq6t9xmp.cloudfront.net/"

http://localhost:1313/
https://d2d06xlq6t9xmp.cloudfront.net/