export reynolds_number, nusselt_number, prandtl_number

"""
    reynolds_number(f::Flow)

The Reynolds number of a fluid flowing inside a Tube.
"""
function reynolds_number(f::Fluid, t::Tube)
    ϱ = f.density
    v = f.velocity
    μ = f.viscosity
    D = t.diameter

    return upreferred(ϱ * v * D / μ)
end

"""
    criticality(f::Fluid, t::Tube)

Quantifies the critical region of a fluid flowing inside a Tube.

A value of 0 indicates a laminar flow, a value of 1 indicates a turbulent flow.
"""
function criticality(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)

    return clamp((Re - 2300) / (1e4 - 2300), 0.0, 1.0)
end

"""
    prandtl_number(f::Fluid)

The Prandtl number of a fluid.
"""
function prandtl_number(f::Fluid)
    c = f.heat_capacity
    μ = f.viscosity
    k = f.thermal_conductivity

    return c * μ / k
end

# VDI Heat Atlas, p. 652, eq. (25)
function nusselt_number_laminar(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)
    Pr = prandtl_number(f)
    λ = t.diameter / t.length

    Nu₁ = 4.354
    Nu₂ = 1.953(Re * Pr * λ)^(1 / 3)
    Nu₃ = (0.924Pr)^(1 / 3) * (Re * λ)^(1 / 2)

    return (Nu₁^3 + 0.6^3 + (Nu₂ - 0.6)^3 + Nu₃^3)^(1 / 3)
end

# VDI Heat Atlas, p. 696, eq. (26)
function nusselt_number_turbulent(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)
    Pr = prandtl_number(f)
    λ = t.diameter / t.length
    ξ = (1.8log10(Re) - 1.5)^(-2)

    return ((ξ / 8)Re * Pr) * (1 + λ^(2 / 3)) / (1 + 12.7(ξ / 8)^(1 / 2) * (Pr^(2 / 3) - 1))
end

"""
    nusselt_number(f::Fluid, t::Tube)

The Nusselt number of a fluid flowing inside a tube where we interpolate over the critical region.
"""
# VDI Heat Atlas, p. 696
function nusselt_number(f::Fluid, t::Tube)
    γ = criticality(f, t)

    Nu_laminar = nusselt_number_laminar(f, t)
    Nu_turbulent = nusselt_number_turbulent(f, t)

    return (1 - γ) * Nu_laminar + γ * Nu_turbulent
end
