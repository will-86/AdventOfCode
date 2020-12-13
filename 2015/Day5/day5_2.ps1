$data = Get-Content .\data.txt
$res = @()

foreach ($str in $data) {
	$r = [PsCustomObject]@{
		String = $str
		Naughty = $false
		Nice = $false
	}

	if ($str -match "([A-Za-z])[A-Za-z]\1" ) {
		if ($str -match "([A-Za-z][A-Za-z])\w*(\1)" ) {
			$r.Nice = $true
		}
	}

	if (-not $r.Nice) {
		$r.Naughty = $true
	}

	$res += $r
}

$res.Where({$_.Nice -eq $true}).Count
