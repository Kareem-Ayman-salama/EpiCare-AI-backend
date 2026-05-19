using System.Text.Json.Serialization;

namespace EpiCare.Api.Models;

public sealed record AiPredictionRequest
{
    [JsonPropertyName("eeg")]
    public IReadOnlyList<double> Eeg { get; init; } = Array.Empty<double>();

    [JsonPropertyName("ecg")]
    public IReadOnlyList<double> Ecg { get; init; } = Array.Empty<double>();

    [JsonPropertyName("emg")]
    public IReadOnlyList<double> Emg { get; init; } = Array.Empty<double>();
}

public sealed record AiPredictionResult
{
    public string Label { get; init; } = "Normal";
    public double Probability { get; init; }
    public double? ProcessingTimeMs { get; init; }
    public string Source { get; init; } = "fallback";
    public object? Raw { get; init; }
}
