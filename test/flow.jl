@testset "Flow" begin

    fluid = Water(velocity = 0.58u"m/s", temperature = 20u"°C")
    tube = Tube(diameter = 2.7u"mm", length = 9.5153u"m")

    @testset "reynolds_number" begin
        @test reynolds_number(fluid, tube) ≈ 1561 atol = 1
    end

    @testset "prandtl_number" begin
        @test prandtl_number(fluid) ≈ 7 atol = 1
    end

    @testset "nusselt_number" begin
        @test nusselt_number(fluid, tube) ≈ 5 atol = 1
    end

    @testset "criticality" begin
        @test criticality(fluid, tube) ≈ 0 atol = 1e-4
    end

end