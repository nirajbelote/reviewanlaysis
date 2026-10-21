# 🚀 GitHub & Cloud Deployment Guide — ReviewIQ AI

This guide walks you through publishing **ReviewIQ AI** to your GitHub repository and deploying it live on the web (Vercel, Netlify, Render, Railway, or Docker).

---

## 📁 1. Project Files Ready For GitHub

Your workspace (`C:\Users\niraj\OneDrive\Desktop\review`) contains all required production assets:

```text
review/
├── .github/
│   └── workflows/
│       └── ci.yml               # Automated GitHub Actions test & build workflow
├── backend/
│   ├── app/                     # FastAPI backend & ABSA NLP pipeline
│   ├── tests/                   # 21 unit & integration tests
│   ├── scripts/                 # Database seed & migration utilities
│   ├── reviewiq.db              # Pre-seeded SQLite database (205 products, 10,653 reviews)
│   ├── requirements.txt         # Python dependencies
│   └── Dockerfile               # Backend container configuration
├── frontend/
│   ├── src/                     # React 19 + TypeScript + Tailwind CSS UI
│   ├── public/                  # Static assets
│   ├── package.json             # NPM package definitions
│   ├── vercel.json              # Vercel SPA routing configuration
│   ├── netlify.toml             # Netlify SPA configuration
│   └── Dockerfile               # Frontend Nginx production container
├── data/
│   ├── sample_reviews.csv       # Starter reviews dataset
│   ├── large_reviews.csv        # Scaled ABSA dataset
│   └── training/                # Labeled training sets for ML classifier
├── docker-compose.yml           # Turnkey multi-service container configuration
├── .gitignore                   # Ignores node_modules, cache, and temporary files
├── .env.example                 # Environment variable templates
└── README.md                    # Comprehensive college project documentation
```

---

## 🐙 2. How to Push to GitHub

### Option A: Using Git CLI (Recommended)

1. Open PowerShell or Terminal in this folder (`C:\Users\niraj\OneDrive\Desktop\review`):
   ```bash
   # Initialize git repository
   git init

   # Stage all files
   git add .

   # Commit
   git commit -m "feat: ReviewIQ AI full-stack platform with real products, retail links, and ABSA NLP"

   # Rename branch to main
   git branch -M main

   # Link to your new empty GitHub repository (create one on https://github.com/new)
   git remote add origin https://github.com/<YOUR_USERNAME>/<YOUR_REPOSITORY_NAME>.git

   # Push code to GitHub
   git push -u origin main
   ```

*(Note: If Git is not yet installed on your PC, download it from [https://git-scm.com/download/win](https://git-scm.com/download/win) or use GitHub Desktop below).*

---

### Option B: Using GitHub Desktop (Graphical UI)

1. Download and install [GitHub Desktop](https://desktop.github.com/).
2. Click **File** &rarr; **Add Local Repository...**.
3. Select this folder: `C:\Users\niraj\OneDrive\Desktop\review`.
4. If prompted that the folder is not a Git repository, click **create a repository here**.
5. Type summary: *"Initial commit: ReviewIQ AI"* and click **Commit to main**.
6. Click **Publish repository** to push it directly to your GitHub profile.

---

### Option C: Direct Web Upload

1. Go to [https://github.com/new](https://github.com/new) and create a repository called `reviewiq-ai`.
2. Click **uploading an existing file**.
3. Drag and drop the contents of this folder into GitHub and click **Commit changes**.

---

## 🌐 3. Deploying Frontend to Vercel (1-Click, Free)

1. Go to [https://vercel.com](https://vercel.com) and log in with GitHub.
2. Click **Add New Project** and select your `reviewiq-ai` repository.
3. Configure settings:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`
4. Under **Environment Variables**, add:
   - `VITE_API_URL` = `<YOUR_BACKEND_PUBLIC_URL>` (or leave blank to use mock/proxy)
5. Click **Deploy**. Vercel will build and assign you a live HTTPS domain (e.g. `https://reviewiq-ai.vercel.app`).

---

## 🖥️ 4. Deploying Backend to Render / Railway (Free)

### Deploying on Render ([https://render.com](https://render.com)):
1. Create a **New Web Service** connected to your GitHub repository.
2. Settings:
   - **Root Directory**: `backend`
   - **Environment**: Python
   - **Build Command**: `pip install -r requirements.txt`
   - **Start Command**: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
3. Environment Variables:
   - `SECRET_KEY` = `your-super-secret-jwt-key`
   - `ENVIRONMENT` = `production`
4. Click **Create Web Service**.

---

## 🐳 5. Running with Docker Compose (Local or Cloud VPS)

Run the full stack with one command on any Linux/Mac/Windows server with Docker installed:

```bash
docker compose up --build -d
```

- Frontend will be accessible at: `http://localhost:5173`
- Backend API will be accessible at: `http://localhost:8000/docs`
