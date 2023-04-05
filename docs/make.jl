using Documenter, HeatTransferFluids

makedocs(
    modules = [HeatTransferFluids],
    sitename = "HeatTransferFluids.jl",
    pages = Any["HeatTransferFluids.jl"=>"index.md", "API references"=>Any["api/fluid.md"]],
)

deploydocs(repo = "github.com/ryd-yb/HeatTransferFluids.jl.git")