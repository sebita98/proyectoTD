setMode -bscan                                    
setCable -p auto                                 
addDevice -position 1 -file .\s3esk_startup.bit  
addDevice -position 2 -part "xcf04s"             
addDevice -position 2 -part "xcf04s"             
ReadIdcode -p 1                                  
program -p 1                                     
quit                                             
