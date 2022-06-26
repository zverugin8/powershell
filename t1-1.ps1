function comp_ip 
{
    [cmdletbinding()]
    Param
    (
      # Param1 help description
      [parameter(Mandatory=$true,
                 Position=0)]
      [IPAddress]$IP_Address_1,
      
      # Param2 help description
      [parameter(Mandatory=$true,
                 Position=1)]
      [IPAddress]$IP_Address_2,
      
      # Param3 help description
      [parameter(Mandatory=$true,
                 Position=2)]
      [IPAddress]$network_mask

    )
        
          begin 
          {  
            
          }
        
        process 
        {
            #$mask1=@()
            $net1=@(0,0,0,0,0)
            $net2=@(0,0,0,0,0)


            Write-Verbose $IP_Address_1
            Write-Verbose $IP_Address_2
            Write-Verbose $network_mask
            for ($i = 0; $i -le 3; $i++) 
            {
             $net1[$i] = $( $IP_Address_1.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )
             $net2[$i] =   $( $IP_Address_2.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )      
             }
             Write-Verbose "net1 :  $($net1[0..3])"
             Write-Verbose "net2 :  $($net2[0..3])"
             $ress=( Compare-Object -ReferenceObject $net1[0..3] -DifferenceObject $net2[0..3] )
             if ( $ress.Length -eq 0 ) {Write-Output "YES"}
             else {Write-Output "NO"}

        }#process
        
        end 
        { 
            #Set-Location -Path $old_loc 
        }
}
    


