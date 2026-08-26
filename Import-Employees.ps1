Import-Csv -Path "Z:\employees.csv" | ForEach-Object {
    $ouPath = "OU=$($_.Department),DC=lab,DC=local"
    $userPrincipalName = "$($_.Username)@lab.local"
    $securePassword = ConvertTo-SecureString $_.Password -AsPlainText -Force

    $userParams = @{
        Name = "$($_.FirstName) $($_.LastName)"
        GivenName = $_.FirstName
        Surname = $_.LastName
        SamAccountName = $_.Username
        UserPrincipalName = $userPrincipalName
        Path = $ouPath
        AccountPassword = $securePassword
        Enabled = $true
        ChangePasswordAtLogon = $true
    }

    New-ADUser @userParams
    Write-Host "Created user: $($_.Username) in $($_.Department)" -ForegroundColor Green
}