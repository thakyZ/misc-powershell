Param (
  [parameter(ValueFromPipeline=$true, Mandatory=$true, Position=0, ParameterSetName="Directory")][String[]] $Directory
)
Get-ChildItem -Path $Directory | Unblock-File
