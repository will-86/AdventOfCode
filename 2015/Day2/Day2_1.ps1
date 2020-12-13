function Get-PaperAmount {
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

		$sides = @(($l*$w), ($w*$h), ($h*$l))
		$smallest = [Math]::Min([Math]::Min($sides[0], $sides[1]), $sides[2])

		$area = 2 * ($sides | measure-object -sum).Sum
		$total = $area + $smallest

		Write-Output $total
	}
}

$data = Get-Content .\data.txt
$paper = 0

foreach ($item in $data) {
	$paper += Get-PaperAmount -Dimensions $item
}

Write-Output "Total Paper: $paper"
