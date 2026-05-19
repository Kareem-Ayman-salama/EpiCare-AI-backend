import 'package:epicare_flutter/core/config/app_config.dart';
import 'package:epicare_flutter/core/theme/app_colors.dart';
import 'package:epicare_flutter/features/seizure_prediction/data/models/prediction_request.dart';
import 'package:epicare_flutter/features/seizure_prediction/data/models/prediction_result.dart';
import 'package:epicare_flutter/features/seizure_prediction/data/services/prediction_api_service.dart';
import 'package:epicare_flutter/shared/widgets/app_button.dart';
import 'package:epicare_flutter/shared/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeizurePredictionScreen extends ConsumerStatefulWidget {
  const SeizurePredictionScreen({super.key});

  @override
  ConsumerState<SeizurePredictionScreen> createState() => _SeizurePredictionScreenState();
}

class _SeizurePredictionScreenState extends ConsumerState<SeizurePredictionScreen> {
  bool _loading = false;
  PredictionResult? _result;
  String? _error;

  Future<void> _runPrediction() async {
    setState(() {
      _loading = true;
      _error = null;
      _result = null;
    });

    try {
      final service = ref.read(predictionApiServiceProvider);
      final result = await service.predict(
        PredictionRequest(
          eeg: _mockTensor(windowCount: 8, channelCount: 2, sampleCount: 3840, seed: .12),
          ecg: _mockTensor(windowCount: 8, channelCount: 1, sampleCount: 3840, seed: .72),
          emg: _mockTensor(windowCount: 8, channelCount: 1, sampleCount: 3840, seed: .05),
        ),
      );
      setState(() => _result = result);
    } catch (error) {
      setState(() {
        _error = 'Prediction request failed. Check signal format or server response.';
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<List<List<num>>> _mockTensor({
    required int windowCount,
    required int channelCount,
    required int sampleCount,
    required double seed,
  }) {
    return List.generate(
      windowCount,
      (window) => List.generate(
        channelCount,
        (channel) => List.generate(
          sampleCount,
          (sample) => seed + (window * .01) + (channel * .02) + ((sample % 32) * .001),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      appBar: AppBar(title: const Text('Seizure Prediction')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          AppCard(
            color: result?.isHighRisk == true ? const Color(0xFFFFF0F0) : Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  result?.isHighRisk == true ? Icons.warning_amber_rounded : Icons.health_and_safety_rounded,
                  color: result?.isHighRisk == true ? AppColors.danger : AppColors.primary,
                  size: 46,
                ),
                const SizedBox(height: 12),
                Text(
                  result?.isHighRisk == true ? 'Possible seizure risk detected' : '30-minute early warning check',
                  style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 8),
                Text(
                  result?.isHighRisk == true
                      ? 'Prediction indicates elevated risk within the next ${result?.predictedLeadMinutes ?? AppConfig.seizureWarningLeadTime.inMinutes} minutes.'
                      : 'Send EEG, ECG, and EMG signal windows to the deployed AI model.',
                  style: const TextStyle(color: AppColors.muted, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Signals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                SizedBox(height: 12),
                _SignalRow(label: 'EEG', value: '5 sample demo window'),
                _SignalRow(label: 'ECG', value: '5 sample demo window'),
                _SignalRow(label: 'EMG', value: '5 sample demo window'),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (_error != null)
            AppCard(
              color: const Color(0xFFFFF4F4),
              child: Text(_error!, style: const TextStyle(color: AppColors.danger)),
            ),
          if (result != null) ...[
            const SizedBox(height: 18),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Raw model response', style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text(result.raw.toString()),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
          AppButton(
            label: _loading ? 'Checking...' : 'Run prediction',
            icon: Icons.play_arrow_rounded,
            onPressed: _loading ? () {} : _runPrediction,
          ),
          const SizedBox(height: 10),
          const Text(
            'AI prediction is a screening aid, not a medical diagnosis. Emergency decisions should follow the clinical plan.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted, fontSize: 12, height: 1.35),
          ),
        ],
      ),
    );
  }
}

class _SignalRow extends StatelessWidget {
  const _SignalRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w900)),
          ),
          Expanded(child: Text(value, style: const TextStyle(color: AppColors.muted))),
        ],
      ),
    );
  }
}
