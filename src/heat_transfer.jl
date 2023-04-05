export heat_transfer

"""
    heat_transfer(f::Fluid, t::Tube)

Computes the heat transfer coefficient of a `fluid`` flowing through a `tube`.

# Arguments
- `f::Fluid`: the fluid flowing through the tube
- `t::Tube`: the tube through which the fluid flows

# Returns
- `Unitful.Quantity`: the heat transfer coefficient of the fluid flowing through the tube
"""
function heat_transfer(f::Fluid, t::Tube)
    k = f.thermal_conductivity
    D = t.diameter
    Nu = nusselt_number(f, t)

    return Nu * (k / D)
end