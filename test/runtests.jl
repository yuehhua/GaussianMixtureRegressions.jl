using GMRs
using Distributions
using Statistics
using Test

tests = [
    "regression",
    "metrics",
    "validation",
]

@testset "GMRs.jl" begin
    for t in tests
        include("$(t).jl")
    end
end
