#!/bin/bash
'
//This file is going to be the starting of the project with local Archtiecture ( A VM with Jenkins / Docker / Kubernetes )
// Register and pull images from docker hub for Kubernetes cluster 
// and make it available on the destinated namespace environments

// This file begin with installation of the neccessary softwares
// Then run jenkins and start the pipeline
// The pipeline steps take care of tool / software verification / docker build and push to docker hub
// Then build service container for Kubernetes and expose the container for microservices with different ips / ports
'
