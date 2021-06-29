$test = (Read-Host -Prompt "Is this a laptop or a desktop?(type l or d)")
$test=(Get-culture).TextInfo.ToTitleCase($test.ToLower())
$test
Read-Host -Prompt "end"