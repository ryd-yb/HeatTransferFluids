export heat_transfer

"""
    heat_transfer(fluid, tube)

Computes the heat transfer coefficient of a `fluid`` flowing through a `tube`.
"""
function heat_transfer(f::Fluid, t::Tube)
    k = f.thermal_conductivity
    D = t.diameter
    Nu = nusselt_number(f, t)

    return Nu * (k / D)
end