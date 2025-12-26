# using Roots

# # Definimos la constante de gravedad
# const g = 9.81

# # Definimos la función de posición x(t, w)
# function x(t, w)
#     term1 = (exp(w) - exp(-w)) / 2
#     term2 = sin(w)
#     return -(g / (2 * w^2)) * (term1 - term2)
# end

# # Definimos la función que queremos que sea cero para encontrar la raíz
# # Es decir, queremos resolver x(1, w) - 0.52 = 0
# function f(w)
#     return x(1, w) - 0.52
# end

# # Derivada de la función de posición con respecto a w
# function df(w)
#     term1 = (exp(w) + exp(-w)) / 2
#     term2 = cos(w)
#     term3 = (g / w^3) * ( (exp(w) - exp(-w)) / 2 - sin(w) )
#     return -(g / (2 * w^2)) * (term1 - term2) + term3
# end

# # Usamos la función find_zero de Roots.jl con el método de Newton para encontrar la raíz
# # Necesitamos un valor inicial de prueba, probemos con w = -1.0
# w_approx = find_zero((f, df), -1.0, Roots.Newton(), atol=1e-5)

# println("La tasa w a la que θ cambia es aproximadamente: ", w_approx)








# using Roots

# # Definimos la constante de gravedad
# const g = 9.81

# # Definimos la función de posición x(t, w)
# function x(t, w)
#     term1 = (exp(w) - exp(-w)) / 2
#     term2 = sin(w)
#     return -(g / (2 * w^2)) * (term1 - term2)
# end

# # Definimos la función que queremos que sea cero para encontrar la raíz
# # Es decir, queremos resolver x(1, w) - 0.52 = 0
# function f(w)
#     return x(1, w) - 0.52
# end

# # Derivada de la función de posición con respecto a w
# function df(w)
#     term1 = (exp(w) + exp(-w)) / 2
#     term2 = cos(w)
#     term3 = (g / w^3) * ( (exp(w) - exp(-w)) / 2 - sin(w) )
#     return -(g / (2 * w^2)) * (term1 - term2) + term3
# end

# # Usamos la función find_zero de Roots.jl para encontrar la raíz
# # Probamos varios valores iniciales para ver cuál converge mejor
# w_initials = [-1.0, -0.5, -0.1]

# for w_initial in w_initials
#     try
#         w_approx = find_zero((f, df), w_initial, Roots.Newton(), atol=1e-5)
#         println("Con valor inicial ", w_initial, ", la tasa w es aproximadamente: ", w_approx)
#     catch e
#         println("Con valor inicial ", w_initial, ", no se pudo encontrar una raíz. Error: ", e)
#     end
# end


# # grafica
# using Plots

# # Definimos la función de posición x(t, w)
# function x(t, w)
#     term1 = (exp(w*t) - exp(-w*t)) / 2
#     term2 = sin(w*t)
#     return -(g / (2 * w^2)) * (term1 - term2)
# end

# # Valor encontrado de w
# w_approx = -0.31803894296549184

# # Valores de t para evaluar la función
# t_vals = range(0, stop=1, length=1000)
# x_vals = x.(t_vals, w_approx)

# # Gráfica de la función de posición x(t, w)
# plot(t_vals, x_vals, label="x(t, w)", color=:blue, xlabel="t", ylabel="x(t, w)", title="Posición x(t, w) con w ≈ $w_approx")

# # Línea horizontal en y = 0.52
# hline!([0.52], label="y = 0.52", color=:red, linestyle=:dash)

# # Mostrar la gráfica
# plot!()









# using Printf

# # Definimos la constante de gravedad
# const g = 9.81

# # Definimos la función de posición x(t, w)
# function x(t, w)
#     term1 = (exp(w*t) - exp(-w*t)) / 2
#     term2 = sin(w*t)
#     return -(g / (2 * w^2)) * (term1 - term2)
# end

# # Valor encontrado de w
# w_approx = -0.31803894296549184

# # Evaluamos x(1, w_approx) para verificar
# x_val = x(1, w_approx)

# @printf "Evaluando x(1, w_approx) obtenemos: %.10f\n" x_val

# # Comprobamos el error absoluto con respecto a 0.52
# error = abs(x_val - 0.52)

# @printf "El error absoluto es: %.10f\n" error


using Roots
using Plots
using Printf

# Definimos la constante de gravedad
const g = 9.81

# Definimos la función de posición pos(t, w)
function pos(t, w)
    term1 = (exp(w * t) - exp(-w * t)) / 2
    term2 = sin(w * t)
    return -(g / (2 * w^2)) * (term1 - term2)
end

# Definimos la función que queremos que sea cero para encontrar la raíz
function f(w)
    return pos(1, w) - 0.52
end

# Derivada de la función de posición con respecto a w
function df(w)
    term1 = (exp(w) + exp(-w)) / 2
    term2 = cos(w)
    term3 = (g / w^3) * ((exp(w) - exp(-w)) / 2 - sin(w))
    return -(g / (2 * w^2)) * (term1 - term2) + term3
end

# Usamos la función find_zero de Roots.jl para encontrar la raíz
w_initials = [-1.0, -0.5, -0.1]
global w_approx = NaN  # Para almacenar el mejor valor de w

for w_initial in w_initials
    try
        global w_approx = find_zero((f, df), w_initial, Roots.Newton(), atol=1e-5)
        println("Con valor inicial ", w_initial, ", la tasa w es aproximadamente: ", w_approx)
        break  # Salir del bucle si se encuentra una solución válida
    catch e
        println("Con valor inicial ", w_initial, ", no se pudo encontrar una raíz. Error: ", e)
    end
end

# Verificamos si se ha encontrado un valor válido de w
if isnan(w_approx)
    error("No se encontró un valor válido de w.")
end

# Valores de t para la animación
t_vals = range(0, stop=1, length=100)

# Crear la animación
anim = @animate for t in t_vals
    plot(t_vals, pos.(t_vals, w_approx), label="x(t, w)", color=:blue, xlabel="t", ylabel="x(t, w)", title="Posición x(t, w) con w ≈ $(Printf.@sprintf("%.5f", w_approx))", legend=false)
    scatter!([t], [pos(t, w_approx)], color=:red, label="Partícula")
    hline!([0.52], label="y = 0.52", color=:green, linestyle=:dash)
end

# Guardar la animación como un archivo GIF
gif(anim, "posicion_particula.gif", fps=10)
