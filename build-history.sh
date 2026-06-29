#!/bin/bash
set -e
echo "🚀 Building recovery practice environment..."
mkdir -p src
echo "class RecoveryApp {}" > src/app.js
git add src/app.js
git commit -m "Initial app"
echo "✅ Setup complete! Start with EXERCISES.md"
