$base = "yzbqklnj"
$i = 1
$found = $false

function Get-StringHash {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory, Position=0)]
		[string]
		$InputObject
	)

	process {
		$strBld = New-Object System.Text.StringBuilder
		$hasher = [System.Security.Cryptography.HashAlgorithm]::Create("MD5")
		$hashBytes = $hasher.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($InputObject))
		foreach ($hb in $hashBytes) {
			[void]$strBld.Append($hb.ToString("x2"))
		}
		Write-Output "$($strBld.ToString())"
	}
}

while (-not $found) {
	if ($i % 100 -eq 0) { Write-Output "Current index: $i"}
	$inputKey = "$base$i"
	$hash = Get-StringHash $inputKey
	if ($hash.Substring(0,5) -eq "00000") {
		$found = $true
		Write-Output "Index: $i"
		Write-Output "Hash: $hash"
	} else {
		$i++
	}
}