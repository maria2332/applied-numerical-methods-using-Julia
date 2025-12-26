# using Plots

# # Definir la función f(x)
# f(x) = (1 / (1 + 2 * abs(x)^3))^(-1/3)

# # Implementar el algoritmo de Neville
# function neville(x, y, x_interp)
#     n = length(x)
#     Q = zeros(n, n)
#     for i in 1:n
#         Q[i, 1] = y[i]
#     end
#     for j in 2:n
#         for i in j:n
#             Q[i, j] = ((x_interp - x[i-j+1]) * Q[i, j-1] - (x_interp - x[i]) * Q[i-1, j-1]) / (x[i] - x[i-j+1])
#         end
#     end
#     return Q[n, n]
# end

# # Generar nodos equiespaciados y realizar la interpolación
# function interpolate_and_plot(n_nodes)
#     x_nodes = range(-1, 1, length=n_nodes)
#     y_nodes = f.(x_nodes)
#     x_vals = range(-1, 1, length=500)
#     y_vals = f.(x_vals)
#     y_interp = [neville(x_nodes, y_nodes, x) for x in x_vals]

#     plot(x_vals, y_vals, label="f(x)", lw=2, title="Interpolación con $n_nodes nodos")
#     plot!(x_vals, y_interp, label="Interpolación Neville ($n_nodes nodos)", lw=2, linestyle=:dash)
# end

# # Crear la cuadrícula de gráficos 2x2
# p1 = interpolate_and_plot(4)
# p2 = interpolate_and_plot(8)
# p3 = interpolate_and_plot(12)
# p4 = interpolate_and_plot(16)

# plot(p1, p2, p3, p4, layout=(2, 2), size=(900, 700))


using Plots

# Definición de la función f(x)
function f(x)
    return 1 / (1 + 2 * abs(x)^3)^(-1/3)
end

# Cálculo de coeficientes de diferencias divididas
function divided_differences(x, fx)
    n = length(x)
    coef = copy(fx)
    for j in 2:n
        for i in n:-1:j
            coef[i] = (coef[i] - coef[i-1]) / (x[i] - x[i-j+1])
        end
    end
    return coef
end

# Evaluación del polinomio de Newton
function newton_polynomial(x, coef, val)
    n = length(coef)
    result = coef[n]
    for i in n-1:-1:1
        result = result * (val - x[i]) + coef[i]
    end
    return result
end

# Función de interpolación de Newton
function Newton(x, fx, val)
    coef = divided_differences(x, fx)
    return newton_polynomial(x, coef, val)
end

# Nodos equiespaciados y evaluación de la interpolación
nodos = [4, 8, 12, 16]
x_vals = range(-5, stop=5, length=1000)
f_vals = f.(x_vals)

# Gráfica de la función original
plot(x_vals, f_vals, label="f(x)", color=:blue, xlabel="x", ylabel="f(x)", title="Interpolación de f(x) con el polinomio de Newton", legend=:bottomright)

for n in nodos
    x_nodes = range(-5, stop=5, length=n)
    fx_nodes = f.(x_nodes)
    
    # Evaluación del polinomio de Newton en los puntos del dominio
    newton_vals = [Newton(x_nodes, fx_nodes, val) for val in x_vals]
    
    # Gráfica del polinomio interpolador
    plot!(x_vals, newton_vals, label="Interpolación con $n nodos")
end

# Mostrar la gráfica
plot!()
