using Plots

# Definir la función f(x)
f(x) = (1 / (1 + 2 * abs(x)^3))^(-1/3)

# Implementar el algoritmo de Neville
function neville(x, y, x_interp)
    n = length(x)
    Q = zeros(n, n)
    for i in 1:n
        Q[i, 1] = y[i]
    end
    for j in 2:n
        for i in j:n
            Q[i, j] = ((x_interp - x[i-j+1]) * Q[i, j-1] - (x_interp - x[i]) * Q[i-1, j-1]) / (x[i] - x[i-j+1])
        end
    end
    return Q[n, n]
end

# Generar nodos de Chebyshev
function chebyshev_nodes(n, a, b)
    return [(a + b)/2 + (b - a)/2 * cos((2k - 1) * π / (2n)) for k in 1:n]
end

# Generar nodos equiespaciados y realizar la interpolación
function interpolate_and_plot(n_nodes, use_chebyshev=false)
    if use_chebyshev
        x_nodes = chebyshev_nodes(n_nodes, -1, 1)
    else
        x_nodes = range(-1, 1, length=n_nodes)
    end
    y_nodes = f.(x_nodes)
    x_vals = range(-1, 1, length=500)
    y_vals = f.(x_vals)
    y_interp = [neville(x_nodes, y_nodes, x) for x in x_vals]

    plot(x_vals, y_vals, label="f(x)", lw=2, title="Interpolación con $n_nodes nodos")
    plot!(x_vals, y_interp, label="Interpolación Neville ($n_nodes nodos)", lw=2, linestyle=:dash)
end

# Crear la cuadrícula de gráficos 2x2
p1 = interpolate_and_plot(4, true)
p2 = interpolate_and_plot(8, true)
p3 = interpolate_and_plot(12, true)
p4 = interpolate_and_plot(16, true)

plot(p1, p2, p3, p4, layout=(2, 2), size=(900, 700))
