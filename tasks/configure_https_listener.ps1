# Puppet Task Name: configure_https_listener

[CmdletBinding()]
param (
  # The number of days the SSL certificate is valid
  [Parameter(Mandatory=$false)]
  [int]
  $certificate_validity_days
)

$listeners = Get-ChildItem WSMan:\localhost\Listener

# Evaluate if an existing HTTPS listener exists
If (!($listeners | Where-Object {$_.Keys -like "TRANSPORT=HTTPS"})) {

    # Grab the system FQDN for the SSL certificate
    $certname = [System.Net.Dns]::GetHostByName($env:computerName).Hostname

    # Generate a self-signed SSL certificate and add it to the local machine certificate store
    $cert = New-SelfSignedCertificate -DnsName $certname -CertStoreLocation Cert:\LocalMachine\My -NotAfter (Get-Date).AddDays($certificate_validity_days)

    # Create the hashtables of settings to be used.
    $valueset = @{
        Hostname = $certname
        CertificateThumbprint = $cert.Thumbprint
    }

    $selectorset = @{
        Transport = "HTTPS"
        Address = "*"
    }

    # Create a HTTPS listener
    New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset
    Write-Output "{""status"":""Configured HTTPS listener""}"
} Else {
    Write-Output "{""status"":""HTTPS listener already configured""}"
}