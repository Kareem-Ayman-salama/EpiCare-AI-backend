class PredictionRequest {
  const PredictionRequest({
    required this.eeg,
    required this.ecg,
    required this.emg,
  });

  final List<num> eeg;
  final List<num> ecg;
  final List<num> emg;

  Map<String, dynamic> toJson() {
    return {
      'eeg': eeg,
      'ecg': ecg,
      'emg': emg,
    };
  }
}
