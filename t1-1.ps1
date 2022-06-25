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


            write-host $IP_Address_1
            write-host $IP_Address_2
            write-host $network_mask
            for ($i = 0; $i -lt 3; $i++) 
            {
             $net1[$i] = $( $IP_Address_1.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )
             $net2[$i] =   $( $IP_Address_2.GetAddressBytes()[$i] -band $network_mask.GetAddressBytes()[$i] )      
             }
             write-host "net1 :  "$net1[0..3]
             write-host "net2 :  "$net2[0..3]

        }#process
        
        end 
        { 
            #Set-Location -Path $old_loc 
        }
}
    


