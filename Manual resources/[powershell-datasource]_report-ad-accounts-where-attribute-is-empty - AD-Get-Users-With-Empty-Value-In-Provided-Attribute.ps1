#######################################################################
# Template: HelloID SA Powershell data source
# Name: report-ad-users-with-empty-attribute | AD-Get-Users-With-Empty-Attribute
# Date: 18-08-2026
#######################################################################

# For basic information about powershell data sources see:
# https://docs.helloid.com/en/service-automation/dynamic-forms/data-sources/powershell-data-sources.html

# Service automation variables:
# https://docs.helloid.com/en/service-automation/service-automation-variables.html

# Variables configured in form
$attributeName = $datasource.attributeName

# Global variables (Automation --> Variable library)
$searchOUs = $ADusersReportSearchOU

# Fixed values
$propertiesToSelect = @(
    "ObjectGuid",
    "CanonicalName",
    "DisplayName",
    "UserPrincipalName",
    "SamAccountName",
    "Department",
    "Title",
    "Enabled",
    "EmployeeId"
)

# Add the dynamic attribute to properties if not already included
if ($attributeName -notin $propertiesToSelect) {
    $propertiesToSelect += $attributeName
}

# Set debug logging
$VerbosePreference = "SilentlyContinue"
$InformationPreference = "Continue"
$WarningPreference = "Continue"

try {
    #region Get Primary Domain Controller
    $actionMessage = "querying Primary Domain Controller"
    
    $domainController = (Get-ADForest | Select-Object -ExpandProperty RootDomain | Get-ADDomain | Select-Object -Property PDCEmulator).PDCEmulator
    Write-Information "Queried Primary Domain Controller: [$domainController]"
    #endregion Get Primary Domain Controller

    # Build filter to find users where the specified attribute is empty
    $filter = "-not($attributeName -like '*')"
    Write-Information "Filter: users where attribute [$attributeName] is empty"

    # Query users
    $actionMessage = "querying AD account(s) matching the filter [$filter] in OU(s) [$($searchOUs)]"

    $ous = $searchOUs -split ';'
    $adUsers = [System.Collections.ArrayList]@()
    foreach ($ou in $ous) {
        $actionMessage = "querying AD account(s) matching the filter [$filter] in OU [$($ou)]"
        $getAdUsersSplatParams = @{
            Filter      = $filter
            SearchBase  = $ou
            Properties  = $propertiesToSelect
            Server      = $domainController
            Verbose     = $False
            ErrorAction = "Stop"
        }
        $getAdUsersResponse = Get-ADUser @getAdUsersSplatParams | Select-Object -Property $propertiesToSelect

        if ($getAdUsersResponse -is [array]) {
            [void]$adUsers.AddRange($getAdUsersResponse)
        }
        else {
            [void]$adUsers.Add($getAdUsersResponse)
        }
    }
    Write-Information "Queried AD account(s) matching the filter [$filter] in OU(s) [$($searchOUs)]. Result count: $(($adUsers | Measure-Object).Count)"
    
    # Sort results by DisplayName
    $actionMessage = "sorting results by DisplayName"
    $adUsers = $adUsers | Sort-Object -Property DisplayName
    
    # Send results to HelloID
    $adUsers | ForEach-Object {
        Write-Output $_
    }
}
catch {
    $ex = $PSItem
    Write-Warning "Error at Line [$($ex.InvocationInfo.ScriptLineNumber)]: $($ex.InvocationInfo.Line). Error: $($ex.Exception.Message)"
    Write-Error "Error $($actionMessage). Error: $($ex.Exception.Message)"
    # exit # use when using multiple try/catch and the script must stop
}
