import sys
import numpy as np
import functools

sys.setrecursionlimit(100000)

# Part 1
# cubes←⍎¨⊃⎕NGET'input'1
cubes = [eval(f"({line})") for line in open("input").readlines()]

# movements←{⍵,-⍵}↓(3 3⍴4↑1)
movements = (lambda w: np.vstack([w, -w]))(np.identity(3, dtype=int))

# sides←,cubes∘.+movements
sides = [tuple(c + m) for c in cubes for m in movements]

# ≢sides~cubes
print(sum(1 for side in sides if side not in cubes))

# Part 2
# mins←(↑⌊/cubes)-1 1 1
mins = tuple(min(c) - 1 for c in zip(*cubes))
# maxs←(↑⌈/cubes)+1 1 1
maxs = tuple(max(c) + 1 for c in zip(*cubes))
# in_boundary←{0≡+/((⍵<mins),(⍵>maxs))}
in_boundary = lambda c: 0 == functools.reduce(
    lambda a, b: a + b,
    (int(c[i] < mins[i] or c[i] > maxs[i]) for i in range(3)),
    0,
)
# count←0
count = 0


def rec(left, right):
    global count
    # 0=≢⍵:count
    if not right:
        return count
    # head←1↑⍵ ⋄ tail←1↓⍵
    head, tail = right[0], right[1:]
    # neighbors←movements+¨head
    neighbors = [tuple(head + m) for m in movements]
    # next←{(in_boundary¨⍵)/⍵}neighbors
    next = set(filter(in_boundary, neighbors))
    # count⊢←count+(+/{(↓⍵)∊cubes}¨neighbors)
    count += sum((n in cubes) for n in neighbors)
    # (⍺,head)∇((tail∪next)~⍺)
    return rec(left | set([head]), list((set(tail) | next) - left))


# cubes{...}↓maxs
print(rec(set(cubes), [maxs]))
