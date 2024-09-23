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

    @testset "Bend" begin
        t = Elbow(tube, radius = 10u"mm")
        @test t.tube == tube
        @test t.radius == 10u"mm"
        @test t.angle == 90u"deg"

        @test_throws AssertionError Elbow(tube, radius = 0u"mm")
        @test_throws AssertionError Elbow(tube, radius = -10u"mm")
        @test_throws AssertionError Bend(tube, radius = 10u"m", angle = 0u"deg")
        @test_throws AssertionError Bend(tube, radius = 10u"m", angle = 180u"deg")
    end

end
