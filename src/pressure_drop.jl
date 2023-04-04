export pressure_drop

"""
    pressure_drop(f::Fluid; t::Tube, friction = nothing)

The pressure drop of a fluid flowing inside a tube due to drag of the fluid along the tube's boundary.
"""
# VDI Heat Atlas, p. 1057
function pressure_drop(f::Fluid, t::Tube; friction = nothing)
    Re = reynolds_number(f, t)
    L = t.length
    d = t.diameter
    ρ = f.density
    u = f.velocity

    if friction === nothing
        ξ = 64 / Re
    else
        ξ = friction
    end

    return uconvert(u"bar", ξ * (L / d) * (ρ * u^2 / 2))
end

"""
    pressure_drop(f::Fluid, c::CoiledTube)

The pressure drop of a fluid flowing inside a coiled tube.
In addition to friction, a fluid experiences centrifugal forces due to the coiling of the tube.
"""
# VDI Heat Atlas, p. 1062 to 1063
function pressure_drop(f::Fluid, c::Coil)
    Dw = c.diameter
    H = c.pitch
    D = Dw * (1 + (H / (π * Dw))^2)
    d = c.tube.diameter
    Re = reynolds_number(f, c.tube)

    if (d / D)^(-2) < Re && Re < 2300
        ξ = (64 / Re) * (1 + 0.033(log10(Re * sqrt(d / D))))
    else
        ξ = (0.3164 / Re^(1 / 4)) * (1 + 0.095sqrt(d / D) * Re^(1 / 4))
    end

    return pressure_drop(f, c.tube, friction = ξ)
end

"""
    pressure_drop(f::Fluid; flow_rate::VolumeFlow, flow_factor::VolumeFlow)

The pressure drop of a fluid flowing through an flow element characterized by a flow factor, e.g., valve.
"""
# https://en.wikipedia.org/wiki/Flow_coefficient
function pressure_drop(f::Fluid, v::Valve)
    Q = uconvert(u"m^3/hr", v.flow_rate)
    Kv = uconvert(u"m^3/hr", v.flow_factor)

    ρ = f.density
    ρ₀ = 1000u"kg/m^3"
    p₀ = 1u"bar"

    return p₀ * (Q / Kv)^2 * ρ / ρ₀
end