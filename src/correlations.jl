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
