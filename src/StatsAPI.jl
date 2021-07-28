module StatsAPI

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
    nobs(dataset)

Return the number of observations in the dataset. 
"""
function nobs end

end # module
