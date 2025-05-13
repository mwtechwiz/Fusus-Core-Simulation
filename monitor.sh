#!/bin/bash
echo "[INFO] Checking for stream output..."
if [ -f output.ts ]; then
  echo "[OK] Stream output file exists."
else
  echo "[ERROR] Stream output file missing."
fi

