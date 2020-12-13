function Get-RibbonAmount {
	[CmdletBinding()]
	param (
		[Parameter(Mandatory)]
		[string]
		$Dimensions
	)
	
	process {
		$dim = $Dimensions.Split("x")
		[int]$l = $dim[0]
		[int]$w = $dim[1]
		[int]$h = $dim[2]

		$bow = $l * $w * $h

		$faces = @((2 * ($l + $w)), (2 * ($w + $h)), (2 * ($h + $l)))
		$perimeter = [Math]::Min([Math]::Min($faces[0], $faces[1]), $faces[2])

		$total = $perimeter + $bow

		Write-Output $total
	}
}

$data = Get-Content .\data.txt
$ribbon = 0

foreach ($item in $data) {
	$ribbon += Get-RibbonAmount -Dimensions $item
}

Write-Output "Total Ribbon: $ribbon"
