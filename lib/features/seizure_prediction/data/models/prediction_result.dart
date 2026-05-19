class PredictionResult {
  const PredictionResult({
    required this.raw,
    this.label,
    this.riskScore,
    this.predictedLeadMinutes,
  });

  final Map<String, dynamic> raw;
  final String? label;
  final double? riskScore;
  final int? predictedLeadMinutes;

  bool get isHighRisk {
    final normalizedLabel = label?.toLowerCase();
    if (normalizedLabel == 'seizure' ||
        normalizedLabel == 'high_risk' ||
        normalizedLabel == 'warning') {
      return true;
    }
    return riskScore != null && riskScore! >= 0.7;
  }

  factory PredictionResult.fromJson(dynamic json) {
    final map = json is Map<String, dynamic> ? json : <String, dynamic>{'result': json};
    final scoreValue = map['risk_score'] ?? map['confidence'] ?? map['probability'] ?? map['score'];
    final leadValue = map['lead_minutes'] ?? map['prediction_window_minutes'];

    return PredictionResult(
      raw: map,
      label: (map['label'] ?? map['prediction'] ?? map['class'])?.toString(),
      riskScore: scoreValue is num ? scoreValue.toDouble() : null,
      predictedLeadMinutes: leadValue is num ? leadValue.toInt() : null,
    );
  }
}
