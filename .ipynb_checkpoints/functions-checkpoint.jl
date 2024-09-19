using LinearAlgebra

function energy(particles)
    ignore_list = []
    potential = 0
    for particle1 in 1:size(particles)[1]
        if particle1 ∈ ignore_list
            continue
        end
        for particle2 in 1:size(particles)[1]
            if particle1 == particle2
                continue
            end
            potential += 4*(1/norm(particles[particle1])^6 - 1/(particles[particle2])^12)
            push!(ignore_list,particle1)
        end
    end
    
    return potential

end