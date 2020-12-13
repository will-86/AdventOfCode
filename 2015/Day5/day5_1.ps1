function Test-NaughtyPair {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[string]
		$str
	)
	
	process {
		$naughtyPairs = @("ab","cd","pq","xy")
		$naughtyStr = $false

		foreach ($item in $naughtyPairs) {
			if ($str.IndexOf($item) -ge 0) {
				$naughtyStr = $true
			}
		}

		Write-Output $naughtyStr
	}	
}

function Test-DoubleLetter {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[string]
		$str
	)
	
	process {
		$match = $false
		$ca = $str.ToCharArray()
		
		for ($i = 0; $i -lt ($ca.Length -1); $i++) {
			if ($ca[$i] -eq $ca[$i + 1]) {
				$match = $true
			}
		}

		Write-Output $match
	}	
}

function Test-VowelCount {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[string]
		$str
	)
	
	process {
		if ($str -match "(\w*[AaEeIiOoUu]){3}\w*") {
			Write-Output $true
		} else {
			Write-Output $false
		}
	}
}

function Test-StringBehaviour {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[string[]]
		$InputObject
	)

	process {
		foreach ($item in $InputObject) {
			$res = [PSCustomObject]@{
				String = $item
				Naughty = $false
				Nice = $false
			}
			
			if (Test-NaughtyPair $item) {
				$res.Naughty = $true
				Write-Output $res
				continue
			}

			if (Test-DoubleLetter $item) {
				if (Test-VowelCount $item) {
					$res.Nice = $true
				}
			}

			if (-not $res.Nice) {
				$res.Naughty = $true
			}

			Write-Output $res
		}
	}
}

$data = Get-Content .\data.txt

$res = @()

$res += Test-StringBehaviour $data

$res.Where({$_.Nice -eq $true}).Count
