using Distributions
using Random

function y(x)
    return x^2
end


a = 0

b = 2
iter = 2000

yy = []

for i ∈ 1:iter
    x = rand(Uniform(a,b))
    push!(yy,y(x))
end

println("A área é ", (b-a)*mean(yy))