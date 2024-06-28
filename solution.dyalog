⎕IO←0
]box on

⍝ Part 1
cubes←⍎¨⊃⎕NGET'../input'1     ⍝ All lava cubes
movements←{⍵,-⍵}↓(3 3⍴4↑1)    ⍝ 6 possible movements each
sides←,cubes∘.+movements      ⍝ Sides: Cubes added to movements
≢sides~cubes                  ⍝ Count of surface area

⍝ Part 2
mins←(↑⌊/cubes)-1 1 1                 ⍝ Minimum coords (minx, miny, minz)
maxs←(↑⌈/cubes)+1 1 1                 ⍝ Maximum coords (maxx, maxy, maxz)
in_boundary←{0≡+/((⍵<mins),(⍵>maxs))} ⍝ Is cube within boundary?
count←0                               ⍝ Final count of outer surface area

cubes{ ⍝ https://dfns.dyalog.com/n_bfs.htm
	0=≢⍵:count                              ⍝ If queue empty, return count
	head←1↑⍵ ⋄ tail←1↓⍵                     ⍝ head, tail of queue
	neighbors←movements+¨head               ⍝ 6 neighbors: head+movements
	next←{(in_boundary¨⍵)/⍵}neighbors       ⍝ Filter neighbors by in_boundary
	count⊢←count+(+/{(↓⍵)∊cubes}¨neighbors) ⍝ Increment count with neighbors that are in cubes
	(⍺,head)∇((tail∪next)~⍺)                ⍝ Recursion: (visited|head) rec (tail|next)-visited
}↓maxs

⍝ search visualization
_←⎕ED 'grid'
visualize←{
	grid⊢←(maxs+1 1 1)⍴' '
	cubes{
		0=≢⍵:count
		head←1↑⍵ ⋄ tail←1↓⍵
		grid[|head]⊢←'O'
		_←⎕DL .001
		grid[|head]⊢←'X'
		neighbors←movements+¨head
		next←{(in_boundary¨⍵)/⍵}neighbors
		count⊢←count+(+/{(↓⍵)∊cubes}¨neighbors)
		(⍺,head)∇((tail∪next)~⍺)
	}↓maxs
}

⍝ layer visualization
_←⎕ED 'layergrid'
render←{
    {
        layergrid⊢←⍵
        _←⎕DL 0.3
    }¨↓↓grid
}
