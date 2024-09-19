using LinearAlgebra

function energy(particles,m,N)

    velocities = []
    for i ∈ 1:N
        push!(velocities,particles[i,:]'particles[i,:])
    end
    energy = m * sum(velocities)/2
    return energy
end