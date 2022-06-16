module TestRegressionModel

using Test, LinearAlgebra, StatsAPI
using StatsAPI: RegressionModel, crossmodelmatrix

struct MyRegressionModel <: RegressionModel
end

struct ItsRegressionModel <: RegressionModel
    wts
end

StatsAPI.modelmatrix(::MyRegressionModel) = [1 2; 3 4]

function StatsAPI.modelmatrix(r::ItsRegressionModel; weighted::Bool=false)  
    X = [1 2; 3 4]
    weighted ? sqrt.(r.wts).*X : X 
end

w = [0.3, 0.2]

@testset "TestRegressionModel" begin
    m = MyRegressionModel()
    r = ItsRegressionModel(w)

    @test crossmodelmatrix(m) == [10 14; 14 20]
    @test crossmodelmatrix(m; weighted=false) == [10 14; 14 20]
    @test crossmodelmatrix(m) isa Symmetric

    @test crossmodelmatrix(r) == [10 14; 14 20]
    @test crossmodelmatrix(r; weighted=false) == [10 14; 14 20]
    @test crossmodelmatrix(r; weighted=true) ≈ [2.1 3.0; 3.0 4.4]
    @test crossmodelmatrix(r; weighted=true) isa Symmetric

end

end # module TestRegressionModel