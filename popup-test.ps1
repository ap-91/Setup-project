
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')

$text = [Microsoft.VisualBasic.Interaction]::InputBox('message', 'title')
