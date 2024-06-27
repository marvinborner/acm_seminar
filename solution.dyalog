⎕IO←0
]box on

⍝ Part 1
cubes←⍎¨⊃⎕NGET'input'1
movements←{⍵,-⍵}↓(3 3⍴4↑1)
sides←,cubes∘.+movements
≢sides~cubes

⍝ Part 2
mins←(↑⌊/cubes)-1 1 1
maxs←(↑⌈/cubes)+1 1 1
in_boundary←{0≡+/((⍵<mins),(⍵>maxs))}
count←0
cubes{ ⍝ https://dfns.dyalog.com/n_bfs.htm
	0=≢⍵:count
	head←1↑⍵ ⋄ tail←1↓⍵
	neighbors←movements+¨head
	next←{(in_boundary¨⍵)/⍵}neighbors
	count⊢←count+(+/{(↓⍵)∊cubes}¨neighbors)
	(⍺,head)∇((tail∪next)~⍺)
}↓maxs

⍝ search visualization
_←⎕ED 'grid'
visualize←{
	grid⊢←(maxs+1 1 1)⍴' '
	cubes{ ⍝ https://dfns.dyalog.com/n_bfs.htm
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
