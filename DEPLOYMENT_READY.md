# 🚀 RuralCare Deployment - Complete Setup Guide

## 📊 What's Been Prepared for Deployment

All configuration files needed for deploying to Vercel (Frontend) and Render (Backend) have been created:

### ✅ Configuration Files Created

1. **`DEPLOYMENT_GUIDE.md`** - Complete step-by-step deployment guide
2. **`DEPLOYMENT_QUICKSTART.ps1`** - Windows PowerShell deployment helper
3. **`DEPLOYMENT_QUICKSTART.sh`** - Linux/Mac bash deployment helper
4. **`vercel.json`** - Vercel deployment configuration
5. **`render.yaml`** - Render deployment configuration
6. **`backend/Procfile`** - Process file for Render
7. **`frontend/.env.production`** - Production environment variables
8. **`backend/requirements.txt`** - Updated with `gunicorn` for Render

---

## 🎯 Quick Start - 5 Minute Setup

### Step 1: Push to GitHub (2 minutes)

```bash
# Open PowerShell in your project directory
cd c:\Users\kusum\Downloads\RuralCare--main\RuralCare--main

# Initialize git if not already done
git init
git add .
git commit -m "Ready for deployment: RuralCare Generative AI Healthcare"

# Create GitHub repository first at https://github.com/new
# Then push:
git remote add origin https://github.com/YOUR_USERNAME/RuralCare.git
git branch -M main
git push -u origin main
```

### Step 2: Deploy Backend to Render (2 minutes)

1. Go to **https://render.com**
2. Sign up/Login with GitHub
3. Click **"New +"** → **"Web Service"**
4. Select your **RuralCare** GitHub repository
5. Configure:
   - **Name**: `ruralcare-backend`
   - **Environment**: Python 3
   - **Build Command**: `pip install -r backend/requirements.txt`
   - **Start Command**: `cd backend && gunicorn -w 4 -k uvicorn.workers.UvicornWorker -b 0.0.0.0:$PORT app.main:app`

6. **Add Environment Variables** (click "Advanced"):
   ```
   GROQ_API_KEY = [Get from https://console.groq.com - Free account]
   GROQ_MODEL = llama3-8b-8192
   GROQ_VISION_MODEL = llama-3.2-11b-vision-preview
   ENVIRONMENT = production
   FRONTEND_URL = [Will update after Vercel deployment]
   ```
7. Click **"Create Web Service"** and wait for deployment (2-5 minutes)
8. **Copy your backend URL** when it shows "Live" (e.g., `https://ruralcare-backend.onrender.com`)

### Step 3: Deploy Frontend to Vercel (1 minute)

1. Go to **https://vercel.com**
2. Sign up/Login with GitHub
3. Click **"Add New"** → **"Project"**
4. Select your **RuralCare** GitHub repository
5. Configure:
   - **Framework**: `Vite`
   - **Root Directory**: `./frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`

6. **Add Environment Variables**:
   ```
   VITE_API_URL = https://ruralcare-backend.onrender.com/api
   ```
7. Click **"Deploy"** and wait (1-3 minutes)
8. **Copy your frontend URL** (e.g., `https://ruralcare-frontend.vercel.app`)

### Step 4: Connect Backend to Frontend (1 minute)

1. Go back to **Render Dashboard**
2. Select your **ruralcare-backend** service
3. Go to **Settings** → **Environment**
4. Update `FRONTEND_URL`:
   ```
   FRONTEND_URL = https://your-frontend.vercel.app
   ```
5. Service auto-redeploys

### Step 5: Test Your Deployment (1 minute)

1. Open your Vercel URL: `https://your-frontend.vercel.app`
2. Test the **Symptom Checker** to verify backend connection
3. Try the **Health Chatbot** to test API connectivity
4. Check browser console (F12) for any errors

---

## 🔑 Getting Your Groq API Key (Free)

1. Go to **https://console.groq.com**
2. Click **"Sign Up"** or **"Sign In"**
3. Complete registration
4. Go to **"API Keys"** section
5. Click **"Create New API Key"**
6. Copy the key and paste in Render environment variables
7. **Free tier includes**: 
   - Limited requests per month
   - Great for testing and development
   - Upgrade anytime if needed

---

## 📱 Testing Your Deployed Application

### Test 1: Frontend Loads
```
✅ Open https://your-frontend.vercel.app in browser
✅ Check if dashboard loads
✅ Verify no console errors (F12)
```

### Test 2: Backend Health Check
```
curl https://ruralcare-backend.onrender.com/api/health

Expected response:
{
  "status": "healthy",
  "version": "1.0.0",
  "environment": "production"
}
```

### Test 3: API Connectivity
```
From browser console:
fetch('/api/languages')
  .then(r => r.json())
  .then(d => console.log(d))
```

### Test 4: AI Features
1. Go to **Symptom Checker**
2. Enter symptoms (e.g., "fever, cough")
3. Should get AI-powered risk assessment

---

## 📚 Detailed Documentation

For complete step-by-step instructions with screenshots, see:
- **`DEPLOYMENT_GUIDE.md`** - Full deployment guide
- **`README.md`** - Project overview
- **`AI_FEATURES.md`** - All AI features documentation

---

## 💰 Cost Breakdown

### Free Tier (Recommended for Testing)
| Service | Free Cost | Limitations |
|---------|-----------|------------|
| Vercel Frontend | ✅ FREE | Unlimited |
| Render Backend | ✅ FREE | Sleeps after 15 min inactivity |
| Groq API | ✅ FREE | Limited requests/month |
| **Total** | **$0/month** | Works but with restrictions |

### Recommended Tier (Production)
| Service | Cost | Benefits |
|---------|------|----------|
| Vercel Frontend | FREE | Unlimited, fast |
| Render Backend | $7/month | Always running, faster |
| Groq API | ~$5/month | Unlimited requests |
| **Total** | **~$12/month** | Production-ready |

---

## 🐛 Troubleshooting

### Issue: "Backend connection failed"
**Solution**:
1. Check Render logs: Render Dashboard → Service → Logs
2. Verify `GROQ_API_KEY` is set correctly
3. Ensure `FRONTEND_URL` in Render matches your Vercel URL

### Issue: "Build failed on Render"
**Solution**:
1. Check Render logs for error details
2. Verify `Procfile` and `requirements.txt` are correct
3. Ensure Python 3.11 is selected

### Issue: "Build failed on Vercel"
**Solution**:
1. Check Vercel logs: Deployments → Select failed → Logs
2. Verify `vite.config.js` is correct
3. Ensure `npm run build` works locally

### Issue: "API calls return 404"
**Solution**:
1. Verify `VITE_API_URL` in Vercel environment variables
2. Trigger Vercel redeploy after updating env vars
3. Check browser Network tab to see actual API URLs being called

### Issue: "Render Backend keeps sleeping"
**Solution**: Upgrade to paid tier (Starter $7/month) to keep service always running

---

## 🔒 Security Checklist

- [ ] Never commit `.env` file to GitHub
- [ ] Use `.env.example` as template
- [ ] Keep `GROQ_API_KEY` in Render secrets only
- [ ] Update `FRONTEND_URL` after Vercel deployment
- [ ] Verify HTTPS is enabled (automatic on both platforms)
- [ ] Check CORS configuration is correct
- [ ] Monitor API usage on Groq console

---

## 📊 Monitoring & Logs

### Check Backend Logs
1. Go to **Render Dashboard**
2. Select your **ruralcare-backend** service
3. Click **"Logs"** tab
4. View real-time logs

### Check Frontend Logs
1. Go to **Vercel Dashboard**
2. Select your **ruralcare-frontend** project
3. Click **"Deployments"** tab
4. Select latest deployment → **"Logs"**

### Check API Usage
1. Go to **https://console.groq.com**
2. View usage statistics
3. Monitor token consumption

---

## 🚀 After Deployment

### Continuous Deployment
Both services support auto-deployment:
- **Push to GitHub** → Render auto-deploys backend
- **Push to GitHub** → Vercel auto-deploys frontend

### Update Applications
```bash
# Make changes locally
git add .
git commit -m "Update: [description]"
git push origin main

# Automatic deployment starts on both services!
```

### Monitoring in Production
- Set up error tracking (e.g., Sentry)
- Monitor API response times
- Check error logs regularly
- Review Groq API usage

---

## 🎓 Next Steps

1. ✅ **Deploy Now** - Follow Quick Start above
2. 📚 **Read Full Guide** - See `DEPLOYMENT_GUIDE.md`
3. 🧪 **Test Everything** - Use testing checklist
4. 📈 **Monitor** - Check logs regularly
5. 🔄 **Iterate** - Push updates via Git

---

## 📞 Resources

- **Render Docs**: https://render.com/docs
- **Vercel Docs**: https://vercel.com/docs
- **FastAPI Deploy**: https://render.com/docs/deploy-fastapi
- **Vite Deploy**: https://vitejs.dev/guide/static-deploy.html
- **Groq API**: https://console.groq.com/docs
- **Our Project Docs**: `README.md`, `AI_FEATURES.md`

---

## ✨ You're All Set!

Your RuralCare application is ready for production deployment. Follow the Quick Start above and you'll have a live, AI-powered healthcare system in just 5 minutes! 🎉

**Questions?** Check `DEPLOYMENT_GUIDE.md` for detailed troubleshooting and configuration options.

---

**Happy Deploying! 🚀🏥**
