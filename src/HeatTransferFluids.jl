module HeatTransferFluids

using Unitful

@derived_dimension SpecificHeatCapacity dimension(u"J/(kg*K)")
@derived_dimension ThermalConductivity dimension(u"W/(m*K)")
@derived_dimension VolumeFlow dimension(u"m^3/s")

include("fluid.jl")
include("structure.jl")
include("flow.jl")
include("pressure_drop.jl")
include("heat_transfer.jl")

end
