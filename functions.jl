using LinearAlgebra

function energy(particles)
    ignore_list = []
    coulomb = 0
    for particle1 in 1:size(particles)[1]
        if particle1 ∈ ignore_list
            continue
        end
        for particle2 in 1:size(particles)[1]
            if particle1 == particle2
                continue
            end
            coulomb -= 1/norm(particles[particle1] - particles[particle2])^2
            push!(ignore_list,particle1)
        end
    end
    
    return 1/2*coulomb

end