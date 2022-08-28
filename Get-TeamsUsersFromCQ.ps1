#Connect-MicrosoftTeams 
# | Where-Object {$_.Name -eq "Оперативник Нефтяная"} 
$cs = Get-CsCallQueue | select name, ApplicationInstances, Tenantid, Identity, users, agents

foreach ($sipid in $cs) 
    {
    
    foreach ($sip in $sipid.ApplicationInstances) 
        {
        $outsip = ((get-csonlineuser -identity $sip).SipProxyAddress)
        }
        $sipid.Identity = $outsip        
    }



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
        $v.agents = $out2        
    }
foreach ($appid in $cs) 
    {
    
    foreach ($phone in $appid.ApplicationInstances) 
        {
        $outappid = ((get-csonlineuser -identity $phone).LineURI)
        }
        $appid.ApplicationInstances = $outappid  
    }

$cs | ConvertTo-Json
