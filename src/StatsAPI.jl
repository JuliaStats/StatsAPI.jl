module StatsAPI

using LinearAlgebra: Symmetric, diag

# https://github.com/JuliaLang/julia/pull/50105
@static if VERSION >= v"1.11.0-DEV.469"
    # statisticalmodel.jl
    eval(Expr(
        :public,
        :StatisticalModel,
        :coef,
        :coefnames,
        :coeftable,
        :confint,
        :deviance,
        :islinear,
        :nulldeviance,
        :loglikelihood,
        :nullloglikelihood,
        :score,
        :nobs,
        :dof,
        :mss,
        :rss,
        :informationmatrix,
        :stderror,
        :vcov,
        :weights,
        :isfitted,
        :fit,
        :fit!,
        :aic,
        :aicc,
        :bic,
        :r2,
        :r²,
        :adjr2,
        :adjr²,
    ))

    # regressionmodel.jl
    eval(Expr(
        :public,
        :RegressionModel,
        :fitted,
        :response,
        :responsename,
        :meanresponse,
        :modelmatrix,
        :crossmodelmatrix,
        :leverage,
        :cooksdistance,
        :residuals,
        :predict,
        :predict!,
        :dof_residual,
        :reconstruct,
        :reconstruct!,
        :offset,
        :linearpredictor,
        :linearpredictor!,
        :vif,
        :gvif,
    ))

    # StatsAPI.jl
    eval(Expr(:public, :params, :params!, :pairwise, :pairwise!, :HypothesisTest, :pvalue))
end

include("statisticalmodel.jl")
include("regressionmodel.jl")

"""
    params(model)

Return all parameters of a model.
"""
function params end

function params! end

#    pairwise(f, x[, y])
#
# Return a matrix holding the result of applying `f` to all possible pairs
# of entries in iterators `x` and `y`, and return it.
#
# This generic function is owned by StatsBase.jl, which is the sole provider
# of the default definition.
function pairwise end

#    pairwise!(f, dest::AbstractMatrix, x[, y])
#
# Store in matrix `dest` the result of applying `f` to all possible pairs
# of entries in iterators `x` and `y`, and return it.
#
# This generic function is owned by StatsBase.jl, which is the sole provider
# of the default definition.
function pairwise! end

"""
    HypothesisTest

Abstract supertype for all statistical hypothesis tests.
Subtypes must implement [`pvalue`](@ref) at a minimum and may also
implement functions such as [`teststatistic`](@ref), [`confint`](@ref),
[`nobs`](@ref), and [`dof`](@ref) as appropriate.
"""
abstract type HypothesisTest end

"""
    pvalue(test)

Compute the p-value for a given significance test.
"""
function pvalue end

"""
    teststatistic(test)

Return the test statistic for a given hypothesis test.
"""
function teststatistic end

end # module
