using Documenter, HeatTransferFluids

makedocs(
    modules = [HeatTransferFluids],
    sitename = "HeatTransferFluids.jl",
    pages = Any[
        "HeatTransferFluids.jl"=>"index.md",
        "API references"=>Any[
            "api/fluid.md",
            "api/structures.md",
            "api/flow.md",
            "api/pressure_drop.md",
            "api/heat_transfer.md",
        ],
    ],
)

deploydocs(repo = "github.com/ryd-yb/HeatTransferFluids.jl.git")