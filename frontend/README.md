# Connectra Web Client

The modern frontend interface for **Connectra**, built with Next.js 16 (App Router), React 19, Tailwind CSS 4, and Zustand.

## Features
- **Feed & Timeline**: Infinite scrolling social feed with image uploads, inline comments, and instant likes.
- **Direct Messaging**: Low-latency WebSocket chat powered by Socket.IO with unread badges and chat history paging.
- **Online Presence**: Real-time user connectivity and active status indicators.
- **Audio Synthesis**: Zero-dependency Web Audio API notification and message beeps.
- **Responsive Layout**: Tailwind CSS 4 adaptive layouts with mobile drawer menus and glassmorphism styling.

## Getting Started

### 1. Install Dependencies
```bash
npm install
# or
npm ci
```

### 2. Configure Environment Variables
Copy `.env.example` to `.env.local`:
```bash
cp .env.example .env.local
```
Set `NEXT_PUBLIC_API_URL` (default: `http://localhost:5000`).

### 3. Run Development Server
```bash
npm run dev
```
Open [http://localhost:3000](http://localhost:3000) to view the application.

### 4. Build for Production
```bash
npm run build
npm start
```

### 5. Run E2E Tests
```bash
npm run test:e2e
```
