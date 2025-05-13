#!/bin/bash

echo "[INFO] Starting simulated camera stream..."
ffmpeg -re -stream_loop -1 -i charlie.mp4 -f mpegts output.ts
