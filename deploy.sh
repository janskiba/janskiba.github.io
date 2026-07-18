#!/bin/bash
npm run build
touch docs/.nojekyll
echo "janskiba.dev" > docs/CNAME

git add .
git commit -m "Deploying to GitHub Pages"
git push 