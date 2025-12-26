using Polynomials
using Plots

# Definimos la función f(x)
f(x) = 1 / (1 + 2 * abs(x)^3)^(-1/3)

# Derivada de la función f'(x)
f_prime(x) = (2 * 3 * abs(x)^2 * sign(x)) * (1 / (3 * (1 + 2 * abs(x)^3)^(4/3)))

# Función para calcular nodos de Hermite
function hermite_interpolation(x, fx, fpx, x_vals)
    n = length(x)
    z = zeros(2n)
    Q = zeros(2n, 2n)
    
    for i in 1:n
        z[2i-1] = x[i]
        z[2i] = x[i]
        Q[2i-1, 1] = fx[i]
        Q[2i, 1] = fx[i]
        Q[2i, 2] = fpx[i]
        if i > 1
            Q[2i-1, 2] = (Q[2i-1, 1] - Q[2i-2, 1]) / (z[2i-1] - z[2i-2])
        end
    end
    
    for j in 3:2n
        for i in j:2n
            Q[i, j] = (Q[i, j-1] - Q[i-1, j-1]) / (z[i] - z[i-j+1])
        end
    end
    
    function H(x_val)
        sum = Q[1, 1]
        product = 1.0
        for i in 2:2n
            product *= (x_val - z[i-1])
            sum += Q[i, i] * product
        end
        return sum
    end
    
    return H.(x_vals)
end

# Valores de x para evaluar la función interpolada
x_vals = range(-5, stop=5, length=1000)
f_vals = f.(x_vals)

# Nodos equiespaciados
nodos = [4, 8, 12, 16]

# Gráfica de la función original
plot(x_vals, f_vals, label="f(x)", color=:blue, xlabel="x", ylabel="f(x)", title="Interpolación de f(x) con Polinomios de Hermite")

for n in nodos
    x_nodes = range(-5, stop=5, length=n)
    fx_nodes = f.(x_nodes)
    fpx_nodes = f_prime.(x_nodes)
    
    # Interpolación de Hermite
    hermite_vals = hermite_interpolation(x_nodes, fx_nodes, fpx_nodes, x_vals)
    plot!(x_vals, hermite_vals, label="Hermite $n nodos")
end

# Mostrar la gráfica
plot!()
