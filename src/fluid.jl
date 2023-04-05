export Fluid, Water

"""
    Fluid{
        T1<:Unitful.Density,
        T2<:Unitful.Velocity,
        T3<:Unitful.DynamicViscosity,
        T4<:SpecificHeatCapacity,
        T5<:ThermalConductivity,
        T6<:Unitful.Temperature,
    }

A fluid with the important physical properties to be used in heat transfer calculations.

# Fields
- `density::T1`: the density of the fluid
- `velocity::T2`: the velocity of the fluid
- `viscosity::T3`: the viscosity of the fluid
- `heat_capacity::T4`: the specific heat capacity of the fluid
- `thermal_conductivity::T5`: the thermal conductivity of the fluid
- `temperature::T6`: the temperature of the fluid
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

"""
    Fluid(
        density::Unitful.Density,
        velocity::Unitful.Velocity,
        viscosity::Unitful.DynamicViscosity,
        heat_capacity::SpecificHeatCapacity,
        thermal_conductivity::ThermalConductivity,
        temperature::Unitful.Temperature,
    )

Returns a Fluid with the given properties.

# Keywords
- `density::Unitful.Density`: the density of the fluid
- `velocity::Unitful.Velocity`: the velocity of the fluid
- `viscosity::Unitful.DynamicViscosity`: the viscosity of the fluid
- `heat_capacity::SpecificHeatCapacity`: the specific heat capacity of the fluid
- `thermal_conductivity::ThermalConductivity`: the thermal conductivity of the fluid
- `temperature::Unitful.Temperature`: the temperature of the fluid

# Returns
- `Fluid`: the fluid with the given properties
"""
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

# Keywords
- `velocity::Unitful.Velocity`: the velocity of the water
- `temperature::Unitful.Temperature`: the temperature of the water

# Returns
- `Fluid`: the fluid with the properties of water close to room temperature at the given velocity and temperature
"""
Water(; velocity::Unitful.Velocity, temperature::Unitful.Temperature) = Fluid(
    density = 997u"kg/m^3",
    velocity = velocity,
    viscosity = 1u"mPa*s",
    heat_capacity = 4186u"J/(kg*K)",
    thermal_conductivity = 0.591u"W/(m*K)",
    temperature = temperature,
)