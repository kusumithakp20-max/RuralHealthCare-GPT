# RuralCare Deployment Quick Start Script (Windows PowerShell)
# This script guides you through deploying to Vercel and Render

Write-Host "🚀 RuralCare Deployment Quick Start" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Check if git is installed
$gitInstalled = git --version 2>$null
if (-not $gitInstalled) {
    Write-Host "❌ Git is not installed. Please install Git first." -ForegroundColor Red
    Write-Host "   Download: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Git is installed" -ForegroundColor Green
Write-Host ""

# Initialize git repository
if (-not (Test-Path ".git")) {
    Write-Host "📦 Initializing Git repository..." -ForegroundColor Yellow
    git init
    git add .
    git commit -m "Initial commit: RuralCare Generative AI Healthcare System"
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "✅ Git repository already exists" -ForegroundColor Green
}

Write-Host ""
Write-Host "📋 Next Steps for Deployment:" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1️⃣  BACKEND DEPLOYMENT (Render)" -ForegroundColor Yellow
Write-Host "   a) Go to https://render.com" -ForegroundColor White
Write-Host "   b) Sign up / Login" -ForegroundColor White
Write-Host "   c) Click 'New +' → 'Web Service'" -ForegroundColor White
Write-Host "   d) Connect your GitHub repository" -ForegroundColor White
Write-Host "   e) Configure:" -ForegroundColor White
Write-Host "      - Build Command: pip install -r backend/requirements.txt" -ForegroundColor White
Write-Host "      - Start Command: cd backend && gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:`$PORT app.main:app" -ForegroundColor White
Write-Host "   f) Add Environment Variables:" -ForegroundColor White
Write-Host "      - GROQ_API_KEY: [Get from https://console.groq.com]" -ForegroundColor White
Write-Host "      - GROQ_MODEL: llama3-8b-8192" -ForegroundColor White
Write-Host "      - GROQ_VISION_MODEL: llama-3.2-11b-vision-preview" -ForegroundColor White
Write-Host "      - ENVIRONMENT: production" -ForegroundColor White
Write-Host "   g) Click 'Create Web Service'" -ForegroundColor White
Write-Host "   h) Copy your backend URL when deployment completes" -ForegroundColor White
Write-Host ""

Write-Host "2️⃣  FRONTEND DEPLOYMENT (Vercel)" -ForegroundColor Yellow
Write-Host "   a) Go to https://vercel.com" -ForegroundColor White
Write-Host "   b) Sign up / Login" -ForegroundColor White
Write-Host "   c) Click 'Add New' → 'Project'" -ForegroundColor White
Write-Host "   d) Select your GitHub repository" -ForegroundColor White
Write-Host "   e) Configure:" -ForegroundColor White
Write-Host "      - Framework: Vite" -ForegroundColor White
Write-Host "      - Root Directory: ./frontend" -ForegroundColor White
Write-Host "      - Build Command: npm run build" -ForegroundColor White
Write-Host "      - Output Directory: dist" -ForegroundColor White
Write-Host "   f) Add Environment Variables:" -ForegroundColor White
Write-Host "      - VITE_API_URL: [Your Render backend URL]/api" -ForegroundColor White
Write-Host "   g) Click 'Deploy'" -ForegroundColor White
Write-Host ""

Write-Host "3️⃣  CONNECT BACKEND TO FRONTEND" -ForegroundColor Yellow
Write-Host "   a) Go to Render → Your Backend Service → Settings" -ForegroundColor White
Write-Host "   b) Set FRONTEND_URL to your Vercel URL" -ForegroundColor White
Write-Host "   c) Service will auto-redeploy" -ForegroundColor White
Write-Host ""

Write-Host "4️⃣  TEST YOUR DEPLOYMENT" -ForegroundColor Yellow
Write-Host "   a) Open https://your-frontend.vercel.app" -ForegroundColor White
Write-Host "   b) Check browser console for errors" -ForegroundColor White
Write-Host "   c) Test Symptom Checker to verify backend connection" -ForegroundColor White
Write-Host ""

Write-Host "📚 For detailed instructions, see: DEPLOYMENT_GUIDE.md" -ForegroundColor Cyan
Write-Host ""

Write-Host "🔑 Getting Your Groq API Key:" -ForegroundColor Yellow
Write-Host "   1. Go to https://console.groq.com" -ForegroundColor White
Write-Host "   2. Sign up for free account" -ForegroundColor White
Write-Host "   3. Go to API Keys section" -ForegroundColor White
Write-Host "   4. Create new API key" -ForegroundColor White
Write-Host "   5. Copy and add to Render environment variables" -ForegroundColor White
Write-Host ""

Write-Host "💾 Don't forget to:" -ForegroundColor Yellow
Write-Host "   - Git push your changes: git push -u origin main" -ForegroundColor White
Write-Host "   - Keep your .env file secret (it's in .gitignore)" -ForegroundColor White
Write-Host "   - Update API URLs in Vercel after Render deployment" -ForegroundColor White
Write-Host ""

Write-Host "✨ Happy Deploying! 🚀" -ForegroundColor Green
