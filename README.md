# ReviewIQ AI — AI-Based Product Review Analysis Using NLP

> **Subtitle:** Aspect-Based Sentiment Analysis (ABSA) of Customer Reviews  
> **Tagline:** *Turn Customer Opinions into Actionable Intelligence.*

---

## 1. Project Overview

**ReviewIQ AI** is a production-grade, full-stack Artificial Intelligence and Natural Language Processing (NLP) web platform designed to analyze customer product reviews at the **granular aspect level**.

Standard sentiment analysis classifiers reduce an entire review into a monolithic *Positive* or *Negative* label. However, real-world customer opinions are complex and multidimensional:

> *"The camera is excellent and the display looks beautiful, but the battery drains quickly and the price is too high."*

ReviewIQ AI parses clauses, isolates individual product aspects, and identifies the distinct sentiment associated with each feature:
- **Camera:** Positive
- **Display:** Positive
- **Battery:** Negative
- **Price:** Negative
- **Overall Review Sentiment:** Mixed

The platform currently catalogs **205 consumer electronic products** across 10 categories with **10,653 analyzed customer reviews** (exceeding 50 reviews per product), powered by an offline, CPU-friendly Machine Learning pipeline.

---

## 2. Key Features

- **Real Aspect-Based Sentiment Analysis (ABSA):** Multi-stage NLP engine decomposing reviews into clauses, detecting 12 canonical hardware/software aspects, extracting context evidence, and classifying polarity.
- **Mixed Sentiment & Negation Handling:** Correctly handles adversative contrasts (*"camera is great, but battery is poor"*) and nuanced negations (*"battery is not bad"*, *"not worth the price"*, *"barely lasts"*).
- **Executive Analytics Dashboard:** Real-time statistics calculated from database records: sentiment distribution pie charts, aspect-level frequency bars, and top praised vs. criticized aspects.
- **Dedicated Review Analyzer:** Interactive workbench with instant ABSA parsing, highlighted trigger keywords, calibrated confidence meters, and transparent reasoning explanations.
- **Bulk CSV Analysis & Export:** Drag-and-drop CSV batch processor with column auto-mapping and one-click export of analyzed results with aspect breakdown columns.
- **Product Catalog (200+ Products):** Searchable, paginated directory of 205 products across 10 categories with aspect sentiment summaries and detailed product intelligence pages.
- **Aspect Deep-Dive Analytics:** Interactive charts comparing sentiment distributions, frequent praise quotes, and customer complaint excerpts across aspects.
- **Product Showdown & Comparison:** Side-by-side aspect comparison matrix comparing 2 to 4 products with grouped bar charts.
- **Complaint Discovery:** Automatically isolates customer complaints, failure patterns, and negative quotes grouped by aspect and product.
- **Authentic Model Evaluation:** Real scikit-learn metrics computed on held-out benchmark test sets (90.0% accuracy, 0.900 F1-score, confusion matrix, precision/recall table).
- **Dataset Management & Custom Import:** Real-time summary of database records, category distributions, synthetic provenance disclosures, and custom dataset importer.
- **Secure Authentication & User Isolation:** Argon2/Bcrypt password hashing with JWT bearer tokens. Each user's saved review history is strictly isolated.
- **Liquid Glass / Glassmorphism UI:** Translucent frosted cards, subtle gradients, responsive mobile drawer, and Dark Mode / Light Mode / System Default persistence.

---

## 3. Technology Stack

| Layer | Technologies |
|---|---|
| **Frontend** | React 19, TypeScript, Vite 8, Tailwind CSS v4, Lucide React, React Router 7, Axios, Recharts |
| **Backend** | Python 3.11, FastAPI, Pydantic v2, SQLAlchemy 2, Uvicorn |
| **AI / NLP** | scikit-learn, TF-IDF Vectorizer (1,2-grams), L2 Logistic Regression, LinearSVC Baseline, Custom Clause Segmenter & Lexicon Negation Engine |
| **Database** | SQLite (Default, high-concurrency WAL mode), SQLAlchemy ORM (PostgreSQL ready) |
| **Testing** | Pytest, FastAPI TestClient, 21 Automated Unit & Integration Tests |

---

## 4. NLP Architecture & Methodology

ReviewIQ AI uses a modular 8-stage NLP pipeline:

```
[Raw Review Input]
       │
       ▼
1. Input Normalization & Empty Text Validation
       │
       ▼
2. Clause Splitting & Conjunction Boundary Detection
   (Splits sentences on: but, however, although, yet, while, ;, .)
       │
       ▼
3. Aspect Extraction & Canonical Normalization
   (Matches terms against 12 canonical lexicons & synonyms)
       │
       ▼
4. Context Window Negation Analysis
   (Detects negations within a 3-token window: "not bad", "barely lasts")
       │
       ▼
5. Machine Learning Sentiment Polarity Classification
   (TF-IDF + L2-regularized Logistic Regression with calibrated probabilities)
       │
       ▼
6. Aspect-Level Mixed Resolution
   (Flags Mixed when opposing opinions target the same aspect in one review)
       │
       ▼
7. Overall Sentiment Synthesis
   (Aggregates aspect polarities: Positive, Negative, Neutral, or Mixed)
       │
       ▼
8. Natural Language Explanation & Evidence Extraction
   (Extracts exact quote clauses, trigger tokens, and synthesized reasoning)
```

### Supported Canonical Aspects
1. **Camera:** photos, zoom, portrait, selfie, night mode, megapixels, video recording
2. **Battery:** battery life, battery backup, standby, screen on time, drainage, power
3. **Display:** screen, AMOLED, OLED, 120Hz, refresh rate, brightness, nits, resolution
4. **Performance:** speed, processor, chipset, Snapdragon, RAM, lag, stutter, gaming, multitasking
5. **Price:** cost, pricing, expensive, affordable, budget, overpriced, value for money, deal
6. **Design:** looks, aesthetics, ergonomics, thin, sleek, bezels, weight, form factor
7. **Build quality:** materials, titanium, aluminum, glass back, frame, solid feel, hinge
8. **Audio and speakers:** stereo speakers, volume, sound quality, bass, microphone, Dolby
9. **Software and user interface:** UI, OS, Android, skin, updates, bloatware, gestures
10. **Connectivity:** 5G, Wi-Fi, Bluetooth, network reception, signal, GPS, call drops
11. **Charging:** fast charging, 80W/100W, wireless charging, USB-C, charger in box
12. **Durability:** scratch resistance, Gorilla Glass, drop test, waterproof, IP68 rating

---

## 5. Model Evaluation Metrics

Evaluated on held-out benchmark test data using a reproducible stratified 80/20 train/test split:

- **Accuracy:** `90.0%`
- **Macro F1-Score:** `0.900`
- **Weighted F1-Score:** `0.900`
- **Baseline Comparison (Linear SVM):** `88.3%`

### Confusion Matrix
| Actual \ Predicted | Negative | Neutral | Positive |
|---|---|---|---|
| **Negative** | 43 | 1 | 2 |
| **Neutral** | 4 | 22 | 1 |
| **Positive** | 2 | 2 | 43 |

---

## 6. Project Structure

```
review/
├── backend/
│   ├── app/
│   │   ├── api/             # FastAPI REST endpoint routers
│   │   │   ├── auth.py      # Registration, login, JWT me
│   │   │   ├── products.py  # Catalog, details, reviews
│   │   │   ├── analysis.py  # Single & bulk ABSA analysis
│   │   │   ├── analytics.py # Dashboard, aspects, compare, complaints
│   │   │   ├── model.py     # Specs & evaluation metrics
│   │   │   ├── dataset.py   # Dataset summary & CSV uploader
│   │   │   ├── deps.py      # Auth & DB dependencies
│   │   │   └── api_router.py
│   │   ├── core/            # Config, settings, bcrypt & JWT security
│   │   ├── database/        # SQLAlchemy engine & session maker
│   │   ├── models/          # User, Product, Review, ReviewAnalysis, AspectResult
│   │   ├── nlp/             # Preprocessor, AspectExtractor, Classifier, Pipeline, Evaluator
│   │   │   └── saved_models/# Serialized scikit-learn model
│   │   ├── schemas/         # Pydantic validation schemas
│   │   ├── services/        # Business logic services
│   │   └── main.py          # FastAPI application entry point
│   ├── scripts/             # Seeding, training, generation & verification scripts
│   ├── tests/               # 21 automated pytest test cases
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── components/      # Navbar, Sidebar, MobileDrawer, GlassCard, Badges, Meters
│   │   ├── context/         # AuthContext (JWT) & ThemeContext (Dark/Light/System/Glass)
│   │   ├── pages/           # All 15 application pages
│   │   ├── services/        # Axios API client with bearer token interceptor
│   │   ├── types/           # TypeScript data interfaces
│   │   ├── App.tsx          # Master router
│   │   ├── main.tsx
│   │   └── index.css        # Glassmorphism & theme styles
│   ├── package.json
│   ├── tailwind.config.js
│   ├── vite.config.ts
│   └── index.html
├── data/
│   ├── sample_reviews.csv   # 125 curated reviews across 5 core products
│   ├── large_reviews.csv    # 10,000 reviews across 200 products
│   └── training/            # Labeled ABSA training dataset
├── .env.example
├── .gitignore
├── start_backend.bat        # Windows one-click backend launcher
├── start_frontend.bat       # Windows one-click frontend launcher
├── run_tests.bat            # Windows one-click test runner
└── README.md
```

---

## 7. Windows Setup & Execution Guide

### Prerequisites
- Python 3.10+ (Verified on Python 3.11.9)
- Node.js 18+ (Verified on v24.15.0 with npm 11)
- Git (optional)

### Step 1: Clone or Open Workspace
Open the folder in **VS Code**:
```powershell
cd c:\Users\niraj\OneDrive\Desktop\review
```

### Step 2: Install Backend Dependencies
```powershell
cd backend
python -m pip install -r requirements.txt
cd ..
```

### Step 3: Seed Database (Quick or Full)
The database has already been seeded with **205 products** and **10,653 reviews**. To re-seed or test idempotency:
- **Core 5 products (Quick mode ~125 reviews):**
  ```powershell
  python backend\scripts\seed_database.py --mode quick
  ```
- **Full 200+ products (10,000+ reviews):**
  ```powershell
  python backend\scripts\seed_database.py --mode full
  ```

### Step 4: Run the Backend Server
```powershell
.\start_backend.bat
# Or manually:
cd backend
python -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```
The FastAPI backend runs at `http://127.0.0.1:8000`.  
Interactive Swagger API documentation is available at `http://127.0.0.1:8000/docs`.

### Step 5: Start the Frontend Application
In a second terminal window:
```powershell
.\start_frontend.bat
# Or manually:
cd frontend
npm run dev
```
Open `http://localhost:5173` in any modern web browser.

---

## 8. Default Credentials for Testing

- **Email:** `demo@reviewiq.ai`
- **Password:** `password123`
- *(Or use the "Use Demo Account" quick button on the Login page)*
- New users can also register on the `/register` page with duplicate-email detection and password validation.

---

## 9. Running Automated Tests

Run the complete 21-test test suite covering Authentication, NLP Polarity, Negation, Multi-Aspect Splitting, Dataset Volumes, and Analytics:

```powershell
.\run_tests.bat
# Or directly:
cd backend
python -m pytest tests -v
```

To run the live API integration verification across all 13 endpoints:
```powershell
python backend\scripts\verify_live_api.py
```

To verify the frontend TypeScript and Vite production build:
```powershell
cd frontend
npm run build
```

---

## 10. Responsible AI & Limitations Disclosure

- **Synthetic Demonstration Dataset:** The 205 products and 10,653 reviews are synthetic demonstration reviews labeled with `source_type='synthetic_demo'`. They are designed to demonstrate multi-aspect feedback and clause contrasts and do not represent verified commercial marketplace feedback.
- **Model Predictions:** Polarity classifications are probabilistic statistical estimates from a TF-IDF + Logistic Regression model. Sarcasm, regional colloquialisms, and heavy internet slang may affect accuracy.
- **Zero External API Cost:** The system runs completely offline on standard CPU hardware without requiring paid OpenAI/Anthropic API keys or expensive GPU clusters.

---

## 11. College Project Demonstration Script

When presenting ReviewIQ AI for a college demo or evaluation:

1. **Introduction:** Open `http://localhost:5173`. Show the landing page and explain how aspect-based sentiment analysis differs from basic review-level sentiment.
2. **Live Interactive Sandbox:** Paste the sample sentence: *"The camera is excellent and the display looks beautiful, but the battery drains quickly and the price is too high."* Click **Run Live Analysis** to show how the system detects all four aspects with opposite polarities and outputs an overall *Mixed* sentiment with evidence sentences.
3. **Executive Dashboard:** Navigate to `/dashboard`. Highlight that all charts and statistics are computed from 205 products and 10,653 reviews in the SQLite database.
4. **Product Catalog & Showdown:** Go to `/products` and `/compare`. Select 3 products (e.g., Nova X Pro, PixelWave 9, GalaxySphere S25) to display the aspect showdown matrix and grouped bar charts.
5. **Bulk CSV Upload & Export:** Go to `/bulk-analysis` and upload a CSV of customer reviews. Show the instant batch classification and download the analyzed CSV with aspect columns.
6. **Model Evaluation Page:** Go to `/model-evaluation` and explain the 90.0% test accuracy, confusion matrix, precision/recall table, and comparison against Linear SVM.
7. **User Authentication:** Log in with `demo@reviewiq.ai` / `password123`. Show the private `/history` page and demonstrate that private review histories are strictly isolated per user account.
8. **Liquid Glass & Theme Toggle:** Toggle Dark Mode, Light Mode, and the Liquid Glass effect in the top navigation bar to demonstrate the responsive UI design.
