# HelloID-Conn-SA-Full-AD-ReportAccountsEmptyAttribute

| :information_source: Information |
|:---|
| This repository contains the connector and configuration code only. The implementer is responsible for acquiring the connection details such as username, password, certificate, etc. You might even need to sign a contract or agreement with the supplier before implementing this connector. Please contact the client's application manager to coordinate the connector requirements. |

## Description

_HelloID-Conn-SA-Full-AD-ReportAccountsEmptyAttribute_ is a delegated form designed for use with HelloID Service Automation (SA). It can be imported into HelloID and customized according to your requirements.

By using this delegated form, you can generate a report of Active Directory user accounts with empty values in a specified attribute. The following options are available:

1. Select which Active Directory attribute to check for empty values.
2. View a list of all AD user accounts that have no value in the specified attribute.
3. View basic AD user account attributes (ObjectGuid, CanonicalName, DisplayName, UserPrincipalName, SamAccountName, Department, Title, Enabled status, EmployeeId, and the selected attribute).
4. Optionally download the results directly from the HelloID interface using the built-in download functionality.

## Getting started

### Requirements

• **Active Directory Access**:  
  The connector requires read access to an Active Directory domain. A service account with appropriate AD read permissions is necessary.

• **HelloID Agent**:  
  A HelloID Agent must be installed and configured to communicate with the Active Directory domain.

• **PowerShell module 'ActiveDirectory'**:  
  The HelloID Agent must have PowerShell available with Active Directory module support.

### Connection settings

The following user-defined variables are used by the connector.

| Setting | Description | Mandatory |
|---------|-------------|-----------|
| ADusersReportSearchOU | Semicolon-separated list of Active Directory OUs for scoping AD user accounts in the report (e.g., `OU=Users,DC=domain,DC=local;OU=Employees,DC=domain,DC=local`) | Yes |

## Remarks

### Attribute Selection

• **Dynamic Attribute**:  
  Users can specify which attribute to check for empty values. The selected attribute is dynamically added to the report output.

• **Search Scope**:  
  The search is limited to the OUs defined in the `ADusersReportSearchOU` variable.

### Report Output

• **Fixed Properties**:  
  The report always includes ObjectGuid, CanonicalName, DisplayName, UserPrincipalName, SamAccountName, Department, Title, Enabled, and EmployeeId.

• **Dynamic Property**:  
  The user-selected attribute is automatically added to the output properties.

• **Sorting**:  
  Results are sorted by DisplayName for easier review.

## Development resources

### PowerShell Module

This connector uses the ActiveDirectory PowerShell module for querying Active Directory user accounts.

- [ActiveDirectory Module Documentation](https://learn.microsoft.com/en-us/powershell/module/activedirectory/)

### Cmdlets

The following PowerShell cmdlets are used by the connector:

| Cmdlet | Description |
| --- | --- |
| Get-ADForest | Retrieves Active Directory forest information |
| Get-ADDomain | Retrieves Active Directory domain information |
| Get-ADUser | Retrieves Active Directory user accounts |

### Cmdlet documentation

- [Get-ADForest](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-adforest)
- [Get-ADDomain](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-addomain)
- [Get-ADUser](https://learn.microsoft.com/en-us/powershell/module/activedirectory/get-aduser)

## Getting help

| :bulb: Tip |
|:---|
| For more information on Delegated Forms, please refer to our [documentation](https://docs.helloid.com/en/service-automation/delegated-forms.html) pages. |

## HelloID docs

The official HelloID documentation can be found at: [https://docs.helloid.com/](https://docs.helloid.com/)
