module GaussianMixtureRegressions

using LinearAlgebra
using Statistics

using BSON
using Distributions
using GaussianMixtures
using StatsBase
using PDMats

import StatsBase: fit, fit!, loglikelihood

export 
    # regression
    AbstractGMR,
    NullGMR,
    GMR,
    fit, fit!,
    assign_clusters,

    # correlations
    correlation,
    fisher_transform,

    # metrics
    likelihood,
    loglikelihood,
    membership,
    nll, aic, bic,
    
    # validation
    validate_score,
    grid_search,
    best_result,
    best_score,
    best_model,

    # io
    to_dict,
    to_model

include("regression.jl")
include("correlations.jl")
include("metrics.jl")
include("validation.jl")
include("io.jl")


end
