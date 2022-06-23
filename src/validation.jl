function validate_score(reg::Type{GMR{K}}, X::AbstractVecOrMat{T};
                        λ=2e-2, criterion=aic, return_model=false)  where {K,T}
    model = fit(reg, X)
    score = criterion(model, X, λ=λ)
    return return_model ? (model=model, score=score, k=K) : (score=score, k=K)
end

select_hyperparams(scores, ::typeof(aic)) = argmin(scores)
select_hyperparams(scores, ::typeof(bic)) = argmin(scores)
select_hyperparams(scores, ::typeof(likelihood)) = argmax(scores)
select_hyperparams(scores, ::typeof(loglikelihood)) = argmax(scores)
select_hyperparams(scores, ::typeof(nll)) = argmin(scores)

lowest_score(::typeof(aic)) = Inf
lowest_score(::typeof(bic)) = Inf
lowest_score(::typeof(likelihood)) = -Inf
lowest_score(::typeof(loglikelihood)) = -Inf
lowest_score(::typeof(nll)) = -Inf

function grid_search(reg::Type{GMR}, X::AbstractVecOrMat, k_range;
                     λ=2e-2, criterion=aic, verbosity::Integer=0)
    results = []
	for k = k_range
        res = validate_score(reg{k}, X; λ=λ, return_model=true)
        push!(results, res)
        verbosity > 1 && @info "k = $(res[:k]): score: $(res[:score])"
	end
    results
end

function best_result(results; criterion=aic)
    scores = map(x -> x[:score], results)
    return results[select_hyperparams(scores, criterion)]
end

function best_score(results; criterion=aic)
    scores = map(x -> x[:score], results)
    return scores[select_hyperparams(scores, criterion)]
end

function best_model(results; criterion=aic)
    scores = map(x -> x[:score], results)
    models = map(x -> x[:model], results)
    return models[select_hyperparams(scores, criterion)]
end
