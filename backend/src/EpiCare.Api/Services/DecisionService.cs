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

    public MonitoringState Decide(AiPredictionResult prediction)
    {
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
            MonitoringState.Warning => "WARNING",
            MonitoringState.Seizure => "SEIZURE",
            MonitoringState.Offline => "OFFLINE",
            _ => "NORMAL"
        };
    }
}
