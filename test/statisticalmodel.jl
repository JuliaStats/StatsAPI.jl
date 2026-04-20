module TestStatisticalModel

using Test, StatsAPI
using StatsAPI: ConvergenceException, StatisticalModel, stderror, aic, aicc, bic,
                r2, r², adjr2, adjr²

struct MyStatisticalModel <: StatisticalModel
end

StatsAPI.vcov(::MyStatisticalModel) = [1 2; 3 4]
StatsAPI.loglikelihood(::MyStatisticalModel) = 3
StatsAPI.nullloglikelihood(::MyStatisticalModel) = 4
StatsAPI.deviance(::MyStatisticalModel) = 25
StatsAPI.nulldeviance(::MyStatisticalModel) = 40
StatsAPI.dof(::MyStatisticalModel) = 5
StatsAPI.nobs(::MyStatisticalModel) = 100

@testset "StatisticalModel" begin
    m = MyStatisticalModel()

    @test stderror(m) == [1, 2]
    @test aic(m) == 4
    @test aicc(m) ≈ 4.638297872340425
    @test bic(m) ≈ 17.02585092994046
    @test r2(m, :McFadden) ≈ 0.25
    @test r2(m, :CoxSnell) ≈ -0.020201340026755776
    @test r2(m, :Nagelkerke) ≈ 0.24255074155803877
    @test r2(m, :devianceratio) ≈ 0.375

    @test_throws ArgumentError r2(m, :err)
    @test_throws MethodError r2(m)
    @test adjr2(m, :McFadden) ≈ 1.5
    @test adjr2(m, :devianceratio) ≈ 0.3486842105263158
    @test_throws ArgumentError adjr2(m, :err)

    @test r2 === r²
    @test adjr2 === adjr²
end

@testset "ConvergenceException" begin
    fail = "failure to converge after 10 iterations"
    chgtol = "last change between iterations (0.2) was greater than tolerance (0.1)"
    msg = "Try changing maxiter."
    @test sprint(showerror, ConvergenceException(10)) == "$fail."
    @test sprint(showerror, ConvergenceException(10, 0.2, 0.1)) == "$fail; $chgtol."
    @test sprint(showerror, ConvergenceException(10, 0.2, 0.1, msg)) == "$fail; $chgtol. $msg"
    err = @test_throws ArgumentError ConvergenceException(10, 0.1, 0.2)
    @test err.value.msg == string("can't construct `ConvergenceException` with change ",
                                  "less than tolerance; got 0.1 and 0.2")
end

end # module TestStatisticalModel
