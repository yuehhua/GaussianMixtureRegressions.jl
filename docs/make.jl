using GaussianMixtureRegressions
using Documenter

DocMeta.setdocmeta!(GaussianMixtureRegressions, :DocTestSetup, :(using GaussianMixtureRegressions); recursive=true)

makedocs(;
    modules=[GaussianMixtureRegressions],
    authors="Yueh-Hua Tu",
    repo="https://github.com/yuehhua/GaussianMixtureRegressions.jl/blob/{commit}{path}#{line}",
    sitename="GaussianMixtureRegressions.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://yuehhua.github.io/GaussianMixtureRegressions.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/yuehhua/GaussianMixtureRegressions.jl",
    devbranch="main",
)
