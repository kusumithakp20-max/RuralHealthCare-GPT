#!/bin/bash
# RuralCare Deployment Quick Start Script
# This script guides you through deploying to Vercel and Render

echo "🚀 RuralCare Deployment Quick Start"
echo "===================================="
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    echo "   Download: https://git-scm.com/download/win"
    exit 1
fi

echo "✅ Git is installed"
echo ""

# Initialize git repository
if [ ! -d ".git" ]; then
    echo "📦 Initializing Git repository..."
    git init
    git add .
    git commit -m "Initial commit: RuralCare Generative AI Healthcare System"
    echo "✅ Git repository initialized"
else
    echo "✅ Git repository already exists"
fi

echo ""
echo "📋 Next Steps for Deployment:"
echo "===================================="
echo ""

echo "1️⃣  BACKEND DEPLOYMENT (Render)"
echo "   a) Go to https://render.com"
echo "   b) Sign up / Login"
echo "   c) Click 'New +' → 'Web Service'"
echo "   d) Connect your GitHub repository"
echo "   e) Configure:"
echo "      - Build Command: pip install -r backend/requirements.txt"
echo "      - Start Command: cd backend && gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:\$PORT app.main:app"
echo "   f) Add Environment Variables:"
echo "      - GROQ_API_KEY: [Get from https://console.groq.com]"
echo "      - GROQ_MODEL: llama3-8b-8192"
echo "      - GROQ_VISION_MODEL: llama-3.2-11b-vision-preview"
echo "      - ENVIRONMENT: production"
echo "   g) Click 'Create Web Service'"
echo "   h) Copy your backend URL when deployment completes"
echo ""

echo "2️⃣  FRONTEND DEPLOYMENT (Vercel)"
echo "   a) Go to https://vercel.com"
echo "   b) Sign up / Login"
echo "   c) Click 'Add New' → 'Project'"
echo "   d) Select your GitHub repository"
echo "   e) Configure:"
echo "      - Framework: Vite"
echo "      - Root Directory: ./frontend"
echo "      - Build Command: npm run build"
echo "      - Output Directory: dist"
echo "   f) Add Environment Variables:"
echo "      - VITE_API_URL: [Your Render backend URL]/api"
echo "   g) Click 'Deploy'"
echo ""

echo "3️⃣  CONNECT BACKEND TO FRONTEND"
echo "   a) Go to Render → Your Backend Service → Settings"
echo "   b) Set FRONTEND_URL to your Vercel URL"
echo "   c) Service will auto-redeploy"
echo ""

echo "4️⃣  TEST YOUR DEPLOYMENT"
echo "   a) Open https://your-frontend.vercel.app"
echo "   b) Check browser console for errors"
echo "   c) Test Symptom Checker to verify backend connection"
echo ""

echo "📚 For detailed instructions, see: DEPLOYMENT_GUIDE.md"
echo ""

echo "🔑 Getting Your Groq API Key:"
echo "   1. Go to https://console.groq.com"
echo "   2. Sign up for free account"
echo "   3. Go to API Keys section"
echo "   4. Create new API key"
echo "   5. Copy and add to Render environment variables"
echo ""

echo "💾 Don't forget to:"
echo "   - Git push your changes: git push -u origin main"
echo "   - Keep your .env file secret (it's in .gitignore)"
echo "   - Update API URLs in Vercel after Render deployment"
echo ""

echo "✨ Happy Deploying! 🚀"
