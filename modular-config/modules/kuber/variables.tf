variable "kube" { #When you us nested objects withina variable, to call upon your selected object, 
  type = object({ #you must use the dot notation.
    fleet_name  = string
    net_name      = string
    subnet_name   = string
    subnet_region = string
    pool_name     = string
    min_count     = number
    max_count     = number
    service       = string
  })
}

#var.kube.