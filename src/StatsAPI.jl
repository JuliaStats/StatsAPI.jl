module StatsAPI

include("regressionmodel.jl")
include("statisticalmodel.jl")

"""
    params(model)

Return all parameters of a model.
"""
params(model) = error("params is not defined for $(typeof(model))")

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

end # module
