namespace EpiCare.Api.Models;

public sealed record AiModelOptions
{
    public string BaseUrl { get; init; } = "https://web-production-bad93.up.railway.app";
    public string PredictPath { get; init; } = "/predict";
    public int WindowSize { get; init; } = 50;
    public double HighRiskThreshold { get; init; } = 0.7;
}
