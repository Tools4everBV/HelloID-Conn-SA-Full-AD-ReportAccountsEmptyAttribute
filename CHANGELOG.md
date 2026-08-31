# Change Log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com), and this project adheres to [Semantic Versioning](https://semver.org).

## [2.0.0] - 2026-08-20

### Added
- Added comprehensive documentation following current HelloID standards
- Added PowerShell module and cmdlet documentation
- Added Requirements and Connection settings sections
- Added Remarks section with attribute selection and report output details
- Added Development resources section

### Changed
- **BREAKING**: Updated user-defined variable name from `ADusersReportOU` to `ADusersReportSearchOU` for consistency
- **BREAKING**: Changed OU format from JSON array to semicolon-separated string for better usability
- Updated README structure to follow modern HelloID connector documentation standards
- Improved error handling with detailed context information
- Enhanced logging to use Write-Information instead of Write-Host for HelloID compatibility
- Updated PowerShell datasource with better code organization and comments

### Removed
- Removed deprecated Business Benefits section
- Removed HIDreportFolder variable (no longer used)

## [1.0.1] - 2021-11-03

### Added
- Added version number to connector
- Updated all-in-one setup script

## [1.0.0] - 2021-05-05

### Added
- Initial release of HelloID-Conn-SA-Full-AD-ReportAccountsEmptyAttribute
- Basic AD user report functionality for accounts with empty attributes
- Form-based attribute selection
- Display of user accounts with empty values in specified attribute
- CSV export capability in Service Automation
- Delegated form with user-defined variables for OU and report folder configuration
