$EncodedText = “DQAKAA0ACgBXAHIAaQB0AGUALQBoAG8AcwB0ACAAIgBIAGUAbABsAG8AIQAiAA0ACgANAAoA"
$DecodedText = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($EncodedText))
$DecodedText

