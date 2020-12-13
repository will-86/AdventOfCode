$data = Get-Content .\data.txt
$instructions = $data.ToCharArray()

$x = 0
$y = 0
$history = @()

$history += ([PSCustomObject]@{
	x = $x
	y = $y
})

foreach ($item in $instructions) {
	switch ($item) {
		"^" { $y++ }
		">" { $x++ }
		"v" { $y-- }
		"<" { $x-- }
	}

	$history += ([PSCustomObject]@{
		x = $x
		y = $y
	})
}

$drops = $history | Group-Object x, y | Select-Object Name, Count

Write-Output "Houses visited at least once: $($drops.Count)"
