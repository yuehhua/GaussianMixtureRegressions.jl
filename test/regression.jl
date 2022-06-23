@testset "GMR" begin
    # Gaussian mixture regression
    T = Float64
    n = 100
    d = 5

    w = [1., 2., 3., 4., 5]
    b = -1.0
    σ = 2.0

    X = randn(n, d)
    y = X*w .+ b .+ randn(n)*σ
    X = hcat(X, y)

    nullgmr = fit(GMR{1}, X)
    @test nullgmr isa NullGMR
    @test typeof(nullgmr) <: AbstractGMR{1}
    @test size(correlation(nullgmr)) == (1,)

    K = 3
    gmr = fit(GMR{K}, X)
    @test gmr isa GMR
    @test typeof(gmr) <: AbstractGMR{K}
    @test size(correlation(gmr)) == (K,)

    clst = assign_clusters(gmr, X)
    @test size(clst) == (n,)
    @test Set(clst) == Set(collect(1:K))
end
