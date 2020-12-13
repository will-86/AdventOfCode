$data = Get-Content .\data.txt
$instructions = $data.ToCharArray()

$sX = 0
$sY = 0
$rX = 0
$rY = 0
$history = @()

$history += ([PSCustomObject]@{
	x = 0
	y = 0
	p = "s"
})
$history += ([PSCustomObject]@{
	x = 0
	y = 0
	p = "r"
})

for ($i = 0; $i -lt $instructions.Length; $i++) {
	$item = $instructions[$i]
	if ($i % 2 -eq 0) {
		switch ($item) {
			"^" { $sY++ }
			">" { $sX++ }
			"v" { $sY-- }
			"<" { $sX-- }
		}
		$history += ([PSCustomObject]@{
			x = $sX
			y = $sY
			p = "s"
		})
	} else {
		switch ($item) {
			"^" { $rY++ }
			">" { $rX++ }
			"v" { $rY-- }
			"<" { $rX-- }
		}
		$history += ([PSCustomObject]@{
			x = $rX
			y = $rY
			p = "r"
		})
	}
}

$drops = $history | Group-Object x, y | Select-Object Name, Count | Sort-Object Count -Descending

Write-Output "Houses visited at least once: $($drops.Count)"
