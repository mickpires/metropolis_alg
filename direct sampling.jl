using Random
using Distributions
using Plots
include("functions.jl")

N = 4

particulas = rand(Uniform(0,1),N,2)
xlim = [0,1]
ylim = [0,1]

r=1/N
k_B = 1.38e-23
T = 293
β = k_B*T
iter = 1000
EE = []
α = 3*r

# montar as posições da partícula

for loops ∈ range(0,iter)
    global particulas
    new_particulas = copy(particulas)
    for i in 1:N
        rnd_x = rand(Uniform(-1,1))
        rnd_y = rand(Uniform(-1,1))
        new_particulas[i,1] += α*rnd_x
        new_particulas[i,2] += α*rnd_y

        for j in 1:2

            if new_particulas[i,j] > 1
                new_particulas[i,j] -= 1
            end
            if new_particulas[i,j] < 0
                new_particulas[i,j] += 1
            end

        end

    end
    ΔE = energy(particulas) - energy(new_particulas)
    if ΔE ≤ 0
        particulas = copy(new_particulas)
    else
        rnd = rand(Uniform(0,1))
        if rnd > exp(-ΔE)
            continue
        else
            particulas = copy(new_particulas)
            
        end

    end
    push!(EE,ΔE)

end

println(size(1:1000))
println(size(EE))
display(plot(1:size(EE)[1],EE))

println("taxa de aceitação ", size(EE)[1]/iter)