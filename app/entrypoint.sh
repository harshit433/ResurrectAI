#!/bin/bash

# Start FastAPI in the background
uvicorn main:app --host 0.0.0.0 --port 80 &

ngrok config add-authtoken 2kdztv2pU0KOOuLLuYfB75rPDfL_7HVSmtszRKtzmJw7821A1

# Start ngrok
ngrok http --url=amazingly-happy-hamster.ngrok-free.app 80
