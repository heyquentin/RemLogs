#############################
#
# This is the Review form. It's a variable called in $buttonReview.Add_MouseClick
#
#############################

$ReviewForm = {

Add-Type -AssemblyName System.Windows.Forms

$Review = New-Object system.Windows.Forms.Form
$Review.Text = "Review"
$Review.TopMost = $true
$Review.Width = 509
$Review.Height = 175

$labelReviewPath = New-Object system.windows.Forms.Label
$labelReviewPath.Text = "Path:"
$labelReviewPath.AutoSize = $true
$labelReviewPath.Width = 25
$labelReviewPath.Height = 10
$labelReviewPath.location = new-object system.drawing.point(9,19)
$labelReviewPath.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelReviewPath)

$labelPathVAR = New-Object system.windows.Forms.Label
$labelPathVAR.Text = $textBoxPath.text
$labelPathVAR.AutoSize = $true
$labelPathVAR.Width = 25
$labelPathVAR.Height = 10
$labelPathVAR.location = new-object system.drawing.point(43,19)
$labelPathVAR.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelPathVAR)

$labelReviewType = New-Object system.windows.Forms.Label
$labelReviewType.Text = "File Type:"
$labelReviewType.AutoSize = $true
$labelReviewType.Width = 25
$labelReviewType.Height = 10
$labelReviewType.location = new-object system.drawing.point(9,46)
$labelReviewType.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelReviewType)

$labelFileTypeVAR = New-Object system.windows.Forms.Label
$labelFileTypeVAR.Text = $textBoxTOF.text
$labelFileTypeVAR.AutoSize = $true
$labelFileTypeVAR.Width = 25
$labelFileTypeVAR.Height = 10
$labelFileTypeVAR.location = new-object system.drawing.point(71,46)
$labelFileTypeVAR.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelFileTypeVAR)

$labelReviewDays = New-Object system.windows.Forms.Label
$labelReviewDays.Text = "Days to keep:"
$labelReviewDays.AutoSize = $true
$labelReviewDays.Width = 25
$labelReviewDays.Height = 10
$labelReviewDays.location = new-object system.drawing.point(9,73)
$labelReviewDays.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelReviewDays)

$labelDaysVAR = New-Object system.windows.Forms.Label
$labelDaysVAR.Text = $textBoxNumDays.text
$labelDaysVAR.AutoSize = $true
$labelDaysVAR.Width = 25
$labelDaysVAR.Height = 10
$labelDaysVAR.location = new-object system.drawing.point(95,73)
$labelDaysVAR.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelDaysVAR)

$labelGoodToGo = New-Object system.windows.Forms.Label
$labelGoodToGo.Text = "If this all looks good click Execute"
$labelGoodToGo.AutoSize = $true
$labelGoodToGo.Width = 25
$labelGoodToGo.Height = 10
$labelGoodToGo.location = new-object system.drawing.point(9,100)
$labelGoodToGo.Font = "Microsoft Sans Serif,10"
$Review.controls.Add($labelGoodToGo)

$buttonExecute = New-Object system.windows.Forms.Button
$buttonExecute.BackColor = "#1bd40f"
$buttonExecute.Text = "Execute"
$buttonExecute.Width = 80
$buttonExecute.Height = 30
$buttonExecute.location = new-object system.drawing.point(230,95)
$buttonExecute.Font = "Microsoft Sans Serif,10"
$buttonExecute.Add_MouseClick({&$DoItDoItDoIt
})
$Review.controls.Add($buttonExecute)

$buttonCancel = New-Object system.windows.Forms.Button
$buttonCancel.BackColor = "#C83636"
$buttonCancel.Text = "Cancel"
$buttonCancel.Width = 80
$buttonCancel.Height = 30
$buttonCancel.location = new-object system.drawing.point(330,95)
$buttonCancel.Font = "Microsoft Sans Serif,10"
$buttonCancel.Add_MouseClick({&$Quit
})
$Review.controls.Add($buttonCancel)

[void]$Review.ShowDialog()
$Review.Dispose()
}


#############################
#
# This is the execute script
#
#############################

$DoItDoItDoIt = {

# Get today's date, go back however many days and put that date to a string
$Date = Get-Date
$Date = $Date.adddays(-$($textBoxNumDays.text))
$Date2String = $Date.ToString("yyyyMMdd")


# Search the path listed to find the chosen file type
If ($checkBoxRecurse.checked -eq $true) { $LogFiles = Get-ChildItem -path $textBoxPath.text -Recurse -Include "*.$($textBoxTOF.text)"}
    else
{$LogFiles = Get-ChildItem -path $textBoxPath.text | Where-Object {$_.Extension -eq ".$($textBoxTOF.text)"}}


# Look at each file in the folder searched above and put that file's last write date to a string
# If the file's last write date is less than or equal to today's date minus 30 days then delete the file
 foreach ($File in $LogFiles){
    $LogFileDate = $File.LastWriteTime
    $LogFileDate2String = $LogFileDate.ToString("yyyyMMdd")
    if ($LogFileDate2String -le $Date2String) {Remove-Item $File.Fullname}
}

Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form 
$Form.Text = "Click to Close"
$Form.TopMost = $true
$Form.Width = 282
$Form.Height = 163

$labelClick2Close = New-Object system.windows.Forms.Label 
$labelClick2Close.Text = "All done, click to close."
$labelClick2Close.AutoSize = $true
$labelClick2Close.Width = 100
$labelClick2Close.Height = 10
$labelClick2Close.location = new-object system.drawing.point(70,25)
$labelClick2Close.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($labelClick2Close) 

$buttonClick2Close = New-Object system.windows.Forms.Button 
$buttonClick2Close.Text = "Close"
$buttonClick2Close.Width = 60
$buttonClick2Close.Height = 30
$buttonClick2Close.location = new-object system.drawing.point(110,61)
$buttonClick2Close.Font = "Microsoft Sans Serif,10"
$buttonClick2Close.Add_MouseClick({&$Quit
})
$Form.controls.Add($buttonClick2Close) 

[void]$Form.ShowDialog() 
$Form.Dispose() 

}


#############################
#
# This is the cancel script
#
#############################

$Quit = {
    [environment]::exit(0)
}


#############################
#
# This is the main form
#
#############################

Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Delete Files"
$Form.TopMost = $true
$Form.Width = 635
$Form.Height = 250

$labelDescription = New-Object system.windows.Forms.Label
$labelDescription.Text = "This program lets you choose the number of days`' worth of files to keep based on the last write date of the file and deletes the rest. Great for log files."
$labelDescription.Width = 604
$labelDescription.Height = 37
$labelDescription.location = new-object system.drawing.point(15,8)
$labelDescription.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($labelDescription)

$labelPath = New-Object system.windows.Forms.Label
$labelPath.Text = "Path (ex: c:\inetpub\logs\LogFiles)"
$labelPath.AutoSize = $true
$labelPath.Width = 25
$labelPath.Height = 10
$labelPath.location = new-object system.drawing.point(11,52)
$labelPath.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($labelPath)

$textBoxPath = New-Object system.windows.Forms.TextBox
$textBoxPath.Width = 585
$textBoxPath.Height = 20
$textBoxPath.location = new-object system.drawing.point(11,76)
$textBoxPath.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBoxPath)

$checkBoxRecurse = New-Object system.windows.Forms.CheckBox
$checkBoxRecurse.Text = "Recursive"
$checkBoxRecurse.AutoSize = $true
$checkBoxRecurse.Width = 95
$checkBoxRecurse.Height = 20
$checkBoxRecurse.location = new-object system.drawing.point(11,104)
$checkBoxRecurse.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($checkBoxRecurse)

$labelTOF = New-Object system.windows.Forms.Label
$labelTOF.Text = "Type of file (ex. log, txt, pdf)"
$labelTOF.AutoSize = $true
$labelTOF.Width = 25
$labelTOF.Height = 10
$labelTOF.location = new-object system.drawing.point(11,143)
$labelTOF.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($labelTOF)

$textBoxTOF = New-Object system.windows.Forms.TextBox
$textBoxTOF.Width = 28
$textBoxTOF.Height = 20
$textBoxTOF.location = new-object system.drawing.point(185,141)
$textBoxTOF.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBoxTOF)

$labelKTL = New-Object system.windows.Forms.Label
$labelKTL.Text = "Keep the last"
$labelKTL.AutoSize = $true
$labelKTL.Width = 25
$labelKTL.Height = 10
$labelKTL.location = new-object system.drawing.point(11,177)
$labelKTL.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($labelKTL)

$textBoxNumDays = New-Object system.windows.Forms.TextBox
$textBoxNumDays.Width = 28
$textBoxNumDays.Height = 20
$textBoxNumDays.location = new-object system.drawing.point(96,175)
$textBoxNumDays.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($textBoxNumDays)

$labelDaysWorth = New-Object system.windows.Forms.Label
$labelDaysWorth.Text = "days worth of files"
$labelDaysWorth.AutoSize = $true
$labelDaysWorth.Width = 25
$labelDaysWorth.Height = 10
$labelDaysWorth.location = new-object system.drawing.point(130,177)
$labelDaysWorth.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($labelDaysWorth)

$buttonReview = New-Object system.windows.Forms.Button
$buttonReview.BackColor = "#5ea1a0"
$buttonReview.Text = "Review"
$buttonReview.Width = 80
$buttonReview.Height = 30
$buttonReview.location = new-object system.drawing.point(520,150)
$buttonReview.Font = "Microsoft Sans Serif,10,style=Bold"
$buttonReview.Add_MouseClick({&$ReviewForm
})
$Form.controls.Add($buttonReview)


[void]$Form.ShowDialog()
$Form.Dispose()