function Invoke-AzureAdConnectorProvision {
    $EnvironmentName = "Infrastructure"
    $ApplicationName = "AzureADConnector"
    Invoke-ApplicationProvision -ApplicationName AzureAdConnector
    $Nodes = Get-TervisApplicationNode -ApplicationName $ApplicationName -EnvironmentName $EnvironmentName -IncludeVM
    $Nodes | Update-TervisSNMPConfiguration
    
}

function Invoke-InstallAndConfigureAzureADConnect {
    [CmdletBinding()]
    param(
        [parameter(ValueFromPipelineByPropertyName,Mandatory)]$Computername,
        [parameter(ValueFromPipelineByPropertyName,Mandatory)]$Credential
    )
    process {
        Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
            Install-Module MSOnline
        }
        ###No silent install. Run manually###
#        Invoke-Command -ComputerName $Computername -Credential $Credential -ScriptBlock {
#            & "\\tervis.prv\applications\Installers\Microsoft\Azure AD Connect\AzureADConnect.msi"
#        }
    }
}
