function genmod()
    Core.eval(:(module $(gensym()) end))
end

function valid_method(expr::Expr)
    try
        !isempty(methods(eval(genmod(), expr)))
    catch
        false
    end
end

macro valid_method(expr)
    result = quote
        valid_method($(QuoteNode(expr)))
    end
    Base.remove_linenums!(result)
    return esc(result)
end

include("ingest_parametric.jl")
include("ingest_assertion.jl")
include("ingest_default.jl")
include("ingest_parameter.jl")
include("ingest_signature.jl")
VERSION >= v"0.6" && include("ingest_signature_0.6.jl")