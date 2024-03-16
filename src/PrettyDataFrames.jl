module PrettyDataFrames

export PrettyDataFrame

import Base.show

using DataFrames, PrettyTables

struct PrettyDataFrame
    df::AbstractDataFrame
    fmt::Function
end

"""
    PrettyDataFrame(df::AbstractDataFrame, fmt...)

# Example
```julia
using DataFrames, PrettyDataFrames

PrettyDataFrame(DataFrame(a=rand(4), b=rand(4), c=rand(4)), :a => "%e", :b => "%9.1f")
```
"""
function PrettyDataFrame(df::AbstractDataFrame, fmt...)
    dic = Dict(fmt...)
    d = Dict(Symbol.(names(df)) .=> 1:ncol(df))
    formatter = ft_printf(collect(values(dic)), getindex.(Ref(d),keys(dic)))
    PrettyDataFrame(df, formatter)
end


function show(io::IO, mime::MIME"text/plain", x::PrettyDataFrame)
    pretty_table(io, x.df; formatters=x.fmt)
end

end # module PrettyDataFrames
