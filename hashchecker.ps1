<#
.EXAMPLE
    C:\PS> hashchecker -FilePath C:\Path\To\File.exe -Hash '71ee45a3c0db9a9865f7313dd3372cf60dca6479d46261f3542eb9346e4a04d6' -Algorithm SHA256
    
#>
Function hashchecker {
    [CmdletBinding()]
    [OutputType([boolean])]
        param(
            [Parameter(
                Mandatory=$True,
                Position=0,
                ValueFromPipeline=$True,
                ValueFromPipelineByPropertyName=$True)]
            [ValidateNotNullOrEmpty()]
            [string]$FilePath,

            [Parameter(
                Mandatory=$True,
                Position=1,
                ValueFromPipeline=$False)]
            [ValidateNotNullOrEmpty()]
            [string]$Hash,

            [Parameter(
                Mandatory=$False,
                Position=2,
                ValueFromPipeline=$False)]
            [ValidateSet("SHA1","SHA256","SHA384","SHA512","MD5","RIPEMD160","MACTripleDES")]
            [string]$Algorithm = "SHA256"

        )  # End param

BEGIN
{

    If (!(Test-Path -Path $FilePath))
    {

        Write-Error -Message "The value for the FilePath parameter was found to be invalid. The file does not exist in that location." -ErrorAction Stop

    }  # End If
    If ($Null -eq $Hash)
    {

        Write-Error -Message "A value has not been defined." -ErrorAction Stop

    }  # End If

}  # End BEGIN

PROCESS
{

    If ( (hashchecker -Path $FilePath -Algorithm $Algorithm | Select-Object -ExpandProperty Hash) -like $Hash )
    {

        Write-Verbose "SAFE: The $Algorithm value for $FilePath has been found to match the hash value provided."

        Return $True 

    }  # End If
    Else
    {

        Write-Verbose "ALERT: The $Algorithm value for $FilePath does not match the hash value provided. Please alert the site you downloaded the file from."

        Return $False 

    }  # End Else

}  # End PROCESS

}  #  End Compare-FileHash
