 terraform {
    required_providers {
      scaleway = {
        source = "scaleway/scaleway"
      }
    }
    required_version = ">= 0.13"
  }
  provider "scaleway" {
    zone            = "fr-par-1"
    region          = "fr-par"
  }
  cloud {
       organization = "Alyssum"

       workspaces {
         name = "terraform_practice"
      }
  }
   
  resource "scaleway_k8s_cluster" "k8s-mafao-dev" {
   name    = "k8s-mafao-dev"
   version = "1.24.3"
   cni     = "cilium"
   delete_additional_resources = false
  }

resource "scaleway_k8s_pool" "mafao_dev_keycloak" {
  cluster_id = scaleway_k8s_cluster.k8s-mafao-dev.id
  name       = "mafao_dev_keycloak"
  node_type  = "PLAY2-NANO"
  min_size = 1
  max_size = 2
  size = 1
  autoscaling = true
  autohealing = true
}
