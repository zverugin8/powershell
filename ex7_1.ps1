$data = $args[0]
$data = $data.split(0,' ')
$data1 = ($data -match '\w+[-_]\w+')
Write-Output $data1