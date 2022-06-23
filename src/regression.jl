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


# population correlation

correlation(σ_xy, σ_xx, σ_yy) = σ_xy / sqrt(σ_xx * σ_yy)

correlation(::FailedGMR) = [0.]

function correlation(model::NullGMR)
    Σ = model.dist.Σ
    [correlation(Σ[1,2], Σ[1,1], Σ[2,2])]
end

correlation(model::GMR) = [correlation(c.Σ[1,2], c.Σ[1,1], c.Σ[2,2]) for c in model.dist.components]


# sample correlation

function correlation(xs::AbstractVector, ys::AbstractVector, cluster::AbstractVector)
    ks = unique(Array(cluster))
    ρs = similar(xs, maximum(ks))
    for clst in ks
        sel = clst .== cluster
        ρs[clst] = cor(xs[sel], ys[sel])
    end
    return ρs
end

fisher_transform(ρs::AbstractVector, df::Integer=length(ρs)-3) = sqrt(df) .* atanh.(ρs)
fisher_transform(ρs::AbstractVector, dfs::AbstractVector) = sqrt.(dfs) .* atanh.(ρs)
