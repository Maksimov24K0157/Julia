#1

function max_subarray_sum(arr::Vector{T}) where T
    if isempty(arr)
        return 0
    end

    max_current = arr[1]
    max_global = arr[1]

    for x in arr[2:end]
        max_current = max(x, max_current + x)
        if max_current > max_global#можно заменить конструкцию с условным оператором на  max_global=max(max_global, max_current)
            max_global = max_current
        end
    end

    return max_global
end

sequence = [-2 , -1, -3, -4, -1, -2, -1, -5, -4]
result = max_subarray_sum(sequence)
println("Максимальная сумма непрерывной части последовательности: ", result)

#2

function mean_and_stddev(arr::Vector{T}) where T
    if isempty(arr)
        return (0.0,0.0)
    end

    n = length(arr)
    sum = zero(T)
    sum_squares = zero(T)

    for x in arr
        sum += x
        sum_squares += x^2
    end

    mean = sum / n
    variance = (sum_squares / n) - (mean^2)
    stddev = sqrt(variance)

    return (mean, stddev)
end

sequence = [1.0, 2.0, 3.0, 4.0, 5.0]
mean_value, stddev_value = mean_and_stddev(sequence)
println("Среднее значение: ", mean_value)
println("Среднеквадратичное отклонение: ", stddev_value)

#3

function horner(coefficients::Vector{T}, x::T) where T
    # Инициализируем значение многочлена 
    result = zero(T)

    # Проходим по коэффициентам в обратном порядке 
    for coeff in reverse(coefficients)
        result = result * x + coeff
    end

    return result
end

# пример использования 
coefficients = [2.0, -6.0, 2.0, -1.0] # коэффициент многочлена 2x^3
x_value = 3.0 # значение аргумента
polynomial_value = horner(coefficients, x_value)
println("Значение многочлена при x =", x_value, " равно: ", polynomial_value)

#4

function horner_with_derivative(coefficients::Vector{T}, x::T) where T
    # Инициализируем значения многочлена и его производной
    polynomial_value = zero(T)
    derivative_value = zero(T)
    # Количество коэффициентов
    n = length(coefficients)
    # Проходим по коэффициентам в обратном порядке
    for i in 1:n
        coeff = coefficients[n - i + 1] # Получаем коэффициент в обратном порядке
        polynomial_value = polynomial_value * x + coeff
        # Обновляем производную
        if (i < n) # Производная не учитывает последний коэффициент
            derivative_value = derivative_value * x + polynomial_value
        end
    end
    return (polynomial_value, derivative_value)
end
        
# Пример использования
coefficients = [2.0, -6.0, 2.0, -1.0] # Коэффициенты многочлена 2x^3 - 6x^2 + 2х - 1 
x_value = 3.0 # Значение аргумента
polynomial_value, derivative_value = horner_with_derivative(coefficients, x_value)
println("Значение многочлена при х = ", x_value, " равно: ", polynomial_value)
println("Значение производной при х = ", x_value, " равно: ", derivative_value)

#5

function gcd(a::T, b::T) where T 
    while b != zero(T)
        a, b = b, a % b
    end
    return abs(a)
end

    # Расширенный алгоритм Евклида
function extended_gcd(a::T, b::T) where T
    if b == zero(T)
        return (abs(a), sign(a), zero(T)) # НОД, коэффициент для а,
    else
        gcd_val, x1, y1 = extended_gcd(b, a % b)
        x = y1
        y = x1 - (a ÷ b) * y1
        return (gcd_val, x, y)
    end
end

# Пример использования
a = 56
b = 98

gcd_value = gcd(a, b)
gcd_extended = extended_gcd(a, b)
println("НОД(", a, ", ", b, ") = ", gcd_value)
println("Расширенный алгоритм Евклида: НОД = ", gcd_extended[1], ", коck")

#6

struct Residue{T, M}
    rem::T
    Residue{T, M}(_rem) where {T, M} = new(mod(_rem, M))
end
Base.:+(x::Residue{T, M}, y::Residue{T, M}) where {T,M} = Residue{T, M}(x.rem+y.rem)
Base.:-(x::Residue{T, M}, y::Residue{T, M}) where {T,M} = Residue{T, M}(x.rem-y.rem)
Base.:*(x::Residue{T, M}, y::Residue{T, M}) where {T,M} = Residue{T, M}(x.rem*y.rem)
Base.:div(x::Residue{T, M}, y::Residue{T, M}) where {T,M} = Residue{T, M}(div(x.rem,y.rem))
Base.:rem(x::Residue{T, M}, y::Residue{T, M}) where {T,M} = Residue{T, M}(rem(x.rem,y.rem))
Base.:mod(x::Residue{T, M}, y::Residue{T, M}) where {T,M} = Residue{T, M}(mod(x.rem,y.rem))
Base.:/(x::Residue, y::Residue) = div(x, y)
Base.:divrem(x::Residue, y::Residue) = (div(x,y), rem(x,y))
function inverse(x::Residue{T, M}) where {T,M}
    eu = Euclid(x.rem, M)
    if eu[1] == 1
        return Residue{T,M}(eu[2])
    else
        error("no inverse")
    end
end
Base.:zero(x::Residue{T, M}) where {T, M} = Residue{T, M}(0)
Base.:zero(::Type{Residue{T, M}}) where {T, M} = Residue{T, M}(0)
Base.:one(x::Residue{T, M}) where {T, M} = Residue{T, M}(1)
Base.:one(::Type{Residue{T, M}}) where {T, M} = Residue{T, M}(1)

Base.:*(x::Residue{T, M}, y) where {T,M} = Residue{T, M}(x.rem*y)
Base.:+(x::Residue{T, M}, y) where {T,M} = Residue{T, M}(x.rem+y)
Base.:-(x::Residue{T, M}, y) where {T,M} = Residue{T, M}(x.rem-y)
Base.:/(x::Residue{T, M}, y) where {T,M} = Residue{T, M}(x.rem/y)

#7

struct Polynomial{T}
    coeffs::Vector{T}
    function Polynomial{T}(_coeffs::Vector) where {T}
        coeffs = Vector{T}(undef, 0)
        for coeff in _coeffs
            push!(coeffs, coeff)
        end
        while length(coeffs) > 1 && coeffs[end] == zero(T)
            pop!(coeffs)
        end
        return new(coeffs)
    end
end
function Polynomial{T}(coeff, degr) where {T}
    return raise_degree(Polynomial{T}([T(coeff)]), degr)
end
function (poly::Polynomial)(x)
    result = zero(x)
    for i in 0:degree(poly)
        result += poly.coeffs[i+1]*x^i
    end
    return result
end
degree(x::Polynomial) = length(x.coeffs)-1
Base.:length(x::Polynomial) = length(x.coeffs)
function Base.:+(x::Polynomial{T}, y::Polynomial{T}) where {T}
    new_coeffs = Vector{T}(undef, 0)
    for i in 1:maximum(length, [x, y])
        coeff_x = length(x) < i ? zero(T) : x.coeffs[i]
        coeff_y = length(y) < i ? zero(T) : y.coeffs[i]
        push!(new_coeffs, coeff_x+coeff_y)
    end
    return Polynomial{T}(new_coeffs)
end
function Base.:*(x::Polynomial{T}, y) where {T}
    new_coeffs = Vector{T}(undef, 0)
    for i in 1:length(x)
        push!(new_coeffs, x.coeffs[i]*y)
    end
    return Polynomial{T}(new_coeffs)
end
Base.:*(x::Real, y::Polynomial{T}) where {T} = y*x
Base.:-(x::Polynomial{T}, y::Polynomial{T}) where {T} = x + -1*y
Base.:zero(x::Polynomial{T}) where {T} = Polynomial{T}([zero(T)])
raise_degree(x::Polynomial{T}, add_degree) where {T} = Polynomial{T}(vcat([zero(T) for i in 0:add_degree-1], x.coeffs))
mult_by_mono(poly::Polynomial, coeff, degr) = return raise_degree(poly, degr)*coeff
function Base.:*(x::Polynomial{T}, y::Polynomial{T}) where {T}
    new_poly = zero(x)
    for i in 0:degree(x)
        poly_i = mult_by_mono(y, x.coeffs[i+1], i)
        #println(i, " ", poly_i)
        new_poly += poly_i
        #println(new_poly)
    end
    return new_poly
end
function Base.:divrem(x::Polynomial{T}, y::Polynomial{T}) where {T}
    div_poly = zero(x)
    rem_poly = x
    while degree(rem_poly) >= degree(y)
        #println(div_poly, " ", rem_poly)
        coeff = last(rem_poly.coeffs)/last(y.coeffs)
        degr = degree(rem_poly)-degree(y)
        rem_poly -= mult_by_mono(y, coeff, degr)
        div_poly += Polynomial{T}(coeff, degr)
        #println(div_poly, " ", rem_poly)
    end
    return (div_poly, rem_poly)
end
Base.:div(x::Polynomial, y::Polynomial) = divrem(x, y)[1] 
Base.:rem(x::Polynomial, y::Polynomial) = divrem(x, y)[2]
Base.:mod(x::Polynomial, y::Polynomial) = divrem(x, y)[2]

coeffs = [Residue{Real, 5}(i) for i in 1:5]
x = Polynomial{Real}([1,2,3,4])
y = Polynomial{Real}([2,0,4,5, 0, 0, 0])
