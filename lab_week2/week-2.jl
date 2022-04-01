module Week2

export pwdmatch, couponcollector, cupsacuer

using Random
Random.seed!()

"""
    pwdmatch(pwd, passLength, numMatchesForLog)

Let `pwd` be a password which consists of 
letters 'a'-'z', 'A'-'Z', and `0-9`.
Modify listing 2.2 to compute the probability that a uniform random 
password of length `passLength` matches at least `numMatchesForLog` letter in `pwd`.

# Examples
```julia-repl
julia> pwdmatch("3xyZu4vN", 8, 1)
0.1222424

julia> pwdmatch("x", 3, 1)
0.0161381

julia> pwdmatch("xyz", 8, 4)
0.0
```
"""
function pwdmatch(pwd, passLength, numMatchesForLog)
    if length(pwd) < numMatchesForLog
        return 0.0
    end
    possibleChars = ['a':'z' ; 'A':'Z' ; '0':'9']
    nummatch(loginPassword) = sum([loginPassword[i] == pwd[i] for i in 1:min(length(pwd),passLength)])

    N = 10^7

    passwords = [String(rand(possibleChars,passLength)) for _ in 1:N]
    numLogs   = sum([nummatch(p) >= numMatchesForLog for p in passwords])
    return numLogs/N
end

"""
    couponcollector(numCoupon, minCoupon)

Suppose each time you buy a bottle of soda, 
you get one coupon uniformly at random from `numCoupon` types of coupons.
Compute the average number of bottles you need to buy
so that you have at least `minCoupon` coupons of each type.

This is called the [Coupon-collector Problem](https://en.wikipedia.org/wiki/Coupon_collector%27s_problem).

# Examples
```julia-repl
julia> couponcollector(100, 1)
518.69087

julia> couponcollector(50, 2)
324.91004

julia> couponcollector(20, 3)
141.135803
```
"""
function couponcollector(numCoupon, minCoupon)
    N = 10^6
    trials = []
    for i in 1:N
        c = 0
        coupon_record = [0 for _ in 1:numCoupon]
        while  minimum(coupon_record) < minCoupon
            cur_coupon = rand(1:numCoupon)
            coupon_record[cur_coupon] += 1
            c += 1
        end
        append!(trials, c)
    end
    return sum(trials)/N
end

"""
    cupsacuer(n)

You are given `3n` pairs of cups and saucers --- `n` black, `n` red, and `n` blue.
If the cups are put on saucers uniformly at random,
compute via simulation the probability that no cup is put on a saucer of the same colour.

# Hint 

Use a vector `[1, ... 1, 2, ... 2, 3 ... 3]` to represent the position of saucers.
Shuffle this vector by [`Random.shuffle`](https://docs.julialang.org/en/v1/stdlib/Random/#Random.shuffle)
to get the position of cups.
Check if any cup sits on top of a saucer of the same colour.

# Example

```julia-repl
julia> cupsacuer(1)
0.333696

julia> cupsacuer(2)
0.1113
```
"""
# function cupsacuer(n)
#     # finish this function
#     N = 10^6
#     total = 0
#     for _ in 1:N
#         pos = shuffle(vcat(fill(1,n),fill(2,n),fill(3,n)))
#         state = true
#         for i in 1:3*n
#             # why doesn't 
#             # if (1 in pos[1:n] == false) && if (1 in pos[n+1:2*n] == false)) && if (1 in pos[2*n+1:3*n] == false)
#             if (pos[i] == 1 && i<=n) || (pos[i] == 2 && i<=2*n && i>=n+1) || (pos[i] == 3 && i<=3*n && i>=2*n+1)
#                 state = false
#                 break
#             end
#         end

#         if state == true    
#             total+=1
#         end
#     end
#     return total/N
# end

function cupsacuer(n)
    N = 10^6
    total = 0
    for _ in 1:N
        pos = shuffle(vcat(fill(1,n),fill(2,n),fill(3,n)))

        if (1 in pos[1:n]) == false  && (2 in pos[n+1:2*n]) == false && (3 in pos[2*n+1:3*n]) == false
            total += 1
        end

    end
    return total/N
end

end
