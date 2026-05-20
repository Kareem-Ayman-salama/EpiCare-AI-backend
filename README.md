# EpiCare AI Backend and IoT Demo

EpiCare is a medical IoT monitoring prototype that connects a Flutter-style patient experience, a .NET 8 backend, an Arduino/Proteus simulation, and an AI prediction service for seizure-risk demo workflows.

This repository is intended for software demonstration and integration testing. It is not a validated medical device or clinical decision system.

## What It Includes

- .NET 8 API for patient readings, alerts, seizure events, and health checks.
- SignalR realtime hub for patient monitoring screens.
- IoT bridge console app that reads serial JSON from a local simulator and posts it to the backend.
- Arduino firmware and Proteus simulation support files for demo input.
- Flutter application source under `lib/`.
- Deployment configuration for Docker, Render, and Railway-style hosting.

## Repository Layout

```text
backend/
  src/EpiCare.Api/        Backend API and realtime monitoring hub.
  src/EpiCare.IoTBridge/  Local serial-to-backend bridge.

firmware/
  Arduino firmware assets for the hardware/simulation flow.

lib/
  Flutter application screens, features, and shared widgets.

sketch_may19a/
  Arduino sketch used by the simulator.
```

## Backend Quick Start

Install the .NET 8 SDK, then run:

```powershell
cd backend
dotnet restore
dotnet run --project src/EpiCare.Api
```

Check the API:

```powershell
Invoke-WebRequest -Uri "http://localhost:5080/api/health" -UseBasicParsing
```

## IoT Bridge

After starting the backend and connecting the simulator serial port:

```powershell
cd backend
dotnet run --project src/EpiCare.IoTBridge -- --port COM3 --backend http://localhost:5080 --patient demo-patient
```

For a deployed backend:

```powershell
dotnet run --project src/EpiCare.IoTBridge -- --port COM3 --backend https://YOUR-BACKEND.example.com --patient demo-patient
```

## API Surface

Common demo endpoints:

```http
GET  /api/health
GET  /api/seizure/latest
GET  /api/patients/demo-patient/latest
GET  /api/patients/demo-patient/readings/latest?take=50
GET  /api/patients/demo-patient/alerts
GET  /api/patients/demo-patient/seizure-events
POST /api/predictions/run
```

Realtime hub:

```text
/hubs/patient-monitoring
```

## Configuration

The AI model client is configured with environment variables such as:

```text
AiModel__BaseUrl
AiModel__PredictPath
AiModel__WindowSize
AiModel__HighRiskThreshold
```

Keep deployment secrets and service URLs in environment variables. Do not commit local credentials or generated simulator exports.

## Local Assets

Large local tools, installers, generated reports, Proteus installations, build outputs, and demo export packages are intentionally ignored by Git. Keep them on the development machine or distribute them through a release artifact when needed.
