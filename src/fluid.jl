export Fluid, Water

"""
    Fluid
"""
struct Fluid{
    T1<:Unitful.Density,
    T2<:Unitful.Velocity,
    T3<:Unitful.DynamicViscosity,
    T4<:SpecificHeatCapacity,
    T5<:ThermalConductivity,
    T6<:Unitful.Temperature,
}
    density::T1
    velocity::T2
    viscosity::T3
    heat_capacity::T4
    thermal_conductivity::T5
    temperature::T6
end

Fluid(;
    density::Unitful.Density,
    velocity::Unitful.Velocity,
    viscosity::Unitful.DynamicViscosity,
    heat_capacity::SpecificHeatCapacity,
    thermal_conductivity::ThermalConductivity,
    temperature::Unitful.Temperature,
) = Fluid(density, velocity, viscosity, heat_capacity, thermal_conductivity, temperature)

"""
    Water

Returns a Fluid with the properties of water close to room temperature.
"""
Water(; velocity::Unitful.Velocity, temperature::Unitful.Temperature) = Fluid(
    density = 997u"kg/m^3",
    velocity = velocity,
    viscosity = 1u"mPa*s",
    heat_capacity = 4186u"J/(kg*K)",
    thermal_conductivity = 0.591u"W/(m*K)",
    temperature = temperature,
)