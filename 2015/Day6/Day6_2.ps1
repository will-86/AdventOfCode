$lights = New-Object 'object[,]' 1000,1000

foreach ($x in 0..999) {
	foreach ($y in 0..999) {
		$lights[$x,$y] = 0
	}
}

$data = Get-Content .\data.txt

foreach ($item in $data) {
	$words = $item -split " "
	if ($words[0] -eq "toggle") {
		$command = $words[0]
		$startX = $words[1].Split(",")[0]
		$startY = $words[1].Split(",")[1]
		$endX = $words[3].Split(",")[0]
		$endY = $words[3].Split(",")[1]
	} else {
		$command = $words[1]
		$startX = $words[2].Split(",")[0]
		$startY = $words[2].Split(",")[1]
		$endX = $words[4].Split(",")[0]
		$endY = $words[4].Split(",")[1]
	}

	foreach ($x in $startX..$endX) {
		foreach ($y in $startY..$endY) {
			if ($command -eq "on") {
				$state = 1
			} elseif ($command -eq "off") {
				$state = -1
			} else {
				$state = 2
			}
			$lights[$x,$y] += $state
			if ($lights[$x,$y] -lt 0) {
				$lights[$x,$y] = 0
			}
		}
	}
}

$brightness = 0
foreach ($x in 0..999) {
	foreach ($y in 0..999) {
		$brightness += $lights[$x,$y]
	}
}
$brightness
