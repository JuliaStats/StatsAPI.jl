"""
    RegressionModel <: StatisticalModel

Abstract supertype for all regression models.
"""
abstract type RegressionModel <: StatisticalModel end

"""
    fitted(model::RegressionModel)

Return the fitted values of the model.
"""
fitted(model::RegressionModel) = error("fitted is not defined for $(typeof(model)).")

"""
    response(model::RegressionModel)

Return the model response (a.k.a. the dependent variable).
"""
response(model::RegressionModel) = error("response is not defined for $(typeof(model)).")

"""
    responsename(model::RegressionModel)

Return the name of the model response (a.k.a. the dependent variable).
"""
responsename(model::RegressionModel) = error("responsename is not defined for $(typeof(model)).")

"""
    meanresponse(model::RegressionModel)

Return the mean of the response.
"""
meanresponse(model::RegressionModel) = error("meanresponse is not defined for $(typeof(model)).")

"""
    modelmatrix(model::RegressionModel)

Return the model matrix (a.k.a. the design matrix).
"""
modelmatrix(model::RegressionModel) = error("modelmatrix is not defined for $(typeof(model)).")

"""
    crossmodelmatrix(model::RegressionModel)

Return `X'X` where `X` is the model matrix of `model`.
This function will return a pre-computed matrix stored in `model` if possible.
"""
crossmodelmatrix(model::RegressionModel) = (x = modelmatrix(model); Symmetric(x' * x))

"""
    leverage(model::RegressionModel)

Return the diagonal of the projection matrix of the model.
"""
leverage(model::RegressionModel) = error("leverage is not defined for $(typeof(model)).")

"""
    cooksdistance(model::RegressionModel)

Compute [Cook's distance](https://en.wikipedia.org/wiki/Cook%27s_distance)
for each observation in linear model `model`, giving an estimate of the influence
of each data point.
"""
cooksdistance(model::RegressionModel) = error("cooksdistance is not defined for $(typeof(model)).")

"""
    residuals(model::RegressionModel)

Return the residuals of the model.
"""
residuals(model::RegressionModel) = error("residuals is not defined for $(typeof(model)).")

"""
    predict(model::RegressionModel, [newX])

Form the predicted response of `model`. An object with new covariate values `newX` can be supplied,
which should have the same type and structure as that used to fit `model`; e.g. for a GLM
it would generally be a `DataFrame` with the same variable names as the original predictors.
"""
function predict end

predict(model::RegressionModel) = error("predict is not defined for $(typeof(model)).")

"""
    predict!

In-place version of [`predict`](@ref).
"""
function predict! end

predict!(model::RegressionModel) = error("predict! is not defined for $(typeof(model)).")

"""
    dof_residual(model::RegressionModel)

Return the residual degrees of freedom of the model.
"""
dof_residual(model::RegressionModel) = error("dof_residual is not defined for $(typeof(model)).")
