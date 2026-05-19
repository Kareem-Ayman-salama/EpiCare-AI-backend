# Flutter Integration Contract

Give the Flutter developer the deployed API base URL:

```text
https://YOUR-RENDER-SERVICE.onrender.com
```

In Flutter, configure it with:

```powershell
flutter run --dart-define=EPICARE_API_BASE_URL=https://YOUR-RENDER-SERVICE.onrender.com
```

## States

```text
0 = Normal
1 = Warning
2 = Seizure
3 = Offline
```

## Main Endpoints

### Health

```http
GET /api/health
```

### Latest Patient State

Use this for the patient home status card.

```http
GET /api/patients/demo-patient/latest
```

Example response:

```json
{
  "patientId": "demo-patient",
  "deviceId": "manual-test",
  "state": 2,
  "command": "SEIZURE",
  "latestReading": {
    "eeg": [610, 548],
    "ecg": 64,
    "emg": 220,
    "acc": [2.1, -1.4, 980],
    "state": "S"
  },
  "prediction": {
    "label": "Seizure",
    "probability": 0.95,
    "source": "fallback-ai-http-error"
  },
  "isConnected": true
}
```

### Recent Readings

Use this for charts.

```http
GET /api/patients/demo-patient/readings/latest?take=50
```

### Alerts

Use this for recent alerts list.

```http
GET /api/patients/demo-patient/alerts
```

### Seizure Events

Use this for seizure history.

```http
GET /api/patients/demo-patient/seizure-events
```

### Manual AI Prediction

Use this only for testing the model endpoint through the backend.

```http
POST /api/predictions/run
Content-Type: application/json
```

Body:

```json
{
  "eeg": [500, 510, 520],
  "ecg": [72, 75, 81],
  "emg": [20, 25, 32]
}
```

## Demo Input Endpoint

The simulator/bridge posts to:

```http
POST /api/iot/readings
```

Normal:

```json
{
  "patientId": "demo-patient",
  "deviceId": "manual-test",
  "eeg": [502, 498],
  "ecg": 72,
  "emg": 18,
  "state": "N"
}
```

Warning:

```json
{
  "patientId": "demo-patient",
  "deviceId": "manual-test",
  "eeg": [540, 531],
  "ecg": 92,
  "emg": 75,
  "state": "P"
}
```

Seizure:

```json
{
  "patientId": "demo-patient",
  "deviceId": "manual-test",
  "eeg": [610, 548],
  "ecg": 64,
  "emg": 220,
  "acc": [2.1, -1.4, 980],
  "state": "S"
}
```

## Flutter Dio Example

```dart
final dio = Dio(BaseOptions(
  baseUrl: const String.fromEnvironment(
    'EPICARE_API_BASE_URL',
    defaultValue: 'http://localhost:5000',
  ),
));

final response = await dio.get('/api/patients/demo-patient/latest');
final data = response.data as Map<String, dynamic>;
final state = data['state'] as int;
```

## Realtime Later

SignalR hub:

```text
/hubs/patient-monitoring
```

Events:

```text
patientStateUpdated
deviceCommand
```

For the first Flutter version, polling `GET /api/patients/demo-patient/latest` every 2-5 seconds is enough.
