# using NLsolve

# # Definimos las funciones
# function system!(F, x)
#     F[1] = 3*x[1] - cos(x[2] * x[3]) - 0.5
#     F[2] = x[1]^2 - 81*(x[2] + 0.1)^2 + sin(x[3]) + 1.06
#     F[3] = exp(-x[1] * x[2]) + 20*x[3] + (10*π - 3)/3
# end

# # Proporcionamos una estimación inicial para las variables
# initial_guess = [0.1, 0.1, 0.1]

# # Utilizamos NLsolve para encontrar la solución
# solution = nlsolve(system!, initial_guess)

# # Imprimimos la solución encontrada
# println("Solution: ", solution.zero)








# using NLsolve

# # Definimos las funciones
# function system!(F, x)
#     F[1] = 3*x[1] - cos(x[2] * x[3]) - 0.5
#     F[2] = x[1]^2 - 81*(x[2] + 0.1)^2 + sin(x[3]) + 1.06
#     F[3] = exp(-x[1] * x[2]) + 20*x[3] + (10*π - 3)/3
# end

# # Diferentes estimaciones iniciales
# initial_guesses = [
#     [0.1, 0.1, 0.1],
#     [-1.0, -1.0, -1.0],
#     [1.0, 1.0, 1.0],
#     [2.0, 2.0, 2.0]
# ]

# # Probar con diferentes estimaciones iniciales
# for guess in initial_guesses
#     solution = nlsolve(system!, guess; method=:newton)
#     println("Initial guess: ", guess)
#     println("Solution: ", solution.zero)
#     println("Converged: ", converged(solution))
#     println()
# end






# using Plots
# using NLsolve

# # Definir el sistema de ecuaciones no lineales
# function sistema!(F, x)
#     F[1] = 3 * x[1] - cos(x[2] * x[3]) - 0.5
#     F[2] = x[2]^2 - 81 * (x[2] + 0.1)^2 + sin(x[3]) + 1.06
#     F[3] = exp(-x[1] * x[2]) + 20 * x[3] + ((10 * π - 3) / 3)
# end

# # Resolver el sistema de ecuaciones no lineales
# sol = nlsolve(sistema!, [0.1, 0.1, 0.1])

# # Extraer la solución
# x_sol = sol.zero

# # Gráfico de las ecuaciones
# plot(x -> 3 * x - cos(x_sol[2] * x_sol[3]) - 0.5, -2, 2, label="3x₁ - cos(x₂ * x₃) - 0.5", legend=:topright)
# plot!(x -> x^2 - 81 * (x + 0.1)^2 + sin(x_sol[3]) + 1.06, -10, 10, label="x₂^2 - 81(x₂ + 0.1)^2 + sin(x₃) + 1.06")
# plot!(x -> exp(-x_sol[1] * x) + 20 * x + ((10 * π - 3) / 3), -2, 2, label="e^(-x₁ * x₂) + 20x₃ + ((10π-3)/3)")

# # Mostrar el gráfico
# display(plot!())

# # Mostrar la solución
# println("La solución es: ", x_sol)
# println("Convergió: ", converged(sol))



# using Plots
# using NLsolve

# # Definir el sistema de ecuaciones no lineales
# function sistema!(F, x)
#     F[1] = 3 * x[1] - cos(x[2] * x[3]) - 0.5
#     F[2] = x[2]^2 - 81 * (x[2] + 0.1)^2 + sin(x[3]) + 1.06
#     F[3] = exp(-x[1] * x[2]) + 20 * x[3] + ((10 * π - 3) / 3)
# end

# # Resolver el sistema de ecuaciones no lineales
# initial_guesses = [[0.1, 0.1, 0.1], [-1.0, -1.0, -1.0], [1.0, 1.0, 1.0], [2.0, 2.0, 2.0]]

# for guess in initial_guesses
#     sol = nlsolve(sistema!, guess)
#     println("Initial guess: $guess")
#     println("Solution: $(sol.zero)")
#     println("Converged: $(iszero(sol.f_converged))\n")
# end

# # Graficar las ecuaciones para visualización
# x_sol = [0.5, 7.506729302789541e-18, -0.5235987755982988]

# # Crear un rango de valores para las gráficas
# x_vals = -2:0.1:2
# y_vals_1 = [3*x - cos(x_sol[2] * x_sol[3]) - 0.5 for x in x_vals]
# y_vals_2 = [x^2 - 81*(x + 0.1)^2 + sin(x_sol[3]) + 1.06 for x in x_vals]
# y_vals_3 = [exp(-x_sol[1] * x) + 20*x + ((10*π - 3)/3) for x in x_vals]

# # Graficar las tres ecuaciones
# plot(x_vals, y_vals_1, label="3x₁ - cos(x₂ * x₃) - 0.5", xlabel="x", ylabel="y", legend=:bottom)
# plot!(x_vals, y_vals_2, label="x₂^2 - 81(x₂ + 0.1)^2 + sin(x₃) + 1.06")
# plot!(x_vals, y_vals_3, label="e^(-x₁ * x₂) + 20x₃ + ((10π-3)/3)")

# # Mostrar el gráfico
# display(plot!())



using Plots
using Optim

# Definición de las funciones
f1(x) = 3*x[1] - cos(x[2]*x[3]) - 1/2
f2(x) = x[1]^2 - 81*(x[2] + 0.1)^2 + sin(x[3]) + 1.06
f3(x) = exp(-x[1]*x[2]) + 20*x[3] + (10*pi-3)/3

# Crear una malla de puntos para graficar las funciones
x1_range = range(-2, stop = 2, length = 100)
x2_range = range(-2, stop = 2, length = 100)
x3_range = range(-2, stop = 2, length = 100)
mesh = Iterators.product(x1_range, x2_range, x3_range)

# Calcular los valores de las funciones en la malla de puntos
f1_values = zeros(100, 100, 100)
f2_values = zeros(100, 100, 100)
f3_values = zeros(100, 100, 100)
for (i, x1) in enumerate(x1_range)
    for (j, x2) in enumerate(x2_range)
        for (k, x3) in enumerate(x3_range)
            f1_values[i, j, k] = f1([x1, x2, x3])
            f2_values[i, j, k] = f2([x1, x2, x3])
            f3_values[i, j, k] = f3([x1, x2, x3])
        end
    end
end

# Encontrar el punto de intersección de las tres funciones
function intersection_point()
    obj(x) = sum([f1(x)^2, f2(x)^2, f3(x)^2])
    result = optimize(obj, zeros(3), LBFGS())
    return Optim.minimizer(result)
end

inter_point = intersection_point()

# Crear la figura
plotly() # Puedes cambiar el backend de Plots si prefieres otro
surface(x1_range, x2_range, f1_values[:, :, 50], alpha = 0.5, xlabel = "x1", ylabel = "x2", zlabel = "f1(x)", label = "f1(x)")
surface!(x1_range, x2_range, f2_values[:, :, 50], alpha = 0.5, xlabel = "x1", ylabel = "x2", zlabel = "f2(x)", label = "f2(x)")
surface!(x1_range, x2_range, f3_values[:, :, 50], alpha = 0.5, xlabel = "x1", ylabel = "x2", zlabel = "f3(x)", label = "f3(x)")
scatter!([inter_point[1]], [inter_point[2]], [inter_point[3]], label = "Intersection Point", color = :black)




