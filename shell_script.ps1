Import-module ActiveDirectory
$path= "C:\data\test.csv"
Import-Csv -Path $path -Header "Email","ID","PayrollLocation","JobCode","Office","StreetAddress","State","City","Country","Phone","Fax", |
ForEach-Object{
IF(Get-ADUser -Filter "EmailAddress -eq '$($_.Email)'"){
Get-ADUser -Filter "EmailAddress -eq '$($_.Email)'" |
Set-ADUser -Replace @{description="$($_.ID),$($_.PayrollLocation),$($_.JobCode)";physicalDeliveryOfficeName="$($_.Office)";streetaddress="$($_.StreetAddress)";l="$($_.City)";st="$($_.State)";facsimiletelephonenumber="$($_.Fax)";telephonenumber="$($_.Phone)";co="$($_.Country)"}
}
Else
{
"$($_.Email),$($_.ID)" | Out-File -Filepath "C:\data\error_log.txt" -Append
}
}