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
        write-host $IP_Address_1
        write-host $IP_Address_2
        write-host $network_mask
        }#process
        
        end 
        { 
            #Set-Location -Path $old_loc 
        }
}
    


