using GMRs
using Documenter

DocMeta.setdocmeta!(GMRs, :DocTestSetup, :(using GMRs); recursive=true)

makedocs(;
    modules=[GMRs],
    authors="Yueh-Hua Tu",
    repo="https://github.com/yuehhua/GMRs.jl/blob/{commit}{path}#{line}",
    sitename="GMRs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://yuehhua.github.io/GMRs.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/yuehhua/GMRs.jl",
    devbranch="main",
)
