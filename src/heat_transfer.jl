export heat_transfer

"""
    heat_transfer(f::Fluid, t::Tube)

The heat transfer coefficient of a fluid flowing inside a tube.
"""
function heat_transfer(f::Fluid, t::Tube)
    k = f.thermal_conductivity
    D = t.diameter
    Nu = nusselt_number(f, t)

    return Nu * (k / D)
end