@testset "heat_transfer" begin

    fluid = Water(velocity = 3u"m/s", temperature = 293.15u"K")
    tube = Tube(diameter = 2.7u"mm", length = 14u"m")
    #coil = Coil(tube; diameter = 95u"mm", pitch = 5.2u"mm")

    @test heat_transfer(fluid, tube) ≈ 12u"kW/(K*m^2)" atol = 1u"kW/(K*m^2)"

end
