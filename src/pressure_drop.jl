export pressure_drop

"""
    pressure_drop(f::Fluid, t::Tube[; friction])

Computes the pressure drop of a `fluid` flowing through a `tube` with a particular `friction`.

See VDI Heat Atlas, p. 1057 for details.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `t::Tube`: the tube through which the fluid flows

# Keywords
- `friction::Float`: the friction factor of the fluid flowing through the tube

# Returns
- `DynamicQuantities.AbstractQuantity`: the pressure drop of the fluid flowing through the tube
"""
function pressure_drop(f::Fluid, t::Tube; friction = friction(f,t))
    Re = reynolds_number(f, t)
    L = t.length
    d = t.diameter
    ρ = f.density
    u = f.velocity
    ξ = friction

    return uconvert(us"bar", ξ * (L / d) * (ρ * u^2 / 2))
end

"""
    pressure_drop(f::Fluid, h::Helix)

Computes the pressure drop of a `fluid` flowing through a `helix`.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `h::Helix`: the helix through which the fluid flows

# Returns
- `DynamicQuantity.AbstractQuantity`: the pressure drop of the fluid flowing through the tube
"""
function pressure_drop(f::Fluid, h::Helix)
    Dw = h.diameter
    H = h.pitch
    D = Dw * (1 + (H / (π * Dw))^2)
    d = h.tube.diameter
    Re = reynolds_number(f, h.tube)
    Re_crit = critical_reynolds_number(h)

    if 1 < (Re * sqrt(d / D)) < (Re_crit * sqrt(d / D))
        ξ = (64 / Re) * (1 + 0.033(log10(Re * sqrt(d / D)))^4.0)
    else
        ξ = (0.3164 / Re^(1 / 4)) * (1 + 0.095sqrt(d / D) * Re^(1 / 4))
    end

    return pressure_drop(f, h.tube, friction = ξ)
end

"""
    pressure_drop(f::Fluid, v::Valve)

Computes the pressure drop of a `fluid` flowing through a `valve`.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `v::Valve`: the valve through which the fluid flows

# Returns
- `DynamicQuantity.AbstractQuantity`: the pressure drop of the fluid flowing through the tube
"""
# https://en.wikipedia.org/wiki/Flow_coefficient
function pressure_drop(f::Fluid, v::Valve)
    Q = uconvert(us"m^3/hr", v.flow_rate)
    Kv = uconvert(us"m^3/hr", v.flow_factor)

    ρ = f.density
    ρ₀ = 1000u"kg/m^3"
    p₀ = 1u"bar"

    return p₀ * (Q / Kv)^2 * ρ / ρ₀
end

"""
    pressure_drop(f::Fluid, b::Bend)

Computes the pressure drop of a `fluid` flowing through a `bend`.

So far, we only support 90-degree bends, see Spedding, P.L., Bernard, E. and McNally, G.M., ‘Fluid ﬂow through 90 degree bends’, Dev. Chem. Eng Mineral Process, 12: 107–128, 2004.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `b::Bend`: the valve through which the fluid flows

# Returns
- `DynamicQuantity.AbstractQuantity`: the pressure drop of the fluid flowing through the tube
"""
function pressure_drop(f::Fluid, b::Bend)
    @assert b.angle == 90u"deg" "only 90-degree bends are supported at the moment"

    De = dean_number(f, b)

    ξ = nothing
    if De >= 11.6 && De <= 2000
        ϕ = 1 - (1 - (11.6 / De)^0.45)^(1 / 0.45)
    end

end
