module TestRegressionModel

using Test, LinearAlgebra, StatsAPI
using StatsAPI: RegressionModel, hasintercept, crossmodelmatrix

struct MyRegressionModel <: RegressionModel
end

StatsAPI.modelmatrix(::MyRegressionModel) = [1 2; 3 4]

@testset "TestRegressionModel" begin
    m = MyRegressionModel()
    
    @test !hasintercept(m) 
    @test crossmodelmatrix(m) == [10 14; 14 20]
    @test crossmodelmatrix(m) isa Symmetric
end

end # module TestRegressionModel
