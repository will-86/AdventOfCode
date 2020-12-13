$data = Get-Content .\data.txt

$length = $data.Length
$newLength = 0

while ($newLength -lt $length) {
	$length = $data.Length
	$data = $data.Replace("()","")
	$newLength = $data.Length
}

$newLength = 0
while ($newLength -lt $length) {
	$length = $data.Length
	$data = $data.Replace(")(","")
	$newLength = $data.Length
}

$list = $data.ToCharArray()
$up = ($list.Where({$_ -eq "("}) | measure-object).Count
$down = ($list.Where({$_ -eq ")"}) | measure-object).Count

$floor = $up - $down
Write-Output "Floor: $floor"