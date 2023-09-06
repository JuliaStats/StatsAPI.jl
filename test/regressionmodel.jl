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
end

end # module TestRegressionModel
