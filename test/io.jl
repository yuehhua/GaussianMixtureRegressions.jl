@testset "io" begin
    T = Float64
    n = 100
    d = 5

    w = [1., 2., 3., 4., 5]
    b = -1.0
    σ = 2.0

    X = randn(n, d)
    y = X*w .+ b .+ randn(n)*σ
    X = hcat(X, y)

    K = 3
    model = fit(GMR{K}, X)

    dict = to_dict(model)
    @test haskey(dict, :n)
    @test haskey(dict, :dist)
    @test dict[:n] == n

    dist = dict[:dist]
    @test haskey(dist, :components)
    @test haskey(dist, :prior)

    prior = dist[:prior]
    @test haskey(prior, :p)
    @test haskey(prior, :support)
    @test size(prior[:p]) == (3, )
    @test prior[:support] == Base.OneTo(3)

    comp = dist[:components][1]
    @test haskey(comp, :μ)
    @test haskey(comp, :Σ)
    @test size(comp[:μ]) == (d+1, )
    @test size(comp[:Σ]) == (d+1, d+1)

    @test to_model(Categorical, prior) isa Categorical
    @test to_model(FullNormal, comp) isa FullNormal
    @test to_model(MixtureModel, dist) isa MixtureModel
    @test to_model(GMR, dict) isa GMR{3}
end
