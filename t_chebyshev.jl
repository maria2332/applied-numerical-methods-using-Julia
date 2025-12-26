using Plots

# Definición de la función
function f(x)
    return 1 / (1 + 2 * abs(x)^3)^(-1/3)
end

# Generación de nodos de Chebyshev
function chebyshev_nodes(a, b, n)
    return 0.5 * (a + b) .+ 0.5 * (b - a) .* cos.((2 .* (1:n) .- 1) ./ (2n) .* π)
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

# Número de nodos
nodos = [4, 8, 12, 16]

# Gráfica
plot(x_vals, f_vals, label="f(x)", color=:blue, xlabel="x", ylabel="f(x)", title="Interpolación de f(x) con Nodos de Chebyshev", legend=:topright)

for n in nodos
    x_nodes_ch = chebyshev_nodes(-5, 5, n)
    fx_nodes_ch = f.(x_nodes_ch)
    newton_vals_ch = [Newton(x_nodes_ch, fx_nodes_ch, val) for val in x_vals]
    plot!(x_vals, newton_vals_ch, label="Polinomio de Newton Chebyshev $n nodos")
end

# Mostrar la gráfica
plot!()