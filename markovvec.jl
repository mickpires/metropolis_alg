using Random
using Distributions
include("functions.jl")


function markov(N,m,T,velocities,iter)

    particulas = rand(Uniform(-velocities,velocities),N,2)
    k_B = 1.38e-23
    β = 1/(k_B*T)
    ΔEE = []
    EE = []

    tentativas = 0
    tentativas_sucesso = 0

    #implementar o algoritmo de cadeia de markov aqui embaixo

    for loops ∈ 1:iter
        new_particulas = copy(particulas)
        println("loop: ",loops)
        println("tentativas ",tentativas)
        for i ∈ 1:N
                while true
                    tentativas += 1
                    rnd_x = rand(Uniform(-velocities,velocities))
                    rnd_y = rand(Uniform(-velocities,velocities))
                    new_particulas[i,1] = rnd_x
                    new_particulas[i,2] = rnd_y

                    ΔE = energy(new_particulas,m,N) - energy(particulas,m,N)
                    if ΔE ≤ 0
                        tentativas_sucesso += 1
                        particulas = copy(new_particulas)
                        break
                    else
                        random_energy = rand(Uniform(0,1))
                        if random_energy ≤ exp(-β* ΔE)
                            particulas = copy(new_particulas)
                            tentativas_sucesso += 1
                            break
                        end
                    end
                end
        end
        local ΔE
        push!(EE,energy(particulas,m,N))
        push!(ΔEE,ΔE)

    end
    return ΔEE, tentativas_sucesso/tentativas, EE, particulas, β
end
