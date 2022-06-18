"""
    RegressionModel <: StatisticalModel

Abstract supertype for all regression models.
"""
abstract type RegressionModel <: StatisticalModel end

"""
    fitted(model::RegressionModel)

Return the fitted values of the model.
"""
function fitted end

"""
    response(model::RegressionModel)

Return the model response (a.k.a. the dependent variable).
"""
function response end

"""
    responsename(model::RegressionModel)

Return the name of the model response (a.k.a. the dependent variable).
"""
function responsename end

"""
    meanresponse(model::RegressionModel)

Return the mean of the response.
"""
function meanresponse end

"""
    modelmatrix(model::RegressionModel; weighted::Bool=false)

Return the model matrix (design matrix) or, if `weighted=true` the weighted 
model matrix, i.e. `X * sqrt.(W)`, where `X` is the model matrix and
`W` is the diagonal matrix whose elements are the [model weights](@ref weights(::StatisticalModel)). 
"""
function modelmatrix(model::RegressionModel; weighted::Bool=false) end

"""
    crossmodelmatrix(model::RegressionModel; weighted::Bool=false)

Return `X'X` where `X` is the model/design matrix of `model` or, if `weighted=true`, `X'WX`, 
where `W` is the diagonal matrix whose elements are the [model weights](@ref weights(::StatisticalModel)). 
This function will return a pre-computed matrix stored in `model` if possible.
"""
function crossmodelmatrix(model::RegressionModel; weighted::Bool=false) 
    x = weighted ? modelmatrix(model; weighted=weighted) : modelmatrix(model)
    return Symmetric(x' * x)
end

"""
    leverage(model::RegressionModel)

Return the diagonal of the projection matrix of the model.
"""
function leverage end

"""
    cooksdistance(model::RegressionModel)

Compute [Cook's distance](https://en.wikipedia.org/wiki/Cook%27s_distance)
for each observation in linear model `model`, giving an estimate of the influence
of each data point.
"""
function cooksdistance end

"""
    residuals(model::RegressionModel; weighted::Bool=false)

Return the residuals of the model or, if `weighted=true`, the residuals multiplied by
the square root of the [model weights](@ref weights(::StatisticalModel)). 

"""
function residuals(model::RegressionModel; weighted::Bool=false) end

"""
    predict(model::RegressionModel, [newX])

Form the predicted response of `model`. An object with new covariate values `newX` can be supplied,
which should have the same type and structure as that used to fit `model`; e.g. for a GLM
it would generally be a `DataFrame` with the same variable names as the original predictors.
"""
function predict end

"""
    predict!

In-place version of [`predict`](@ref).
"""
function predict! end

"""
    dof_residual(model::RegressionModel)

Return the residual degrees of freedom of the model.
"""
function dof_residual end

"""
    reconstruct(model::RegressionModel[, newY])

Reconstruct explanatory variables from `model`.
An object with new response values `newX` can be supplied, which should have
the same type and structure as the output of [`predict(model)`](@ref).
"""
function reconstruct end

"""
    reconstruct!

In-place version of [`reconstruct`](@ref).
"""
function reconstruct! end

"""
    offset(model::RegressionModel)

Return the offset used in the model, i.e. the term added to the linear predictor with
known coefficient 1.
"""
function offset end
