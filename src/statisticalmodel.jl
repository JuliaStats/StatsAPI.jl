"""
    StatisticalModel

Abstract supertype for all statistical models.
"""
abstract type StatisticalModel end

"""
    coef(model::StatisticalModel)

Return the coefficients of the model.
"""
coef(model::StatisticalModel) = error("coef is not defined for $(typeof(model)).")

"""
    coefnames(model::StatisticalModel)

Return the names of the coefficients.
"""
coefnames(model::StatisticalModel) = error("coefnames is not defined for $(typeof(model)).")

"""
    coeftable(model::StatisticalModel; level::Real=0.95)

Return a table with coefficients and related statistics of the model.
`level` determines the level for confidence intervals (by default, 95%).

The returned `CoefTable` object implements the
[Tables.jl](https://github.com/JuliaData/Tables.jl/) interface, and can be
converted e.g. to a `DataFrame` via `using DataFrames; DataFrame(coeftable(model))`.
"""
coeftable(model::StatisticalModel) = error("coeftable is not defined for $(typeof(model)).")

"""
    confint(model::StatisticalModel; level::Real=0.95)

Compute confidence intervals for coefficients, with confidence level `level` (by default 95%).
"""
confint(model::StatisticalModel) = error("confint is not defined for $(typeof(model)).")

"""
    deviance(model::StatisticalModel)

Return the deviance of the model relative to a reference, which is usually when applicable
the saturated model. It is equal, *up to a constant*, to ``-2 \\log L``, with ``L``
the likelihood of the model.
"""
deviance(model::StatisticalModel) = error("deviance is not defined for $(typeof(model)).")

"""
    islinear(model::StatisticalModel)

Indicate whether the model is linear.
"""
islinear(model::StatisticalModel) = error("islinear is not defined for $(typeof(model)).")

"""
    nulldeviance(model::StatisticalModel)

Return the deviance of the null model, that is the one including only the intercept.
"""
nulldeviance(model::StatisticalModel) =
    error("nulldeviance is not defined for $(typeof(model)).")

"""
    loglikelihood(model::StatisticalModel)

Return the log-likelihood of the model.
"""
loglikelihood(model::StatisticalModel) =
    error("loglikelihood is not defined for $(typeof(model)).")

"""
    loglikelihood(model::StatisticalModel)

Return the log-likelihood of the null model corresponding to `model`.
This is usually the model containing only the intercept.
"""
nullloglikelihood(model::StatisticalModel) =
    error("nullloglikelihood is not defined for $(typeof(model)).")

"""
    loglikelihood(model::StatisticalModel, ::Colon)

Return a vector of each observation's contribution to the log-likelihood of the model.
In other words, this is the vector of the pointwise log-likelihood contributions.

In general, `sum(loglikehood(model, :)) == loglikelihood(model)`.
"""
loglikelihood(model::StatisticalModel, ::Colon) =
    error("loglikelihood(model::StatisticalModel, ::Colon) is not defined for $(typeof(model)).")

"""
    loglikelihood(model::StatisticalModel, observation)

Return the contribution of `observation` to the log-likelihood of `model`.
"""
loglikelihood(model::StatisticalModel, observation) =
    error("loglikelihood(model::StatisticalModel, observation) is not defined for $(typeof(model)).")

"""
    score(model::StatisticalModel)

Return the score of the model, that is the gradient of the
log-likelihood with respect to the coefficients.
"""
score(model::StatisticalModel) = error("score is not defined for $(typeof(model)).")

"""
    nobs(model::StatisticalModel)

Return the number of independent observations on which the model was fitted. Be careful
when using this information, as the definition of an independent observation may vary
depending on the model, on the format used to pass the data, on the sampling plan
(if specified), etc.
"""
nobs(model::StatisticalModel) = error("nobs is not defined for $(typeof(model)).")

"""
    dof(model::StatisticalModel)

Return the number of degrees of freedom consumed in the model, including
when applicable the intercept and the distribution's dispersion parameter.
"""
dof(model::StatisticalModel) = error("dof is not defined for $(typeof(model)).")

"""
    mss(model::StatisticalModel)

Return the model sum of squares.
"""
mss(model::StatisticalModel) = error("mss is not defined for $(typeof(model)).")

"""
    rss(model::StatisticalModel)

Return the residual sum of squares of the model.
"""
rss(model::StatisticalModel) = error("rss is not defined for $(typeof(model)).")

"""
    informationmatrix(model::StatisticalModel; expected::Bool = true)

Return the information matrix of the model. By default the Fisher information matrix
is returned, while the observed information matrix can be requested with `expected = false`.
"""
informationmatrix(model::StatisticalModel; expected::Bool=true) =
    error("informationmatrix is not defined for $(typeof(model)).")

"""
    stderror(model::StatisticalModel)

Return the standard errors for the coefficients of the model.
"""
stderror(model::StatisticalModel) = sqrt.(diag(vcov(model)))

"""
    vcov(model::StatisticalModel)

Return the variance-covariance matrix for the coefficients of the model.
"""
vcov(model::StatisticalModel) = error("vcov is not defined for $(typeof(model)).")

"""
    weights(model::StatisticalModel)

Return the weights used in the model.
"""
weights(model::StatisticalModel) = error("weights is not defined for $(typeof(model)).")

"""
    isfitted(model::StatisticalModel)

Indicate whether the model has been fitted.
"""
isfitted(model::StatisticalModel) = error("isfitted is not defined for $(typeof(model)).")

"""
Fit a statistical model.
"""
fit(model::StatisticalModel, args...) = error("fit is not defined for $(typeof(model)).")

"""
Fit a statistical model in-place.
"""
fit!(model::StatisticalModel, args...) = error("fit! is not defined for $(typeof(model)).")

# Defined and documented for `StatisticalModel` in StatsBase
function aic end
function aicc end
function bic end

"""
    r2(model::StatisticalModel)
    r²(model::StatisticalModel)

Coefficient of determination (R-squared).

For a linear model, the R² is defined as ``ESS/TSS``, with ``ESS`` the explained sum of squares
and ``TSS`` the total sum of squares.
"""
r2(model::StatisticalModel) = error("r2/r² is not defined for $(typeof(model)).")

const r² = r2

"""
    adjr2(model::StatisticalModel)
    adjr²(model::StatisticalModel)

Adjusted coefficient of determination (adjusted R-squared).

For linear models, the adjusted R² is defined as ``1 - (1 - (1-R^2)(n-1)/(n-p))``, with ``R^2``
the coefficient of determination, ``n`` the number of observations, and ``p`` the number of
coefficients (including the intercept). This definition is generally known as the Wherry Formula I.
"""
adjr2(model::StatisticalModel) = error("adjr2 is not defined for $(typeof(model)).")

const adjr² = adjr2
