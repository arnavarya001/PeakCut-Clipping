#!/bin/bash
# PeakCut Launcher
cd "$(dirname "$0")"

# Activate virtual environment
if [ -d ".venv" ]; then
    source .venv/bin/activate
elif [ -d "venv" ]; then
    source venv/bin/activate
fi

echo "🚀 Starting PeakCut Studio on http://localhost:8765 ..."
python -m studio.server
