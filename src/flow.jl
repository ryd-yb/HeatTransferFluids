export reynolds_number, nusselt_number, prandtl_number

"""
    reynolds_number(f::Fluid, t::Tube)

Computes the Reynolds number of a `fluid` flowing through a `tube`.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `t::Tube`: the tube through which the fluid flows

# Returns
- `Float`: the Reynolds number of the fluid flowing through the tube
"""
function reynolds_number(f::Fluid, t::Tube)
    ϱ = f.density
    v = f.velocity
    μ = f.viscosity
    D = t.diameter

    return ustrip(ϱ * v * D / μ)
end

"""
    prandtl_number(f::Fluid)

Computes the Prandtl number of a `fluid``.

# Arguments
- `f::Fluid`: the fluid

# Returns
- `Float`: the Prandtl number of the fluid
"""
function prandtl_number(f::Fluid)
    c = f.heat_capacity
    μ = f.viscosity
    k = f.thermal_conductivity

    return ustrip(c * μ / k)
end

"""
    nusselt_number(f::Fluid, t::Tube)

Computes the Nusselt number of a `fluid` flowing through a `tube`.

Depending on the regime (laminar or turbulent), different formula have to be used to compute the Nusselt number.
For the intermediate region, we perform a linear interpolation between the laminar and turbulent regimes.
See VDI Heat Atlas, p. 696 for details.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `t::Tube`: the tube through which the fluid flows

# Returns
- `Float`: the Nusselt number of the fluid flowing through the tube
"""
function nusselt_number(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)
    γ = clamp((Re - 2300) / (1e4 - 2300), 0.0, 1.0)

    Nu_laminar = nusselt_number_laminar(f, t)
    Nu_turbulent = nusselt_number_turbulent(f, t)

    return (1 - γ) * Nu_laminar + γ * Nu_turbulent
end

function nusselt_number_laminar(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)
    Pr = prandtl_number(f)
    λ = t.diameter / t.length

    Nu₁ = 4.354
    Nu₂ = 1.953(Re * Pr * λ)^(1 / 3)
    Nu₃ = (0.924Pr)^(1 / 3) * (Re * λ)^(1 / 2)

    return (Nu₁^3 + 0.6^3 + (Nu₂ - 0.6)^3 + Nu₃^3)^(1 / 3)
end

function nusselt_number_turbulent(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)
    Pr = prandtl_number(f)
    λ = t.diameter / t.length
    ξ = (1.8log10(Re) - 1.5)^(-2)

    return ((ξ / 8)Re * Pr) * (1 + λ^(2 / 3)) / (1 + 12.7(ξ / 8)^(1 / 2) * (Pr^(2 / 3) - 1))
end
