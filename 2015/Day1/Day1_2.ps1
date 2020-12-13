$data = Get-Content .\data.txt

$floor = 0

$instructions = $data.ToCharArray()

for ($i = 0; $i -lt $instructions.Count; $i++) {
	if ($instructions[$i] -eq "(") {
		$floor++
	} else {
		$floor--
	}
	
	if ($floor -lt 0) {
		Write-Output "Step: $($i + 1)"
		break
	}
}