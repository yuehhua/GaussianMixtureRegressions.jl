@testset "metrics" begin
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

    @test likelihood(model, X) ≈ map(i -> pdf(model.dist, vec(X[i,:])), 1:size(X, 1))
    m = map(i -> pdf(model.dist.components[2], vec(X[i,:])), 1:n)
    @test membership(model, X)[:, 2] ≈ m
    @test membership(model, 2, X) ≈ m
    @test loglikelihood(model, X) ≈ map(i -> logpdf(model.dist, vec(X[i,:])), 1:size(X, 1))
    @test aic(model, X) isa Float64
    @test bic(model, X) isa Float64
end
