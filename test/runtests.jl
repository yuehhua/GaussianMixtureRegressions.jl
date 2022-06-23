using GaussianMixtureRegressions
using Distributions
using Statistics
using Test

tests = [
    "regression",
    "metrics",
    "validation",
]

@testset "GaussianMixtureRegressions.jl" begin
    for t in tests
        include("$(t).jl")
    end
end
