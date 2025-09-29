using Test, StatsAPI

@testset "StatsAPI" begin

# Check that all names in StatsAPI are public
if isdefined(Base, :ispublic)
    names_statsapi = names(StatsAPI; all = true)
    filter!(names_statsapi) do name
        if name == :eval || name == :include
            # Ignore `eval` and `include` (available in every `module`)
            return false
        elseif startswith(string(name), "#")
            # Ignore names of the form `#xyz...`
            return false
        else
            return true
        end
    end
    @testset "public: $(name)" for name in names_statsapi
        @test Base.ispublic(StatsAPI, name)
    end
end

include("regressionmodel.jl")
include("statisticalmodel.jl")

end # @testset "StatsAPI"
