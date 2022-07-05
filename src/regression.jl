abstract type AbstractRegression end

"""
    AbstractGMR

Abstract type for Gaussian mixture regression.
"""
abstract type AbstractGMR{K} <: AbstractRegression end

struct NullGMR{D<:AbstractMvNormal} <: AbstractGMR{1}
    dist::D
    n::Integer
end

struct GMR{K,D<:AbstractMixtureModel} <: AbstractGMR{K}
    dist::D
    n::Integer
end

struct FailedGMR{K} <: AbstractGMR{K}
    n::Integer
end

function fit(::Type{GMR{1}}, X::AbstractMatrix)
    μ, σ = mean_and_std(X, 1, corrected=true)
    mvn = MvNormal(vec(μ), diagm(vec(σ)))
    return NullGMR(mvn, size(X, 1))
end

function fit(::Type{GMR{K}}, X::AbstractMatrix) where {K}
    try
        gmm = GaussianMixtures.GMM(K, X, kind=:full)
        model = MixtureModel(gmm)
        return GMR{K,typeof(model)}(model, size(X, 1))
    catch e
        if e isa PosDefException
            return FailedGMR{K}(size(X, 1))
        else
            rethrow(e)
        end
    end
end

assign_clusters(::NullGMR, X::AbstractMatrix) = ones(Int, size(X, 1))

function assign_clusters(model::GMR, X::AbstractMatrix)
    posterior = membership(model, X)
    return assign_clusters(posterior)
end

assign_clusters(post::AbstractMatrix) = vec(map(x -> x[2], argmax(post, dims=2)))
