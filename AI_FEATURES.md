# 🤖 RuralCare - Generative AI Healthcare Assistant
## Complete Documentation of AI Features

### Project Overview
RuralCare is a **comprehensive Generative AI-powered healthcare system** designed specifically for rural communities with limited medical access. It combines multiple AI technologies to provide accessible, personalized health guidance.

---

## 🎯 Core Generative AI Features

### 1. **Conversational AI Chatbot**
- **Technology**: LangChain + Ollama/Groq LLM
- **Capability**: Natural language health consultations
- **Features**:
  - Context-aware responses using RAG (Retrieval-Augmented Generation)
  - Real-time streaming responses
  - Conversation history tracking
  - Emergency detection and escalation
  - Empathetic responses for rural users

**API Endpoints**:
```
POST /api/chat
POST /api/chat-stream
```

**Example**:
```json
{
  "message": "I have fever and body aches for 3 days",
  "history": [{"role": "user", "content": "..."}]
}
```

---

### 2. **Medical Image Analysis (Vision AI)**
- **Technology**: Groq Vision or LLaVA (Ollama)
- **Capability**: AI-powered analysis of medical images
- **Features**:
  - Skin condition detection
  - Wound assessment
  - Rash identification
  - Risk level classification
  - Base64 image encoding support

**API Endpoints**:
```
POST /api/analyze-image
```

**Use Cases**: Skin infections, burns, wounds, insect bites

---

### 3. **Symptom Prediction with Generative Fallback**
- **Technology**: Machine Learning + Generative AI
- **Capability**: Predict medical conditions from symptoms
- **Features**:
  - RandomForest ML model for common diseases
  - Fallback to generative AI for unknown symptoms
  - Confidence scoring
  - Risk level classification (Low/Moderate/High/Critical)

**API Endpoints**:
```
POST /api/predict-risk
```

---

### 4. **Retrieval-Augmented Generation (RAG)**
- **Technology**: LangChain + ChromaDB + HuggingFace Embeddings
- **Capability**: Knowledge-grounded AI responses
- **Features**:
  - Vector database of medical FAQs
  - Semantic similarity search
  - Context injection into LLM prompts
  - Medical knowledge base integration
  - Fast similarity search using embeddings

**Data Source**: `data/medical_faqs.md`

---

### 5. **⭐ NEW: Personalized AI Recommendations**
- **Technology**: Generative AI with contextual awareness
- **Capability**: Generate personalized health recommendations
- **Features**:
  - Age-aware guidance
  - Location-specific advice (rural accessibility)
  - Allergy considerations
  - Immediate actions vs long-term care
  - Food and lifestyle recommendations
  - Preventive measures

**API Endpoints**:
```
POST /api/ai/personalized-recommendations
```

**Request**:
```json
{
  "symptoms": ["fever", "cough"],
  "condition": "Common Cold",
  "risk_level": "Low",
  "user_context": {
    "age": 45,
    "location": "Rural Karnataka",
    "allergies": ["penicillin"]
  }
}
```

---

### 6. **⭐ NEW: Detailed Health Analysis**
- **Technology**: Generative AI with multi-section output
- **Capability**: Comprehensive medical analysis
- **Features**:
  - Condition overview
  - Symptom explanation
  - Risk assessment
  - Immediate care instructions
  - Follow-up care plans
  - Diet and lifestyle recommendations
  - Medical consultation guidance
  - **Multi-language support** (English, Hindi, Kannada, Tamil, Telugu)

**API Endpoints**:
```
POST /api/ai/detailed-analysis
```

**Request**:
```json
{
  "symptoms": ["high_fever", "fatigue"],
  "condition": "Malaria",
  "medical_history": ["diabetes"],
  "language": "kn"  // Kannada
}
```

---

### 7. **⭐ NEW: Symptom Trend Analysis**
- **Technology**: Generative AI with temporal analysis
- **Capability**: Analyze health patterns over time
- **Features**:
  - Trend direction analysis (improving/worsening/stable)
  - Pattern recognition
  - Health trajectory insights
  - Recommendation generation based on trends
  - Red flag identification

**API Endpoints**:
```
POST /api/ai/symptom-trends
```

**Request**:
```json
{
  "symptom_history": [
    {"symptoms": "mild_headache", "severity": "low", "date": "2024-05-18"},
    {"symptoms": "severe_headache", "severity": "high", "date": "2024-05-19"},
    {"symptoms": "fever_headache", "severity": "high", "date": "2024-05-20"}
  ],
  "time_period_days": 30
}
```

---

### 8. **⭐ NEW: Emergency Guidance**
- **Technology**: Generative AI with crisis optimization
- **Capability**: Immediate emergency response
- **Features**:
  - Fast, action-oriented instructions
  - Step-by-step guidance
  - Emergency hotline information (India: 108)
  - Transport instructions
  - What to tell doctors
  - Critical DO NOTs

**API Endpoints**:
```
POST /api/ai/emergency-guidance
```

**Use Case**: Chest pain, severe breathing difficulty, loss of consciousness

---

### 9. **⭐ NEW: Multi-Language Translation**
- **Technology**: Generative AI translation
- **Capability**: Translate health information to regional languages
- **Features**:
  - Maintains medical accuracy
  - Preserves formatting
  - Supports 5 Indian languages
  - Fast, AI-powered translation
  - No external API dependencies

**API Endpoints**:
```
POST /api/ai/translate
```

**Supported Languages**:
- English (en)
- Hindi (hi)
- Kannada (kn)
- Tamil (ta)
- Telugu (te)

---

### 10. **⭐ NEW: Comprehensive Health Summary**
- **Technology**: Multi-AI orchestration
- **Capability**: Generate complete health reports
- **Features**:
  - Combines multiple AI analyses
  - Optional detailed medical analysis
  - Structured data format
  - Ready for PDF report generation
  - Includes timestamps and metadata

**API Endpoints**:
```
POST /api/ai/health-summary
```

---

### 11. **AI-Enhanced Report Generation**
- **Technology**: ReportLab + Generative AI
- **Capability**: Generate professional PDF health reports
- **Features**:
  - AI-generated insights in reports
  - Patient information sections
  - Assessment tables
  - Recommendations formatting
  - Emergency care guidelines
  - Professional disclaimers
  - Multi-page support

**API Endpoints**:
```
POST /api/generate-report
```

---

## 🔧 Technology Stack

### LLM Providers
1. **Ollama** (Local, Privacy-focused)
   - Model: llama3 (default)
   - Vision Model: llava
   - Base URL: http://localhost:11434

2. **Groq** (Fast, Cloud-based)
   - API Key: `GROQ_API_KEY`
   - Model: llama3-8b-8192 (default)
   - Vision Model: llama-3.2-11b-vision-preview

### Vector Database & Embeddings
- **VectorDB**: ChromaDB
- **Embeddings**: HuggingFace (all-MiniLM-L6-v2)
- **Fallback**: Ollama Embeddings

### ML/Data Processing
- **ML**: scikit-learn (RandomForest)
- **Data**: pandas
- **NLP**: LangChain
- **PDF**: ReportLab

---

## 📊 Model Configuration

### System Prompts
All AI models use carefully engineered system prompts that:
- Provide medical disclaimers
- Emphasize rural healthcare context
- Include emergency escalation guidelines
- Promote empathy and accessibility

### Temperature Settings
- **Chat**: 0.4 (Factual, consistent)
- **Image Analysis**: 0.2 (Objective)
- **Insights**: 0.6 (Creative, nuanced)

---

## 🌍 Multi-Language Support

All major features support 5 Indian languages:
- **English**: Full support
- **Hindi (hi)**: Via AI translation
- **Kannada (kn)**: Via AI translation
- **Tamil (ta)**: Via AI translation
- **Telugu (te)**: Via AI translation

---

## 📱 Frontend Integration

### API Configuration
```javascript
// frontend/src/api.js
const API_BASE = '/api';  // Proxies to backend on :8000
```

### Vite Dev Server Proxy
```javascript
server: {
  proxy: {
    '/api': 'http://localhost:8000',
    '/reports': 'http://localhost:8000',
    '/uploads': 'http://localhost:8000'
  }
}
```

---

## 🚀 Running the Project

### Start Backend
```bash
cd backend
..\venv\Scripts\Activate.ps1
python -m app.main
# Server runs on http://localhost:8000
```

### Start Frontend
```bash
cd frontend
npm run dev
# Dev server runs on http://localhost:3000
# Automatically proxies to backend
```

---

## 📚 Complete API Reference

### Health Assessment
- `POST /api/predict-risk` - Predict condition from symptoms
- `POST /api/analyze-image` - Analyze medical images

### Conversational
- `POST /api/chat` - Single response chat
- `POST /api/chat-stream` - Streaming responses

### Generative AI (NEW)
- `POST /api/ai/personalized-recommendations` - Custom health recommendations
- `POST /api/ai/detailed-analysis` - Comprehensive health analysis
- `POST /api/ai/symptom-trends` - Temporal symptom pattern analysis
- `POST /api/ai/emergency-guidance` - Emergency response instructions
- `POST /api/ai/translate` - Multi-language translation
- `POST /api/ai/health-summary` - Complete health summary

### Reports
- `POST /api/generate-report` - Generate PDF health report
- `GET /api/languages` - Get supported languages

---

## 🔒 Privacy & Security

### Local-First Options
- Use Ollama for 100% local AI
- No data sent to external servers
- ChromaDB stores embeddings locally

### Cloud Option (Optional)
- Groq API for faster responses
- API key-based authentication
- Optional fallback to local

---

## 📈 Performance

### Response Times
- **Chat**: 2-5 seconds (Groq), 5-15 seconds (Ollama)
- **Image Analysis**: 3-8 seconds
- **Recommendations**: 3-6 seconds
- **Trends Analysis**: 2-4 seconds

### Scalability
- Async/await for concurrent requests
- Streaming for real-time responses
- Vector DB for efficient retrieval

---

## 🎓 Use Cases

1. **Rural Clinics**: Quick symptom assessment
2. **Emergency First-Aid**: Immediate guidance
3. **Health Education**: Disease information
4. **Report Generation**: Documentation
5. **Multi-Lingual Support**: Regional languages
6. **Preventive Care**: Health trends tracking
7. **Patient Follow-up**: Historical analysis

---

## 🐛 Troubleshooting

### Ollama Not Responding
```
Error: Failed to connect to http://localhost:11434
Fix: Run `ollama serve` in another terminal
```

### Groq API Issues
```
Error: GROQ_API_KEY not found
Fix: Add GROQ_API_KEY to .env file
```

### No Vector Store
```
Error: Vector DB not found
Fix: medical_faqs.md will be automatically indexed on startup
```

---

## 📝 Example Workflows

### Workflow 1: Complete Health Assessment
```
1. User enters symptoms → /api/predict-risk
2. Get AI recommendations → /api/ai/personalized-recommendations
3. Get detailed analysis → /api/ai/detailed-analysis
4. Generate report → /api/generate-report
```

### Workflow 2: Emergency Response
```
1. User reports emergency symptoms
2. Detect emergency keywords in chat
3. Trigger → /api/ai/emergency-guidance
4. Provide immediate action steps
```

### Workflow 3: Multi-Language Support
```
1. Get health information in English
2. Translate to user's language → /api/ai/translate
3. Display in preferred language
```

---

## 🎉 Key Achievements

✅ **Truly Generative AI**: Multiple LLM-powered features
✅ **Rural Focused**: Practical, accessible guidance
✅ **Multi-Language**: 5 Indian languages supported
✅ **Hybrid AI**: ML + Generative AI combination
✅ **Privacy Options**: Local or cloud LLM
✅ **Production Ready**: Error handling, fallbacks
✅ **Streaming**: Real-time AI responses
✅ **Vision AI**: Medical image analysis
✅ **RAG System**: Knowledge-grounded responses
✅ **Full Stack**: Frontend + Backend integration

---

## 📞 Support

For issues or questions:
1. Check error logs in terminal
2. Ensure backend is running on :8000
3. Ensure frontend proxy is configured
4. Check Ollama or Groq connection
5. Review .env configuration

---

**RuralCare: Making AI-Powered Healthcare Accessible to Everyone** 🏥✨
