using EpiCare.Api.Models;
using Microsoft.Extensions.Options;

namespace EpiCare.Api.Services;

public sealed class DecisionService
{
    private readonly AiModelOptions _options;

    public DecisionService(IOptions<AiModelOptions> options)
    {
        _options = options.Value;
    }

    public MonitoringState Decide(AiPredictionResult prediction, SensorReadingDto? latestReading = null)
    {
        var simulatorState = latestReading?.State?.Trim().ToUpperInvariant();
        if (simulatorState is "S" or "SEIZURE")
        {
            return MonitoringState.Seizure;
        }

        if (simulatorState is "P" or "WARNING" or "PREDICTION")
        {
            return MonitoringState.Warning;
        }

        if (latestReading?.Acc is { Count: >= 3 })
        {
            return MonitoringState.Seizure;
        }

        if (prediction.FinalPrediction == 1)
        {
            return MonitoringState.Warning;
        }

        var label = prediction.Label.Trim().ToLowerInvariant();

        if (label is "seizure" or "ictal")
        {
            return MonitoringState.Seizure;
        }

        if (label is "warning" or "prediction" or "preictal")
        {
            return MonitoringState.Warning;
        }

        if (prediction.Probability >= _options.HighRiskThreshold)
        {
            return MonitoringState.Warning;
        }

        return MonitoringState.Normal;
    }

    public string ToDeviceCommand(MonitoringState state)
    {
        return state switch
        {
            MonitoringState.Warning => "P",
            MonitoringState.Seizure => "S",
            _ => "N"
        };
    }

    public string ToApplicationState(MonitoringState state)
    {
        return state switch
        {
            MonitoringState.Warning => "HIGH_RISK",
            MonitoringState.Seizure => "SEIZURE_DETECTED",
            MonitoringState.Offline => "OFFLINE",
            _ => "NORMAL"
        };
    }

    public double ToApplicationProbability(MonitoringState state, AiPredictionResult? prediction)
    {
        var probability = prediction?.FusionProbability
            ?? prediction?.TriggerProbability
            ?? prediction?.Probability
            ?? 0;

        return state switch
        {
            MonitoringState.Seizure => Math.Max(probability, 0.85),
            MonitoringState.Warning => Math.Max(probability, _options.HighRiskThreshold),
            MonitoringState.Offline => 0,
            _ => probability
        };
    }
}
