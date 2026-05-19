# EpiCare Demo Laptop Guide

## What to copy

Copy the clean project folder or `EpiCare_Demo_Laptop.zip` to the demo laptop.

Required parts:

- `backend/`
- `sketch_may19a/`
- `firmware/sketch_may19a.ino.hex`
- `sensorsss.pdsprj.zip`
- `demo/run-iot-bridge.ps1`

Do not copy installed program folders such as `Arduino IDE/` or `Proteus 8 Professional/` into GitHub.

## Required software on the demo laptop

- .NET 8 SDK/runtime
- Proteus 8 Professional with the same libraries used by the circuit
- Arduino IDE or Arduino CLI
- Virtual Serial Port Kit or any virtual COM pair tool

## Backend endpoint for Flutter

Base URL:

```text
https://epicare-api-production.up.railway.app
```

Latest compact endpoint:

```http
GET https://epicare-api-production.up.railway.app/api/seizure/latest
```

Simulator ingest endpoint:

```http
POST https://epicare-api-production.up.railway.app/api/iot/readings
```

## Demo flow

1. Open the Proteus project from `sensorsss.pdsprj.zip`.
   If Proteus asks for the Arduino program file, select `firmware/sketch_may19a.ino.hex`.
2. Create a virtual serial pair, for example `COM5 <-> COM6`.
3. Set Proteus `COMPIM` to one side, for example `COM5`, baud `115200`.
4. Run the bridge on the other side, for example `COM6`:

```powershell
cd EpiCare_Demo_Laptop
.\demo\run-iot-bridge.ps1 -Port COM6 -WriteCommand
```

5. Start the Proteus simulation.
6. Open this endpoint to verify live data:

```text
https://epicare-api-production.up.railway.app/api/seizure/latest
```

## Expected serial JSON from Proteus

Normal:

```json
{"eeg":[502,498],"ecg":72,"emg":18,"state":"N"}
```

Warning:

```json
{"eeg":[540,531],"ecg":92,"emg":75,"state":"P"}
```

Seizure:

```json
{"eeg":[610,548],"ecg":64,"emg":220,"acc":[2.1,-1.4,980],"state":"S"}
```

## Commands

Build backend:

```powershell
cd backend
dotnet restore
dotnet build
```

Run local backend if needed:

```powershell
dotnet run --project src\EpiCare.Api --urls http://localhost:7069
```

Run IoT bridge against Railway:

```powershell
.\demo\run-iot-bridge.ps1 -Port COM6 -WriteCommand
```

Run IoT bridge against local backend:

```powershell
.\demo\run-iot-bridge.ps1 -Port COM6 -Backend http://localhost:7069 -WriteCommand
```
