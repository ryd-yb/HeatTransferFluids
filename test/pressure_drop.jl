@testset "pressure_drop" begin

    fluid = Water(velocity = 0.58u"m/s", temperature = 293.15u"K")
    tube = Tube(diameter = 2.7u"mm", length = 9.5153u"m")

    @testset "tube" begin
        @test pressure_drop(fluid, tube) ≈ 0.25u"bar" atol = 0.01u"bar"
        @test pressure_drop(Water(velocity = 3u"m/s", temperature = 262.15u"K"), Tube(diameter = 5u"mm", length = 1u"m")) ≈ 0.25u"bar" atol = 0.3u"bar"
    end

    @testset "coil" begin
        @test pressure_drop(fluid, Helix(tube, diameter = 63.1u"mm", pitch = 2.6u"mm")) ≈ 0.56u"bar" atol =
            0.01u"bar"
    end

    @testset "valve" begin
        @test pressure_drop(fluid, Valve(flow_rate = 62u"L/hr", flow_factor = 1.5u"m^3/hr")) ≈
              0.0017u"bar" atol = 0.0001u"bar"
    end

    @testset "bend" begin
        @test pressure_drop(fluid, Elbow(tube, radius = 10u"mm")) ≈ 0.7u"bar" atol = 0.1u"bar"
    end

end
