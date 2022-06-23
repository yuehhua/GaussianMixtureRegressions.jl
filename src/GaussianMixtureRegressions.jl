module GaussianMixtureRegressions

using LinearAlgebra
using Statistics

using Distributions
using GaussianMixtures
using StatsBase

import StatsBase: nobs, fit, fit!, loglikelihood

export 
    # regression
    AbstractGMR,
    NullGMR,
    GMR,
    coef,
    std,
    stderror,
    ncoef,
    nobs,
    design_matrix,
    predict,
    fit, fit!,
    residual,
    likelihood,
    correlation,
    assign_clusters,

    # metrics
    loglikelihood,
    membership,
    aic,
    bic,
    
    # validation
    validate_score,
    grid_search,
    best_result,
    best_score,
    best_model

include("regression.jl")
include("metrics.jl")
include("validation.jl")


end
