# PrettyDataFrames.jl

Provides a wrapper for a [DataFrame](https://github.com/JuliaData/DataFrames.jl)
object that gives better control over how each column is displayed.

## Installation
```julia
using Pkg
pkg"add https://github.com/GHTaarn/PrettyDataFrames.jl"
```

## Use

The only exported symbol is the `PrettyDataFrame` type which wraps a
[DataFrame](https://github.com/JuliaData/DataFrames.jl) object, e.g.

```julia
using DataFrames, PrettyDataFrames

x=PrettyDataFrame(DataFrame(a=rand(6), b=rand(6), c=1:6), :a => "%e", :b => "%9.1f")
filter!(:c => >(2), x.df)
display(x)
```

This would display the `a` and `b` columns using respectively the `%e` and
`%9.1f` [Printf](https://docs.julialang.org/en/v1/stdlib/Printf/) format
specifiers.


## Acknowledgements
Uses the [PrettyTables](https://github.com/ronisbr/PrettyTables.jl) package and
is based on Rafael Guerras post
https://discourse.julialang.org/t/is-there-a-better-way-to-format-each-individual-columns-in-a-dataframe/111677/3

