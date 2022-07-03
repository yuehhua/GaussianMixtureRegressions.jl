# GaussianMixtureRegressions

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://yuehhua.github.io/GaussianMixtureRegressions.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://yuehhua.github.io/GaussianMixtureRegressions.jl/dev/)
[![Build Status](https://github.com/yuehhua/GaussianMixtureRegressions.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/yuehhua/GaussianMixtureRegressions.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/yuehhua/GaussianMixtureRegressions.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/yuehhua/GaussianMixtureRegressions.jl)

GaussianMixtureRegressions provides implementation of Gaussian mixture regression model<sup>1</sup> in Julia.

## Example

```julia
julia> using GaussianMixtureRegressions

julia> n = 100;

julia> d = 3;

julia> w = [1., 2., 3.];

julia> b = -1.0;

julia> σ = 2.0;

julia> X = randn(n, d);

julia> y = X*w .+ b .+ randn(n)*σ;

julia> X = hcat(X, y);

julia> K = 3;

julia> model = fit(GMR{K}, X)
[ Info: Initializing GMM, 3 Gaussians diag covariance 4 dimensions using 100 data points
K-means converged with 5 iterations (objv = 496.2564299844352)
┌ Info: K-means with 100 data points using 5 iterations
└ 6.7 data points per parameter
GMR{3, MixtureModel{Multivariate, Continuous, FullNormal, Categorical{Float64, Vector{Float64}}}}(MixtureModel{FullNormal}(K = 3)
components[1] (prior = 0.3146): FullNormal(
dim: 4
μ: [0.26776175162691485, 0.2509249295364129, 0.9660834976335448, 3.532775397209546]
Σ: [0.7115861947660863 -0.1944775509058701 -0.20333074136580565 -0.13206921117259834; -0.1944775509058701 0.8514434620519014 0.011086817365474606 1.2602845902443185; -0.20333074136580565 0.011086817365474606 0.2348133924977131 0.3688123774069542; -0.13206921117259834 1.2602845902443185 0.3688123774069542 5.354242427805917]
)
...
```

## Save and load model

```julia
GaussianMixtureRegressions.save(model, "model.bson")

gmr = GaussianMixtureRegressions.load("model.bson")
```

## References

1. [Ghahramani, Z., & Jordan, M. (1994). Supervised learning from incomplete data via an EM approach. In J. Cowan, G. Tesauro, & J. Alspector (Eds.), *Advances in neural information processing systems* (Vol. 6, pp. 120–127). Morgan-Kaufmann.](https://proceedings.neurips.cc/paper/1993/file/f2201f5191c4e92cc5af043eebfd0946-Paper.pdf)
2. <div class="csl-entry">Fabisch, A. (2021). gmr: Gaussian Mixture Regression. <i>Journal of Open Source Software</i>, <i>6</i>(62), 3054. https://doi.org/10.21105/joss.03054</div>

