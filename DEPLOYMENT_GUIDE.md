# 🚀 RuralCare Deployment Guide
## Deploying to Vercel (Frontend) & Render (Backend)

---

## 📋 Prerequisites

Before deploying, ensure you have:
- [ ] GitHub account
- [ ] Vercel account (free: https://vercel.com)
- [ ] Render account (free: https://render.com)
- [ ] Git installed and repo pushed to GitHub
- [ ] Groq API key (free: https://console.groq.com) - for LLM
- [ ] Project pushed to GitHub

---

## 🔄 Step 1: Prepare Your Repository

### 1.1 Initialize Git (if not already done)
```bash
cd c:\Users\kusum\Downloads\RuralCare--main\RuralCare--main
git init
git add .
git commit -m "Initial commit: RuralCare Generative AI Healthcare System"
```

### 1.2 Create `.gitignore`
```bash
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg
venv/
ENV/
env/
.venv

# Node
node_modules/
npm-debug.log
yarn-error.log
.npm
dist/
build/

# Environment
.env
.env.local
.env.*.local

# ChromaDB
vector_store/
uploads/
reports/
*.sqlite3

# IDE
.vscode/
.idea/
*.swp
*.swo
*~
.DS_Store
```

### 1.3 Push to GitHub
```bash
git remote add origin https://github.com/YOUR_USERNAME/RuralCare.git
git branch -M main
git push -u origin main
```

---

## 🎯 Step 2: Deploy Backend to Render

### 2.1 Prepare Backend for Render

#### Create `render.yaml` in root directory:
```yaml
services:
  - type: web
    name: ruralcare-backend
    env: python
    plan: free
    buildCommand: "pip install -r backend/requirements.txt"
    startCommand: "cd backend && python -m app.main"
    envVars:
      - key: PYTHON_VERSION
        value: "3.11"
      - key: GROQ_API_KEY
        scope: secret
      - key: GROQ_MODEL
        value: "llama3-8b-8192"
      - key: GROQ_VISION_MODEL
        value: "llama-3.2-11b-vision-preview"
      - key: OLLAMA_BASE_URL
        value: "http://localhost:11434"
      - key: OLLAMA_MODEL
        value: "llama3"
```

#### Modify `backend/requirements.txt` to add Render-compatible packages:
```
fastapi==0.104.1
uvicorn==0.24.0.post1
langchain>=0.2.0,<0.3.0
langchain-community>=0.2.0,<0.3.0
langchain-groq>=0.1.0,<0.2.0
chromadb==0.4.15
sentence-transformers>=2.6.0
scikit-learn==1.3.2
pandas==2.1.3
reportlab==4.0.7
python-multipart==0.0.6
pydantic==2.5.2
python-dotenv==1.0.0
numpy==1.26.2
httpx>=0.27.0,<0.28.0
gunicorn==21.2.0
```

#### Create `backend/Procfile`:
```
web: cd backend && gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:$PORT app.main:app
```

#### Create `.env.example` in root:
```env
# Backend Configuration
GROQ_API_KEY=your_groq_api_key_here
GROQ_MODEL=llama3-8b-8192
GROQ_VISION_MODEL=llama-3.2-11b-vision-preview

OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL=llama3
OLLAMA_VISION_MODEL=llava

# Frontend Configuration (for CORS)
FRONTEND_URL=https://your-frontend.vercel.app
```

### 2.2 Deploy to Render

1. **Go to Render.com**
   - Sign up/Login to https://render.com

2. **Create New Web Service**
   - Click "New +" → "Web Service"
   - Connect your GitHub repository
   - Select the RuralCare repo

3. **Configure Service**
   - **Name**: `ruralcare-backend`
   - **Environment**: `Python 3`
   - **Build Command**: 
     ```
     pip install -r backend/requirements.txt
     ```
   - **Start Command**: 
     ```
     cd backend && gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:$PORT app.main:app
     ```
   - **Plan**: Select "Free" (or paid for better performance)

4. **Add Environment Variables**
   - Click "Environment"
   - Add these variables:
     ```
     GROQ_API_KEY = [your_groq_key_from_console.groq.com]
     GROQ_MODEL = llama3-8b-8192
     GROQ_VISION_MODEL = llama-3.2-11b-vision-preview
     OLLAMA_BASE_URL = http://localhost:11434
     OLLAMA_MODEL = llama3
     FRONTEND_URL = https://your-frontend.vercel.app
     ```

5. **Deploy**
   - Click "Create Web Service"
   - Wait for deployment (2-5 minutes)
   - Note your backend URL: `https://ruralcare-backend.onrender.com`

### 2.3 Update Backend for Render

Modify `backend/app/main.py` to handle CORS properly:

```python
from fastapi.middleware.cors import CORSMiddleware
import os

# Get frontend URL from environment
frontend_url = os.getenv("FRONTEND_URL", "http://localhost:3000")

app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        frontend_url,
        "http://localhost:3000",
        "http://localhost:5173",  # Vite dev server
        "https://localhost:3000",
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

---

## 🎨 Step 3: Deploy Frontend to Vercel

### 3.1 Prepare Frontend for Vercel

#### Create `vercel.json` in root:
```json
{
  "buildCommand": "cd frontend && npm run build",
  "outputDirectory": "frontend/dist",
  "installCommand": "cd frontend && npm install",
  "env": {
    "VITE_API_URL": "@ruralcare_api_url"
  },
  "envPrefix": "VITE_",
  "github": {
    "enabled": true,
    "autoAlias": true
  }
}
```

#### Create `frontend/.env.production`:
```
VITE_API_URL=https://ruralcare-backend.onrender.com/api
```

#### Modify `frontend/vite.config.js`:
```javascript
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true,
      },
    },
  },
  build: {
    outDir: 'dist',
    sourcemap: false,
    rollupOptions: {
      output: {
        manualChunks: {
          vendor: ['react', 'react-dom'],
        },
      },
    },
  },
})
```

#### Update `frontend/src/api.js`:
```javascript
// Central API configuration - uses environment variable or falls back to relative URL
const API_BASE = import.meta.env.VITE_API_URL || '/api';

export default API_BASE;
```

### 3.2 Deploy to Vercel

1. **Go to Vercel.com**
   - Sign up/Login to https://vercel.com
   - Click "Add New..." → "Project"

2. **Import Repository**
   - Select your RuralCare GitHub repo
   - Click "Import"

3. **Configure Project**
   - **Project Name**: `ruralcare-frontend` (or desired name)
   - **Framework Preset**: `Vite`
   - **Root Directory**: `./frontend`
   - **Build Command**: 
     ```
     npm run build
     ```
   - **Output Directory**: 
     ```
     dist
     ```
   - **Install Command**: 
     ```
     npm install
     ```

4. **Add Environment Variables**
   - Click "Environment Variables"
   - Add:
     ```
     VITE_API_URL = https://ruralcare-backend.onrender.com/api
     ```

5. **Deploy**
   - Click "Deploy"
   - Wait for deployment (1-3 minutes)
   - Your frontend URL: `https://ruralcare-frontend.vercel.app`

---

## 🔗 Step 4: Connect Frontend to Backend

After both are deployed:

1. **Update Vercel Environment Variable**
   - Go to Vercel Dashboard → Your Project → Settings → Environment Variables
   - Update `VITE_API_URL` with your Render backend URL:
     ```
     VITE_API_URL = https://ruralcare-backend.onrender.com/api
     ```
   - Click "Save"
   - Trigger a redeploy (go to Deployments → trigger redeploy)

2. **Update Render CORS**
   - Go to Render Dashboard → Your Backend Service → Environment
   - Update `FRONTEND_URL`:
     ```
     FRONTEND_URL = https://ruralcare-frontend.vercel.app
     ```
   - This will auto-redeploy

---

## 🧪 Step 5: Testing

### 5.1 Test Backend
```bash
curl -X GET https://ruralcare-backend.onrender.com/api/languages

# Expected response:
# [
#   {"code": "en", "name": "English"},
#   {"code": "kn", "name": "Kannada"},
#   ...
# ]
```

### 5.2 Test Frontend
- Open https://ruralcare-frontend.vercel.app
- Check browser console for API errors
- Test Symptom Checker (should call backend)

### 5.3 Monitor Logs
- **Vercel**: Dashboard → Your Project → Deployments → Select → Logs
- **Render**: Dashboard → Your Service → Logs

---

## ⚙️ Step 6: Production Optimization

### 6.1 Update Backend for Production

Modify `backend/app/main.py`:
```python
import os

# Production settings
ENVIRONMENT = os.getenv("ENVIRONMENT", "development")

if ENVIRONMENT == "production":
    import logging
    logging.basicConfig(level=logging.INFO)
    
    # Add production middleware
    from fastapi.middleware.gzip import GZIPMiddleware
    app.add_middleware(GZIPMiddleware, minimum_size=1000)
```

### 6.2 Add Health Check Endpoint

Add to `backend/app/api/endpoints.py`:
```python
@router.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "version": "1.0.0",
        "environment": os.getenv("ENVIRONMENT", "development")
    }
```

Test: `curl https://ruralcare-backend.onrender.com/api/health`

### 6.3 Optimize Render

For better performance (paid tier):
1. Go to Render Dashboard → Service → Settings
2. Upgrade from "Free" to "Starter" ($7/month)
3. Increase instance size if needed

---

## 📊 Deployment Checklist

- [ ] Repository pushed to GitHub
- [ ] `.gitignore` configured
- [ ] `.env.example` created
- [ ] `render.yaml` created
- [ ] `Procfile` created in backend
- [ ] `vercel.json` created
- [ ] Backend deployed to Render
- [ ] Frontend deployed to Vercel
- [ ] Environment variables set on both
- [ ] CORS configured
- [ ] API endpoints tested
- [ ] Frontend loads without errors
- [ ] Symptom Checker works end-to-end
- [ ] Health check endpoint responds

---

## 🐛 Troubleshooting

### Backend Deployment Issues

**Error: "Build failed"**
- Check Render logs for details
- Ensure all dependencies in `requirements.txt`
- Verify Python version compatibility

**Error: "Application failed to start"**
- Check start command is correct
- Verify Groq API key is set
- Check backend logs: Render Dashboard → Logs

**Error: "Port already in use"**
- Render automatically assigns port
- Don't hardcode port, use `$PORT` env var

### Frontend Deployment Issues

**Error: "API calls failing"**
- Check `VITE_API_URL` environment variable
- Verify backend CORS allows your Vercel domain
- Check browser console for specific errors

**Error: "Build failed"**
- Ensure Node 16+ is installed
- Check `npm run build` works locally
- Verify all imports are correct

**Error: "Blank page / 404"**
- Check output directory is `dist`
- Verify `vercel.json` configuration
- Clear Vercel cache and redeploy

### API Connectivity

**Test from Frontend:**
```javascript
// Open browser console and run:
fetch('/api/languages')
  .then(r => r.json())
  .then(d => console.log(d))
  .catch(e => console.error(e))
```

**Test from Postman:**
```
GET https://ruralcare-backend.onrender.com/api/languages
```

---

## 🔒 Security Best Practices

1. **Secrets Management**
   - Use Render/Vercel's secret management
   - Never commit `.env` file
   - Rotate API keys regularly

2. **CORS Configuration**
   - Only allow your Vercel domain
   - Update when deploying to new domain

3. **Rate Limiting**
   - Add rate limiting for API (optional, paid feature on Render)
   - Monitor usage on Groq console

4. **HTTPS**
   - Render: Automatic SSL
   - Vercel: Automatic SSL
   - Always use HTTPS for APIs

---

## 📈 Monitoring & Logs

### Render Logs
```
Dashboard → Your Service → Logs
- Monitor real-time logs
- Check for errors
- Verify requests
```

### Vercel Analytics
```
Dashboard → Your Project → Analytics
- Monitor requests
- Check response times
- View error rates
```

### Groq Usage
```
https://console.groq.com
- Monitor API usage
- Check token consumption
- Upgrade plan if needed
```

---

## 💰 Cost Estimation

### Free Tier
- **Vercel Frontend**: Free ✅
- **Render Backend**: Free ✅ (hibernates after 15 min inactivity)
- **Groq API**: Free tier (limited requests)
- **Total**: ~$0/month (with limitations)

### Recommended Tier
- **Vercel Frontend**: Free
- **Render Backend**: Starter ($7/month)
- **Groq API**: Upgrade if needed (~$0.02 per 1K tokens)
- **Total**: ~$7-15/month

---

## 🚀 Deployment Commands Summary

```bash
# Local testing
cd backend && python -m app.main
cd frontend && npm run dev

# Push to GitHub
git add .
git commit -m "Ready for deployment"
git push -u origin main

# After Vercel/Render setup, just git push
# - Render auto-deploys on git push (if connected)
# - Vercel auto-deploys on git push (if connected)
```

---

## 📞 Additional Resources

- **Vercel Docs**: https://vercel.com/docs
- **Render Docs**: https://render.com/docs
- **FastAPI on Render**: https://render.com/docs/deploy-fastapi
- **React on Vercel**: https://vercel.com/guides/deploying-react-with-vercel
- **Groq API**: https://console.groq.com/docs

---

**Your RuralCare application is ready for production! 🚀**
