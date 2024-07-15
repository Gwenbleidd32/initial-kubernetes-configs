/*Change the Vaules of the below Variables to Modify the configuration of the deployment modules*/

#NETWORK
network-det = {
    name                = "griffin-school-network"
    subnetwork_name     = "kaer-seren-main"
    nodes_cidr_range    = "10.132.0.0/20"
    pods_cidr_range     = "10.4.0.0/14"
    services_cidr_range = "10.8.0.0/20"
    region              = "europe-west10"
}
#>>> 

#KUBERNETES
kube-det = {
    fleet_name  = "atreides-war-fleet"
    subnet_region = "europe-west10"
    pool_name     = "sardaukar"
    min_count     = 1
    max_count     = 3
    service       = "876288284083-compute@developer.gserviceaccount.com"
}
#>>>

