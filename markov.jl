using Random
using Distributions
include("functions.jl")


function markov(N,r, α, γ,T,iter)
    
    A = N*π*r^2/γ
    xmax = sqrt(A)
    particulas = rand(Uniform(0,xmax),N,2)

    k_B = 1.38e-23
    β = k_B*T
    EE = []

    tentativas = 0
    tentativas_sucesso = 0

    #implementar o algoritmo de cadeia de markov aqui embaixo

    for loops ∈ 1:iter
        new_particulas = copy(particulas)
        println("loop: ",loops)
        for i ∈ 1:N
                while true
                    tentativas += 1
                    rnd_x = rand(Uniform(-1,1))
                    rnd_y = rand(Uniform(-1,1))
                    new_particulas[i,1] += α*rnd_x
                    new_particulas[i,2] += α*rnd_y

                    for j in 1:2

                        if new_particulas[i,j] > xmax
                            new_particulas[i,j] -= xmax
                        end
                        if new_particulas[i,j] < 0
                            new_particulas[i,j] += xmax
                        end
                    
                    end
                    for j ∈ 1:N
                        if i ≠ j
                            if norm(new_particulas[i] - new_particulas[j]) ≤ 2*r
                                continue
                            end
                        end
                    end

                    ΔE = energy(new_particulas) - energy(particulas)

                    if ΔE ≤ 0
                        tentativas_sucesso += 1
                        break
                    else
                        random_energy = rand(Uniform(0,1))
                        if random_energy ≤ β * ΔE
                            tentativas_sucesso += 1
                            break
                        end
                    end
                end
        end
        local ΔE
        push!(EE,ΔE)

    end
    println("A razão entre sucessos e tentativas é: ",tentativas_sucesso/tentativas)
    return EE, tentativas_sucesso/tentativas
end
