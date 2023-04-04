@testset "Fluid" begin

    @test Water(velocity = 1u"m/s", temperature = 20u"°C") == Fluid(
        density = 997u"kg/m^3",
        velocity = 1u"m/s",
        viscosity = 1u"mPa*s",
        heat_capacity = 4186u"J/(kg*K)",
        thermal_conductivity = 0.591u"W/(m*K)",
        temperature = 20u"°C",
    )

end