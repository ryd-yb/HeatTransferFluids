export Fluid, Water

"""
    Fluid{T<:AbstractQuantity}

A fluid with the important physical properties to be used in heat transfer calculations.

# Fields
- `density::T`: the density of the fluid
- `velocity::T`: the velocity of the fluid
- `viscosity::T`: the viscosity of the fluid
- `heat_capacity::T`: the specific heat capacity of the fluid
- `thermal_conductivity::T`: the thermal conductivity of the fluid
- `temperature::T`: the temperature of the fluid
"""
struct Fluid{T<:AbstractQuantity}
    density::T
    velocity::T
    viscosity::T
    heat_capacity::T
    thermal_conductivity::T
    temperature::T

    function Fluid(;
        density::T,
        velocity::T,
        viscosity::T,
        heat_capacity::T,
        thermal_conductivity::T,
        temperature::T,
    ) where {T}
        @assert dimension(density) == dimension(u"kg/m^3") "density must have units of mass per volume"
        @assert dimension(velocity) == dimension(u"m/s") "velocity must have units of length per time"
        @assert dimension(viscosity) == dimension(u"Pa*s") "viscosity must have units of pressure times time"
        @assert dimension(heat_capacity) == dimension(u"J/(kg*K)") "heat_capacity must have units of energy per mass per temperature"
        @assert dimension(thermal_conductivity) == dimension(u"W/(m*K)") "thermal_conductivity must have units of power per length per temperature"
        @assert dimension(temperature) == dimension(u"K") "temperature must have units of temperature"
        @assert ustrip(density) > 0 "density must be positive"
        @assert ustrip(velocity) > 0 "velocity must be positive"
        @assert ustrip(viscosity) > 0 "viscosity must be positive"
        @assert ustrip(heat_capacity) > 0 "heat_capacity must be positive"
        @assert ustrip(thermal_conductivity) > 0 "thermal_conductivity must be positive"
        @assert ustrip(temperature) > 0 "temperature must be positive"

        new{T}(density, velocity, viscosity, heat_capacity, thermal_conductivity, temperature)
    end

end

"""
    Water

Returns a Fluid with the properties of water close to room temperature.

# Keywords
- `velocity::AbstractQuantity`: the velocity of the water
- `temperature::AbstractQuantity`: the temperature of the water

# Returns
- `Fluid`: the fluid with the properties of water close to room temperature at the given velocity and temperature
"""
Water(; velocity::AbstractQuantity, temperature::AbstractQuantity) = Fluid(
    density = 997u"kg/m^3",
    velocity = velocity,
    viscosity = 1e-3u"Pa*s",
    heat_capacity = 4186u"J/(kg*K)",
    thermal_conductivity = 0.591u"W/(m*K)",
    temperature = temperature,
)
