@testset "Structure" begin

    @testset "Tube" begin
        @test Tube(diameter = 2.7u"mm", length = 9u"m") == Tube(2.7u"mm", 9u"m")
    end

    @testset "Coil" begin
        @test Coil(Tube(diameter = 2.7u"mm", length = 9u"m"), diameter = 2.7u"mm", pitch = 9u"m") ==
              Coil(Tube(2.7u"mm", 9u"m"), 2.7u"mm", 9u"m")
    end

    @testset "Valve" begin
        @test Valve(flow_rate = 62u"L/hr", flow_factor = 1.5u"m^3/hr") ==
              Valve(62u"L/hr", 1.5u"m^3/hr")
    end

end