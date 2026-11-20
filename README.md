# PeakCut AI Clipper 🎬

Turn long videos and live streams into viral, captioned vertical shorts (9:16) with AI. Free and open source: run it entirely on your own computer or server with your own AI key.

Paste any YouTube, Twitch, or Kick link (or upload an MP4 file) and PeakCut automatically transcribes the audio, detects the most engaging moments, crops the video to vertical format (with facecam detection), burns in animated word-by-word captions, and generates unique viral hooks and titles.

---

## ✨ Key Features

- 🤖 **Context-Aware AI Captions & Hooks**: Automatically generates unique, punchy viral hooks, titles, descriptions, and hashtags for every clip based on its actual spoken words using Google Gemini or OpenAI. No static or repetitive titles.
- 💾 **Instant Save vs Re-make Video**: Dedicated **"Save details"** button updates post titles, descriptions, and metadata instantly without slow re-renders. A separate **"Re-make video"** button re-encodes with FFmpeg only when timing, caption styles, or layouts change.
- 💬 **Spoken Subtitles Without Clutter**: Top heading banner text is disabled on videos by default so only clean, spoken-word dialogue captions appear. Optional heading banner can be toggled per clip if desired.
- 🎮 **Gameplay + Facecam Layout**: Automatically detects streamer webcams using vision AI and edge detection, keeping the full gameplay centered while placing the facecam as a clean Picture-in-Picture (PIP) in the corner.
- ⚡ **Hardware Acceleration**: Built-in support for **Apple Silicon VideoToolbox (`h264_videotoolbox`)**, Intel QuickSync (`h264_qsv`), and `libx264` for ultra-fast, smooth video export without timeouts.
- 📝 **Synced Animated Subtitles**: Word-level subtitle animation with multiple stylish presets:
  - **Bounce**: Colorful popping words with animated highlight states.
  - **Hype**: Bold, impactful uppercase text.
  - **Clean**: Elegant, modern subtitle layout.
- 📦 **Bulk Edit & Batch Actions**: Select multiple or all clips across videos to batch change layouts, switch caption styles, or regenerate AI titles in one click.
- 🔴 **Real-time Live Stream Clipping**: Monitor live streams on YouTube, Twitch, or Kick, recording into a rolling buffer and clipping spikes in loudness, chat activity, and keywords.
- 📱 **Multi-Platform Auto-Posting**: Connect YouTube, Instagram, and TikTok to schedule or publish finished shorts directly from the dashboard.
- 🔒 **Privacy-First & Zero Lock-in**: Everything runs locally. Videos and database stay on your machine. Bring your own free Gemini API key or local Ollama models.

---

## 📋 Prerequisites

Before installing, ensure you have the following installed on your system:

1. **Python 3.10 or newer**:
   - Check version: `python3 --version`
2. **FFmpeg**:
   - **macOS**: `brew install ffmpeg`
   - **Windows**: `winget install Gyan.FFmpeg` (or download from [gyan.dev](https://www.gyan.dev/ffmpeg/builds/))
   - **Linux (Ubuntu/Debian)**: `sudo apt update && sudo apt install ffmpeg`

---

## 🚀 Step-by-Step Installation Guide

### 1. Clone the Repository

Choose a permanent folder on your drive:
- **macOS / Linux**:
  ```bash
  git clone https://github.com/arnavarya001/PeakCut-Clipping.git ~/peakcut
  cd ~/peakcut
  ```
- **Windows**:
  ```powershell
  git clone https://github.com/arnavarya001/PeakCut-Clipping.git C:\peakcut
  cd C:\peakcut
  ```
*(Note: On Windows, use a short path like `C:\peakcut` to avoid Windows 260-character path limits).*

---

### 2. Set Up Python Virtual Environment

Create and activate a virtual environment:

- **macOS / Linux**:
  ```bash
  python3 -m venv .venv
  source .venv/bin/activate
  ```

- **Windows (Command Prompt / PowerShell)**:
  ```powershell
  python -m venv .venv
  .venv\Scripts\activate
  ```

---

### 3. Install Required Dependencies

Install all required Python packages:

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

---

### 4. Configure Environment & AI Key

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```
2. **Add your AI API key**:
   - You can get a free Google Gemini API key at [Google AI Studio](https://aistudio.google.com/apikey).
   - You can set it directly in `.env`:
     ```env
     PEAKCUT_AI_PROVIDER=gemini
     PEAKCUT_AI_KEY=your_gemini_api_key_here
     ```
   - *Or* configure it easily inside the web dashboard under **Settings > AI**.

---

### 5. Start the Server

Run the PeakCut server:

```bash
python -m studio.server
```

Open your browser and navigate to:
👉 **`http://127.0.0.1:8765`**

---

### 6. (Optional) Access Remotely via Cloudflare Tunnel

To access your PeakCut dashboard from a phone or other devices outside your local network:

1. Install Cloudflare Tunnel (`cloudflared`):
   - **macOS**: `brew install cloudflared`
   - **Windows**: `winget install Cloudflare.cloudflared`
2. Start the tunnel:
   ```bash
   cloudflared tunnel --url http://127.0.0.1:8765
   ```
3. Copy the generated `https://<random-id>.trycloudflare.com` URL into your `.env`:
   ```env
   PEAKCUT_PUBLIC_URL=https://<your-subdomain>.trycloudflare.com
   ```
4. Restart the server. You can now use PeakCut securely from anywhere.

---

## 🎯 How to Use PeakCut

### Creating Clips from a Video
1. Paste any **YouTube, Twitch, or Kick URL** (or drag and drop a video file) in the input bar.
2. Select your preferences:
   - **Number of clips**: e.g., 6 clips
   - **Duration**: min / max seconds (e.g. 15s to 60s)
   - **Caption style**: Bounce, Hype, or Clean
   - **Layout**:
     - *Full frame + blurred fill*: Ideal for standard 16:9 videos.
     - *Fill the screen (centre crop)*: Crops 16:9 video to vertical 9:16.
     - *Gameplay + facecam in corner*: Zooms gameplay to fill 9:16 and overlays facecam in the corner.
3. Click **"Make clips"**.
4. PeakCut will download audio, transcribe speech, find viral moments with AI, and export vertical clips with burned-in subtitles.

### Editing a Clip
- Click on any clip card to open the **Clip Editor**.
- Edit start/end timestamps to fine-tune the cut.
- Click **`✨ AI Generate`** next to Big text to re-generate AI hooks and titles based on the clip transcript.
- Switch caption style or layout anytime and click **"Save and re-make clip"**.

### Bulk Actions
- Click **"Select all"** in the top bar or tick specific video cards.
- Click **"Edit selected"** to change the layout, subtitle style, or auto-generate AI hooks for all selected clips simultaneously.
- Download finished clips individually or as a single **ZIP file**.

---

## 🛠️ Project Structure

```text
├── studio/
│   ├── ai.py           # Multi-provider AI interface (Gemini, OpenAI, Claude, Ollama)
│   ├── brain.py        # AI prompts for clipping, hooks, titles, subtitles & facecam
│   ├── facecam.py      # Streamer webcam detection & computer vision PIP coordinate locator
│   ├── render.py       # FFmpeg video rendering, ASS subtitle styling, hardware encoders
│   ├── jobs.py         # Video pipeline, clip queue, and fair background scheduler
│   ├── transcribe.py   # Speech-to-text transcription engine (local ONNX Parakeet model)
│   ├── media.py        # Video downloader (yt-dlp), audio extraction, offset sync
│   └── server.py       # FastAPI web routes, authentication, sync polling
├── web/
│   └── index.html      # Responsive single-page web app (vanilla JS & CSS)
├── requirements.txt    # Python dependencies
└── README.md           # Documentation
```

---

## 🧪 Running Automated Tests

Run the built-in test suite to verify permissions, limits, and queues:

```bash
python tests/run.py
```
*(Tests run against a throwaway local instance on an isolated port without modifying your real data or requiring API keys).*

---

## 📄 License

This project is licensed under the [MIT License](LICENSE). Caption fonts (Anton, Archivo Black, Poppins) are licensed under the SIL Open Font License.
