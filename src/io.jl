to_dict(obj::Number) = obj
to_dict(obj::AbstractArray{<:Number}) = obj
to_dict(obj::PDMats.PDMat) = Matrix(obj)

function to_dict(obj::T) where {T}
    return Dict(key => to_dict(getfield(obj, key)) for key ∈ fieldnames(T))
end

function to_dict(objs::Vector{<:FullNormal})
    return [to_dict(obj) for obj in objs]
end

to_model(d::Dict) = to_model(GMR, d)

function to_model(::Type{GMR}, d::Dict)
    n = d[:n]
    dist = to_model(MixtureModel, d[:dist])
    K = length(dist.components)
    return GMR{K,typeof(dist)}(dist, n)
end

function to_model(::Type{MixtureModel}, d::Dict)
    prior = to_model(Categorical, d[:prior])
    comp = [to_model(FullNormal, c) for c in d[:components]]
    return MixtureModel(comp, prior)
end

to_model(::Type{Categorical}, d::Dict) = Categorical(d[:p])
to_model(::Type{FullNormal}, d::Dict) = FullNormal(d[:μ], PDMat(d[:Σ]))

save(m::GMR, filename::String) = bson(filename, to_dict(m))
save(ms::Vector{<:GMR}, filename::String) = bson(filename, to_dict(ms))

load(filename::String) = to_model(BSON.load(filename))
