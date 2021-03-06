            try {
                $attribuut = $datasource.attributevar
                $filter = {-not($attribuut -like "*")}
                $properties = "CanonicalName", "Displayname", "UserPrincipalName", "SamAccountName", "Department", "Title", "Enabled"
                
                $ous = $ADusersReportOU | ConvertFrom-Json
                $result = foreach($item in $ous) {
                    Get-ADUser -Filter $filter -SearchBase $item.ou -Properties $properties
                }
                $resultCount = @($result).Count
                $result = $result | Sort-Object -Property Displayname

                if($resultCount -gt 0){
                    foreach($r in $result){
                        $returnObject = @{CanonicalName=$r.CanonicalName; Displayname=$r.Displayname; UserPrincipalName=$r.UserPrincipalName; SamAccountName=$r.SamAccountName; Department=$r.Department; Title=$r.Title; Enabled=$r.Enabled;}
                        Write-output $returnObject
                    }
                } else {
                }
                
            } catch {
      
            }
