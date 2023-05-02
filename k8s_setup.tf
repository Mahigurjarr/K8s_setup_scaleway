 terraform {
    required_providers {
      scaleway = {
        source = "scaleway/scaleway"
      }
    }
    required_version = ">= 0.13"
  }
  provider "scaleway" {
    access_key      = "SCW3WDMRCB8ND02Q7HDV"
    secret_key      = "a4d86698-faf7-4afb-9dee-91925fcea703"
    project_id	    = "33ebcbf6-7407-4e6f-8d64-b2bee2bf8a41"
    zone            = "fr-par-1"
    region          = "fr-par"
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