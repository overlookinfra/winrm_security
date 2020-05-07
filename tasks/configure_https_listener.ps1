# Puppet Task Name: configure_https_listener

$listeners = Get-ChildItem WSMan:\localhost\Listener
If (!($listeners | Where-Object {$_.Keys -like "TRANSPORT=HTTPS"})) {

    # Grab the system FQDN for the SSL certificate
    $certname = [System.Net.Dns]::GetHostByName($env:computerName).Hostname

    $cert = New-SelfSignedCertificate -DnsName $certname -CertStoreLocation Cert:\LocalMachine\My

    # Create the hashtables of settings to be used.
    $valueset = @{
        Hostname = $certname
        CertificateThumbprint = $cert.Thumbprint
    }

    $selectorset = @{
        Transport = "HTTPS"
        Address = "*"
    }

    New-WSManInstance -ResourceURI 'winrm/config/Listener' -SelectorSet $selectorset -ValueSet $valueset
    Write-Output "{""status"":""Configured SSL listener.""}"
} Else {
    Write-Verbose "SSL listener is already active."
    Write-Output "{""status"":""SSL listener is already active.""}"
}