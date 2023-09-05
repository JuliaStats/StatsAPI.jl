module TestRegressionModel

using Test, LinearAlgebra, StatsAPI
using StatsAPI: RegressionModel, crossmodelmatrix, vif

struct MyRegressionModel <: RegressionModel
end

StatsAPI.modelmatrix(::MyRegressionModel) = [1 2; 3 4]
StatsAPI.vcov(::MyRegressionModel) = [1 0; 0 1]

struct MyRegressionModel2 <: RegressionModel
end

StatsAPI.modelmatrix(::MyRegressionModel2) = [1 2; 1 2]
StatsAPI.vcov(::MyRegressionModel2) = [1 0; 0 1]

struct MyRegressionModel3 <: RegressionModel
end

StatsAPI.modelmatrix(::MyRegressionModel3) = [1 2 3; 1 2 3]
StatsAPI.vcov(::MyRegressionModel3) = [1 0 0; 0 1 0; 0 0 1]


@testset "TestRegressionModel" begin
    m = MyRegressionModel()

    @test crossmodelmatrix(m) == [10 14; 14 20]
    @test crossmodelmatrix(m) isa Symmetric

    # no intercept term
    @test_throws ArgumentError vif(m)

    m2 = MyRegressionModel2()
    # only one non intercept term
    @test_throws ArgumentError vif(m2)

    m3 = MyRegressionModel3()
    # vcov is identity, so the VIF is just 1
    @test vif(m3) ≈ [1, 1]
end

end # module TestRegressionModel
