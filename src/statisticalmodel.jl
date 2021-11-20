"""
    StatisticalModel

Abstract supertype for all statistical models.
"""
abstract type StatisticalModel end

"""
    coef(model::StatisticalModel)

Return the coefficients of the model.
"""
function coef end

"""
    coefnames(model::StatisticalModel)

Return the names of the coefficients.
"""
function coefnames end

"""
    coeftable(model::StatisticalModel; level::Real=0.95)

Return a table with coefficients and related statistics of the model.
`level` determines the level for confidence intervals (by default, 95%).

The returned `CoefTable` object implements the
[Tables.jl](https://github.com/JuliaData/Tables.jl/) interface, and can be
converted e.g. to a `DataFrame` via `using DataFrames; DataFrame(coeftable(model))`.
"""
function coeftable end

"""
    confint(model::StatisticalModel; level::Real=0.95)

Compute confidence intervals for coefficients, with confidence level `level` (by default 95%).
"""
function confint end

"""
    deviance(model::StatisticalModel)

Return the deviance of the model relative to a reference, which is usually when applicable
the saturated model. It is equal, *up to a constant*, to ``-2 \\log L``, with ``L``
the likelihood of the model.
"""
function deviance end

"""
    islinear(model::StatisticalModel)

Indicate whether the model is linear.
"""
function islinear end

"""
    nulldeviance(model::StatisticalModel)

Return the deviance of the null model, that is the one including only the intercept.
"""
function nulldeviance end

"""
    loglikelihood(model::StatisticalModel)
    loglikelihood(model::StatisticalModel, observation)

Return the log-likelihood of the model.

With an `observation` argument, return the contribution of `observation` to the
log-likelihood of `model`.

If `observation` is a `Colon`, return a vector of each observation's contribution
to the log-likelihood of the model. In other words, this is the vector of the
pointwise log-likelihood contributions.

In general, `sum(loglikehood(model, :)) == loglikelihood(model)`.
"""
function loglikelihood end

"""
    nullloglikelihood(model::StatisticalModel)

Return the log-likelihood of the null model corresponding to `model`.
This is usually the model containing only the intercept.
"""
function nullloglikelihood end

"""
    score(model::StatisticalModel)

Return the score of the model, that is the gradient of the
log-likelihood with respect to the coefficients.
"""
function score end

"""
    nobs(model::StatisticalModel)

Return the number of independent observations on which the model was fitted. Be careful
when using this information, as the definition of an independent observation may vary
depending on the model, on the format used to pass the data, on the sampling plan
(if specified), etc.
"""
function nobs end

"""
    dof(model::StatisticalModel)

Return the number of degrees of freedom consumed in the model, including
when applicable the intercept and the distribution's dispersion parameter.
"""
function dof end

"""
    mss(model::StatisticalModel)

Return the model sum of squares.
"""
function mss end

"""
    rss(model::StatisticalModel)

Return the residual sum of squares of the model.
"""
function rss end

"""
    informationmatrix(model::StatisticalModel; expected::Bool = true)

Return the information matrix of the model. By default the Fisher information matrix
is returned, while the observed information matrix can be requested with `expected = false`.
"""
function informationmatrix end

"""
    stderror(model::StatisticalModel)

Return the standard errors for the coefficients of the model.
"""
function stderror end

"""
    vcov(model::StatisticalModel)

Return the variance-covariance matrix for the coefficients of the model.
"""
function vcov end

"""
    weights(model::StatisticalModel)

Return the weights used in the model.
"""
function weights end

"""
    isfitted(model::StatisticalModel)

Indicate whether the model has been fitted.
"""
function isfitted end

"""
Fit a statistical model.
"""
function fit end

"""
Fit a statistical model in-place.
"""
function fit! end

"""
    aic(model::StatisticalModel)

Akaike's Information Criterion, defined as ``-2 \\log L + 2k``, with ``L`` the likelihood
of the model, and `k` its number of consumed degrees of freedom
(as returned by [`dof`](@ref)).
"""
aic(model::StatisticalModel) = -2loglikelihood(model) + 2dof(model)

"""
    aicc(model::StatisticalModel)

Corrected Akaike's Information Criterion for small sample sizes (Hurvich and Tsai 1989),
defined as ``-2 \\log L + 2k + 2k(k-1)/(n-k-1)``, with ``L`` the likelihood of the model,
``k`` its number of consumed degrees of freedom (as returned by [`dof`](@ref)),
and ``n`` the number of observations (as returned by [`nobs`](@ref)).
"""
function aicc(model::StatisticalModel)
    k = dof(model)
    n = nobs(model)
    -2loglikelihood(model) + 2k + 2k*(k+1)/(n-k-1)
end

"""
    bic(model::StatisticalModel)

Bayesian Information Criterion, defined as ``-2 \\log L + k \\log n``, with ``L``
the likelihood of the model,  ``k`` its number of consumed degrees of freedom
(as returned by [`dof`](@ref)), and ``n`` the number of observations
(as returned by [`nobs`](@ref)).
"""
bic(model::StatisticalModel) = -2loglikelihood(model) + dof(model)*log(nobs(model))

"""
    r2(model::StatisticalModel)
    r²(model::StatisticalModel)

Coefficient of determination (R-squared).

For a linear model, the R² is defined as ``ESS/TSS``, with ``ESS`` the explained sum of squares
and ``TSS`` the total sum of squares.
"""
function r2 end

const r² = r2

"""
    adjr2(model::StatisticalModel)
    adjr²(model::StatisticalModel)

Adjusted coefficient of determination (adjusted R-squared).

For linear models, the adjusted R² is defined as ``1 - (1 - (1-R^2)(n-1)/(n-p))``, with ``R^2``
the coefficient of determination, ``n`` the number of observations, and ``p`` the number of
coefficients (including the intercept). This definition is generally known as the Wherry Formula I.
"""
function adjr2 end

const adjr² = adjr2
