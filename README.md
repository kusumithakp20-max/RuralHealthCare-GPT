# 🤖 AI Multimodal Rural Healthcare Assistant

An **advanced Generative AI-powered** web application designed to provide intelligent, personalized health guidance for rural communities with limited medical access.

## ✨ Key Highlights

This is a **comprehensive Generative AI project** featuring:
- ✅ **LLM-Powered Conversational AI** (Ollama/Groq)
- ✅ **Vision AI** for medical image analysis
- ✅ **Retrieval-Augmented Generation (RAG)** for knowledge-grounded responses
- ✅ **Multi-Language AI** translation (English, Hindi, Kannada, Tamil, Telugu)
- ✅ **AI-Generated Health Recommendations** tailored to individual users
- ✅ **Symptom Trend Analysis** with generative insights
- ✅ **Emergency Guidance** AI system
- ✅ **Hybrid AI** combining ML + Generative AI

## Core Features

### 🔍 AI-Powered Health Assessment
- **Symptom-Based Risk Prediction**: ML model + Generative AI fallback
- **Medical Image Analysis**: Vision AI for wounds, rashes, conditions
- **Personalized Recommendations**: AI-generated, context-aware health guidance
- **Detailed Health Analysis**: Comprehensive AI-generated medical insights
- **Symptom Trend Analysis**: AI recognition of health patterns over time

### 💬 Conversational AI
- **RAG-Based Chatbot**: LangChain with ChromaDB knowledge base
- **Streaming Responses**: Real-time AI interaction
- **Emergency Detection**: Automatic escalation for critical symptoms
- **Multi-Turn Conversations**: Context-aware dialogue history

### 🏥 Clinical Features
- **Emergency Guidance**: Immediate AI instructions for critical situations
- **PDF Report Generation**: AI-enhanced medical reports
- **Voice Support**: Speech-to-text and Text-to-speech
- **Multi-Language Support**: Indian language accessibility

## Tech Stack

### AI/ML Technologies
- **LLMs**: Ollama (local) or Groq (fast cloud)
- **VectorDB**: ChromaDB with HuggingFace embeddings
- **ML**: scikit-learn RandomForest
- **LLM Framework**: LangChain
- **Vision**: LLaVA or Groq Vision

### Frontend
- React, Tailwind CSS, Lucide Icons, Framer Motion
- Vite with API proxy to backend

### Backend
- FastAPI, Uvicorn
- Async/await for concurrent AI requests
- ReportLab for PDF generation

## Quick Start

### Backend Setup
```bash
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1  # Windows
source venv/bin/activate     # Linux/Mac
pip install -r requirements.txt
python -m app.main
# Server runs on http://localhost:8000
```

### Frontend Setup
```bash
cd frontend
npm install
npm run dev
# Dev server runs on http://localhost:3000 with API proxy
```

## 📚 Complete Generative AI API Documentation

See [AI_FEATURES.md](AI_FEATURES.md) for comprehensive documentation of:
- All 11+ generative AI endpoints
- Usage examples and payloads
- Model configuration
- Multi-language support details
- Performance metrics

### Key Endpoints
```
POST /api/chat                              # Conversational AI
POST /api/analyze-image                     # Vision AI analysis
POST /api/predict-risk                      # Symptom prediction
POST /api/ai/personalized-recommendations   # AI recommendations
POST /api/ai/detailed-analysis              # Detailed health analysis
POST /api/ai/symptom-trends                 # Trend analysis
POST /api/ai/emergency-guidance             # Emergency response
POST /api/ai/translate                      # Multi-language translation
POST /api/ai/health-summary                 # Complete health summary
POST /api/generate-report                   # AI-enhanced PDF reports
```

## 🔧 Configuration

### Environment Variables (.env)
```bash
# LLM Selection
GROQ_API_KEY=your_groq_key          # For fast cloud LLM (optional)
GROQ_MODEL=llama3-8b-8192           # Default Groq model
GROQ_VISION_MODEL=llama-3.2-11b-vision-preview

# Local LLM (Ollama)
OLLAMA_BASE_URL=http://localhost:11434
OLLAMA_MODEL=llama3
OLLAMA_VISION_MODEL=llava
```

## 🎯 Use Cases

1. **Rural Health Centers**: Quick patient assessment
2. **Emergency First Response**: Immediate guidance
3. **Health Education**: Disease information
4. **Patient Monitoring**: Symptom tracking over time
5. **Regional Healthcare**: Multi-language support
6. **Report Documentation**: Professional PDF generation
7. **Preventive Care**: Health trend analysis

## 🏆 What Makes This a Generative AI Project

- ✅ Multiple LLM-powered features (chat, analysis, translation, recommendations)
- ✅ Advanced prompt engineering for healthcare context
- ✅ RAG system for knowledge-grounded responses
- ✅ Vision AI for medical image understanding
- ✅ Text generation for reports and recommendations
- ✅ Multi-language generation
- ✅ Streaming AI responses
- ✅ Hybrid approach combining ML + Generative AI

## ⚠️ Safety Disclaimer
This application provides **AI-generated preliminary health guidance** and first-aid information. It is **NOT** a substitute for professional medical diagnosis or treatment. Always consult a qualified healthcare professional for medical advice. In case of emergency, call local emergency services (e.g., **108 in India**).

## 📄 License
MIT

---

**Made for rural healthcare accessibility with ❤️ and AI** 🏥✨
