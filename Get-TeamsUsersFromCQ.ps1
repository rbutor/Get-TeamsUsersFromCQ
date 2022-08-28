Import-Module MicrosoftTeams
Connect-MicrosoftTeams

$cs = Get-CsCallQueue | select Tenantid, name, users, agents

foreach ($x in $cs) 
    {
    $out = @()
    foreach ($u in $x.users) 
        {
        $out += [pscustomobject]@((get-csonlineuser -identity $u).sipaddress)
        }
        $x.users = $out
        
    }
foreach ($v in $cs) 
    {
    $out2 = @()
    foreach ($u2 in $v.agents.objectID) 
        {
        $out2 += [pscustomobject]@((get-csonlineuser -identity $u2).sipaddress)
        }
        $x.agents = $out2
        
    }
$cs
