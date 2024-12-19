#28a
function Fib(n::Int)
    n <= 2 && return 1
    a, b = 1, 1
    for i in 1:n-1
        (i % 2 == 0) && (b = a + b)
        (i % 2 == 1) && (a = a + b)
    end
    return max(a, b)
end

#28b

function Fib1(n::Int)
    n == 1 || n == 2 || return Fib(n - 1) + Fin(n - 2)
    return 1
end