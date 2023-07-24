$DomainName = "www.microsoftaaaaa.com"  # Replace with the domain you want to test
$LogFilePath = "C:\tools\dns-test.txt"  # Replace with the desired log file path

function Get-DnsResponseTime {
    param (
        [string]$Domain
    )

    $Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    try {
        [System.Net.Dns]::GetHostAddresses($Domain) | Out-Null
        $Stopwatch.Stop()
        return $Stopwatch.ElapsedMilliseconds
    } catch {
        # If there's an error with DNS resolution, return -1 to indicate a failure
        return -1
    }
}

while ($true) {
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $ResponseTime = Get-DnsResponseTime -Domain $DomainName

    $LogEntry = "$Timestamp - Response Time: ${ResponseTime}ms"
    Add-Content -Path $LogFilePath -Value $LogEntry

    # Adjust the sleep interval (in seconds) based on how often you want to test
    Start-Sleep -Seconds 5
}