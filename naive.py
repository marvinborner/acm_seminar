cubes = [
    tuple(int(n) for n in line.strip().split(","))
    for line in open("input").readlines()
]


def neighbors(cube):
    x, y, z = cube
    return {(x + 1, y, z), (x - 1, y, z), (x, y + 1, z), (x, y - 1, z), (x, y, z + 1), (x, y, z - 1)}


n = 0
for cube in cubes:
    for neighbor in neighbors(cube):
        if neighbor not in cubes:
            n += 1
print(n)

xmax = max(x for x, _, _ in cubes) + 1
xmin = min(x for x, _, _ in cubes) - 1
ymax = max(y for _, y, _ in cubes) + 1
ymin = min(y for _, y, _ in cubes) - 1
zmax = max(z for _, _, z in cubes) + 1
zmin = min(z for _, _, z in cubes) - 1


def in_boundary(cube):
    x, y, z = cube
    return xmin <= x <= xmax and ymin <= y <= ymax and zmin <= z <= zmax


n = 0  # result
visited = set(cubes)
queue = [(xmax, ymax, zmax)]
while queue:
    cube = queue.pop(0)
    for neighbor in neighbors(cube):
        if not in_boundary(neighbor):
            continue
        if neighbor in cubes:
            n += 1
        if neighbor in visited:
            continue
        visited.add(neighbor)
        queue.append(neighbor)

print(n)
