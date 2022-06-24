#camel casing
$inputString = "the-stealth-warrior"
$inputString
[string[]]$srt_ar1 = $inputString.Split(@("-","_"))
$srt_ar1[0] = $srt_ar1[0].Substring(0,1).ToLower() + $srt_ar1[0].Substring(1,$srt_ar1[0].Length-1)
$srt_ar1[1] = $srt_ar1[1].Substring(0,1).toupper() + $srt_ar1[1].Substring(1,$srt_ar1[1].Length-1)
$srt_ar1[2] = $srt_ar1[2].Substring(0,1).toupper() + $srt_ar1[2].Substring(1,$srt_ar1[2].Length-1)
$inputString = $srt_ar1[0]+$srt_ar1[1]+$srt_ar1[2]
write-host $inputString
Pause
#pascal casing
$inputString = "The_Stealth_Warrior"
$inputString
[string[]]$srt_ar1 = $inputString.Split(@("-","_"))
$srt_ar1[0] = $srt_ar1[0].Substring(0,1).ToUpper() + $srt_ar1[0].Substring(1,$srt_ar1[0].Length-1)
$srt_ar1[1] = $srt_ar1[1].Substring(0,1).toupper() + $srt_ar1[1].Substring(1,$srt_ar1[1].Length-1)
$srt_ar1[2] = $srt_ar1[2].Substring(0,1).toupper() + $srt_ar1[2].Substring(1,$srt_ar1[2].Length-1)
$inputString = $srt_ar1[0]+$srt_ar1[1]+$srt_ar1[2]
write-host $inputString