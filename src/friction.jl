"""
    pressure_drop(f::Fluid, t::Tube)

Computes the friction coefficient of a `fluid` flowing through a `tube`.

See VDI Heat Atlas, p. 1057 for details.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `t::Tube`: the tube through which the fluid flows

# Keywords
- `friction::Float`: the friction factor of the fluid flowing through the tube

# Returns
- `DynamicQuantities.AbstractQuantity`: the pressure drop of the fluid flowing through the tube
"""
function friction(f::Fluid, t::Tube)
    Re = reynolds_number(f, t)
    Re_c = critical_reynolds_number(t)

    # laminar regime
    if Re < Re_c
        return 64 / Re
    end
    # turbulent regime
    if Re > Re_c
        # Blasius equation
        if Re > 3000 && Re < 2e4
            return 0.316 / Re^0.25
        end
        # Hermann equation
        if Re > 2e4 && Re < 2e6
            return 0.0054 + 0.3964 / Re^0.3
        end
    end

    throw(DomainError(Re, "no analytical formula for flow regime"))
end

function friction(f::Fluid, b::Bend)
    De = dean_number(f, b)
    ξ = friction(f, b.tube)

    # laminar flow as in straight tube
    if De < 11.6
        return ξ
    end
    # laminar flow with additional friction
    if De >= 11.6 && De <= 2000
        return ξ / (1 - (1 - (11.6 / De)^0.45)^(1 / 0.45))
    end

    r = b.tube.diameter / 2
    R = b.radius

    # turbulent flow
    Re_c = critical_reynolds_number(b.tube) * 7.5 * (r / R)^0.25
    Re = reynolds_number(f, b.tube)
    if Re > Re_c
        return (r/R)^0.5 * (0.003625 + 0.038*(Re*(r/R)^2)^-0.25)
    end
end
