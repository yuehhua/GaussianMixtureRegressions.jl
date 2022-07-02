module GaussianMixtureRegressions

using LinearAlgebra
using Statistics

using BSON
using Distributions
using GaussianMixtures
using StatsBase
using PDMats

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
    best_model,

    # io
    to_dict,
    to_model

include("regression.jl")
include("metrics.jl")
include("validation.jl")
include("io.jl")


end
