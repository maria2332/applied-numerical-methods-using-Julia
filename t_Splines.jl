using Dierckx

# Gráfica
plot(x_vals, f_vals, label="f(x)", color=:blue, xlabel="x", ylabel="f(x)", title="Interpolación de f(x) con Trazadores Cúbicos")

for n in nodos
    x_nodes_eq = range(-5, stop=5, length=n)
    fx_nodes_eq = f.(x_nodes_eq)
    spline_eq = Spline1D(x_nodes_eq, fx_nodes_eq)
    spline_vals_eq = spline_eq.(x_vals)
    plot!(x_vals, spline_vals_eq, label="Spline Cúbico $n nodos")
end

# Mostrar la gráfica
plot!()