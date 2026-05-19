import 'package:dio/dio.dart';
import 'package:epicare_flutter/core/api/api_client.dart';
import 'package:epicare_flutter/features/seizure_prediction/data/models/prediction_request.dart';
import 'package:epicare_flutter/features/seizure_prediction/data/models/prediction_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final predictionApiServiceProvider = Provider<PredictionApiService>((ref) {
  return PredictionApiService(ref.watch(dioProvider));
});

class PredictionApiService {
  PredictionApiService(this._dio);

  final Dio _dio;

  Future<PredictionResult> predict(PredictionRequest request) async {
    final response = await _dio.post<dynamic>('/api/predictions/run', data: request.toJson());
    return PredictionResult.fromJson(response.data);
  }
}
