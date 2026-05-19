# EpiCare Backend

.NET 8 backend for the EpiCare Medical IoT + AI monitoring flow.

## Architecture

```text
Proteus / Arduino HEX
  -> Virtual Serial COM
  -> EpiCare.IoTBridge local console app
  -> EpiCare.Api deployed backend
  -> Railway AI model API
  -> Flutter app endpoints + SignalR realtime hub
```

## Projects

```text
src/EpiCare.Api
  Public backend API for Flutter and the IoT bridge.

src/EpiCare.IoTBridge
  Local console app that reads Proteus serial JSON and posts it to the backend.
```

## AI Model

Configured by environment variables:

```text
AiModel__BaseUrl=https://web-production-bad93.up.railway.app
AiModel__PredictPath=/predict
AiModel__WindowSize=240
AiModel__ModelWindowCount=8
AiModel__ModelSamplesPerWindow=3840
AiModel__ModelEegChannels=2
AiModel__ModelEcgChannels=1
AiModel__ModelEmgChannels=1
AiModel__HighRiskThreshold=0.7
```

The model request is:

```text
EEG shape: (8, 2, 3840)
ECG shape: (8, 1, 3840)
EMG shape: (8, 1, 3840)
```

The backend accepts Proteus single-sample readings and builds the model window internally.

## API Endpoints for Flutter

Replace `{baseUrl}` with your deployed URL.

```http
GET  {baseUrl}/api/health
GET  {baseUrl}/api/patients/demo-patient/latest
GET  {baseUrl}/api/patients/demo-patient/readings/latest?take=50
GET  {baseUrl}/api/patients/demo-patient/alerts
GET  {baseUrl}/api/patients/demo-patient/seizure-events
POST {baseUrl}/api/predictions/run
```

Realtime:

```text
{baseUrl}/hubs/patient-monitoring
```

SignalR client should call:

```text
JoinPatient("demo-patient")
```

Events emitted:

```text
patientStateUpdated
deviceCommand
```

## IoT Bridge Input

Proteus/Arduino serial lines should look like:

```json
{"eeg":[502,498],"ecg":72,"emg":18,"state":"N"}
{"eeg":[540,531],"ecg":92,"emg":75,"state":"P"}
{"eeg":[610,548],"ecg":64,"emg":220,"acc":[2.1,-1.4,980],"state":"S"}
```

The bridge adds:

```json
{
  "patientId": "demo-patient",
  "deviceId": "proteus-simulator",
  "capturedAt": "..."
}
```

## Run Locally

Install .NET 8 SDK first.

```powershell
cd backend
dotnet restore
dotnet run --project src/EpiCare.Api
```

Backend runs on the URL printed by .NET, usually:

```text
http://localhost:5080
```

Test health:

```powershell
Invoke-WebRequest -Uri "http://localhost:5080/api/health" -UseBasicParsing
```

## Run IoT Bridge

Run Proteus as administrator, set up Virtual Serial Port Kit, then:

```powershell
cd backend
dotnet run --project src/EpiCare.IoTBridge -- --port COM3 --backend http://localhost:5080 --patient demo-patient
```

For deployed backend:

```powershell
dotnet run --project src/EpiCare.IoTBridge -- --port COM3 --backend https://epicare-api.onrender.com --patient demo-patient
```

## Deploy to Render

1. Push this repository to GitHub.
2. Open Render.
3. Create a new Blueprint or Web Service.
4. If using Blueprint, select `backend/render.yaml`.
5. If using manual Web Service:
   - Runtime: Docker
   - Root directory: `backend`
   - Dockerfile path: `src/EpiCare.Api/Dockerfile`
   - Health check path: `/api/health`

After deploy, give Flutter this base URL:

```text
https://YOUR-RENDER-SERVICE.onrender.com
```

## Notes

- Current storage is in-memory for fast demo deployment. It resets when the free server sleeps/restarts.
- Add PostgreSQL later for permanent history.
- The backend uses AI output when available. If the AI API fails or returns unexpected data, it falls back to simulator `state` so demos do not break.
