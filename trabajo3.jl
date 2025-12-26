# # Función para calcular las diferencias divididas de Newton
# function diferencias_divididas(x, fx)
#     n = length(x)
#     # Crear una matriz para almacenar las diferencias divididas
#     coef = copy(fx)
    
#     for j in 2:n
#         for i in n:-1:j
#             coef[i] = (coef[i] - coef[i-1]) / (x[i] - x[i-j+1])
#         end
#     end
    
#     return coef
# end

# # Función para evaluar el polinomio de Newton en un valor dado
# function evaluar_polinomio(coef, x, val)
#     n = length(coef)
#     # Inicializar el valor del polinomio con el coeficiente de mayor grado
#     polinomio_val = coef[n]
    
#     # Evaluar el polinomio usando el esquema de Horner
#     for i in (n-1):-1:1
#         polinomio_val = polinomio_val * (val - x[i]) + coef[i]
#     end
    
#     return polinomio_val
# end

# # Función principal para interpolar y evaluar el polinomio de Newton
# function Newton(x, fx, val)
#     # Calcular los coeficientes del polinomio de Newton
#     coef = diferencias_divididas(x, fx)
    
#     # Evaluar el polinomio en el valor proporcionado
#     resultado = evaluar_polinomio(coef, x, val)
    
#     return resultado
# end

# # Ejemplo de uso
# x = [1.0, 2.0, 3.0, 4.0]
# fx = [1.0, 4.0, 9.0, 16.0]
# val = 2.5

# println(Newton(x, fx, val))  # Debería imprimir el valor del polinomio en x=2.5









# # Función para calcular las diferencias divididas de Newton
# function diferencias_divididas(x, fx)
#     n = length(x)
#     # Crear una matriz para almacenar las diferencias divididas
#     coef = copy(fx)
    
#     for j in 2:n
#         for i in n:-1:j
#             coef[i] = (coef[i] - coef[i-1]) / (x[i] - x[i-j+1])
#         end
#         println("Coeficientes en la iteración $j: ", coef)
#     end
    
#     return coef
# end

# # Función para evaluar el polinomio de Newton en un valor dado
# function evaluar_polinomio(coef, x, val)
#     n = length(coef)
#     # Inicializar el valor del polinomio con el coeficiente de mayor grado
#     polinomio_val = coef[n]
    
#     # Evaluar el polinomio usando el esquema de Horner
#     for i in (n-1):-1:1
#         polinomio_val = polinomio_val * (val - x[i]) + coef[i]
#         println("Polinomio en la iteración $(n-i): ", polinomio_val)
#     end
    
#     return polinomio_val
# end

# # Función principal para interpolar y evaluar el polinomio de Newton
# function Newton(x, fx, val)
#     # Calcular los coeficientes del polinomio de Newton
#     coef = diferencias_divididas(x, fx)
    
#     # Evaluar el polinomio en el valor proporcionado
#     resultado = evaluar_polinomio(coef, x, val)
    
#     return resultado
# end

# # Ejemplo de uso
# x = [1.0, 2.0, 3.0, 4.0]
# fx = [1.0, 4.0, 9.0, 16.0]
# val = 2.5

# println(Newton(x, fx, val))  # Debería imprimir el valor del polinomio en x=2.5






# Función para calcular las diferencias divididas de Newton
function diferencias_divididas(x, fx)
    n = length(x)
    # Crear una matriz para almacenar las diferencias divididas
    coef = copy(fx)
    
    for j in 2:n
        for i in n:-1:j
            coef[i] = (coef[i] - coef[i-1]) / (x[i] - x[i-j+1])
        end
        println("Coeficientes en la iteración $j: ", coef)
    end
    
    return coef
end

# Función para evaluar el polinomio de Newton en un valor dado
function evaluar_polinomio(coef, x, val)
    n = length(coef)
    # Inicializar el valor del polinomio con el coeficiente de mayor grado
    polinomio_val = coef[n]
    
    # Evaluar el polinomio usando el esquema de Horner
    for i in (n-1):-1:1
        polinomio_val = polinomio_val * (val - x[i]) + coef[i]
        println("Polinomio en la iteración $(n-i): ", polinomio_val)
    end
    
    return polinomio_val
end

# Función principal para interpolar y evaluar el polinomio de Newton
function Newton(x, fx, val)
    # Calcular los coeficientes del polinomio de Newton
    coef = diferencias_divididas(x, fx)
    
    # Evaluar el polinomio en el valor proporcionado
    resultado = evaluar_polinomio(coef, x, val)
    
    return resultado
end

# Ejemplo de uso
x = [1.0, 2.0, 3.0, 4.0]
fx = [1.0, 4.0, 9.0, 16.0]
val = 2.5

println(Newton(x, fx, val))  # Debería imprimir el valor del polinomio en x=2.5
