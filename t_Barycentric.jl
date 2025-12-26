using Plots
using Interpolations

# Definición de la función
function f(x)
    return 1 / (1 + 2 * abs(x)^3)^(-1/3)
end

# Rango de evaluación
x_vals = range(-5, stop=5, length=1000)
f_vals = f.(x_vals)

# Número de nodos a considerar
nodos = [4, 8, 12, 16]

# Gráfica base de la función real
plot(x_vals, f_vals, label="f(x)", color=:blue, xlabel="x", ylabel="f(x)", title="Interpolación de f(x) con Barycentric")

# Realizar interpolación barycentric para diferentes números de nodos
for n in nodos
    x_nodes = range(-5, stop=5, length=n)
    fx_nodes = f.(x_nodes)
    bary_interp = LinearInterpolation(x_nodes, fx_nodes, extrapolation_bc=Flat())
    barycentric_vals = bary_interp.(x_vals)
    plot!(x_vals, barycentric_vals, label="Barycentric $n nodos")
end

# Mostrar la gráfica
plot!()

