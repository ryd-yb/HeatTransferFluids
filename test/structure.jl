@testset "Structure" begin

    tube = Tube(diameter = 2.7u"mm", length = 9u"m")

    @testset "Tube" begin
        @test tube.diameter == 2.7u"mm"
        @test tube.length == 9u"m"
    end

    @testset "Helix" begin
        h = Helix(tube; diameter = 2.7u"mm", pitch = 9u"m")
        @test h.tube == tube
        @test h.diameter == 2.7u"mm"
        @test h.pitch == 9u"m"
    end

    @testset "Valve" begin
        v = Valve(flow_rate = 62u"L/hr", flow_factor = 1.5u"m^3/hr")
        @test v.flow_rate == 62u"L/hr"
        @test v.flow_factor == 1.5u"m^3/hr"

        @test_throws AssertionError Valve(flow_rate = 0u"L/hr", flow_factor = 1.5u"m^3/hr")
        @test_throws AssertionError Valve(flow_rate = 10u"L/hr", flow_factor = 0u"m^3/hr")
        @test_throws AssertionError Valve(flow_rate = 10u"m/hr", flow_factor = 1.5u"m^3/hr")
        @test_throws AssertionError Valve(flow_rate = 10u"L/hr", flow_factor = 1.5u"m^2/hr")
    end

end
