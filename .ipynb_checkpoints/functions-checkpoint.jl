using LinearAlgebra

function energy(particles,m,N)

    velocities = []
    for i ∈ 1:N
        push!(velocities,particles[i,:]'particles[i,:])
    end
    energy = m * sum(velocities)/2
    return energy
end

function convert_to_float_array(strings)
    float_arrays = []
    for str in strings
        # Remove a parte "Any[" e o fechamento "]"
        cleaned_str = replace(str, r"Any\[" => "[")
        
        # Avalia a string como uma expressão
        float_array = eval(Meta.parse(cleaned_str))
        
        # Adiciona o array de floats ao array final
        push!(float_arrays, float_array)
    end
    return float_arrays
end