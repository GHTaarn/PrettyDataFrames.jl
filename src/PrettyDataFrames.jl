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

A wrapper for a `DataFrame` with custom formatting of each column.
The wrapped `DataFrame` itself can be accessed through the `df` field.

# Example
```julia
using DataFrames, PrettyDataFrames

x=PrettyDataFrame(DataFrame(a=rand(6), b=rand(6), c=1:6), :a => "%e", :b => "%9.1f")
filter!(:c => >(2), x.df)
display(x)
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
