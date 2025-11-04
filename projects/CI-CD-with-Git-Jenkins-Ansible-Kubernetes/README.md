This project demonstrates a complete CI/CD pipeline implementation using Git, Jenkins, Ansible, and Kubernetes. It automates the build, test, deploy, and delivery process of a sample web application, showcasing real-world DevOps practices used in production.

# Project Introduction

### Phase 1 : Code Check-In
this is the phase where the developer writes a code and get it merged into master/main branch post the proper PR Requests. for this we are using the Version control system like Git.

### Phase 2 : Code Build
after the completion of the Code Check-In, we need to build a Artifact for an further deployment. for code build we are using Jenkins

### Phase 3 : Continuous Delivery
after building an artifact from phase 2, we need to get it deployed on a VM or  Docker Container or Kubernetes for that we need continuous delivery solution. in this project we are usign Ansible for this.

---

### Deploy on 3 Environments
1. Deployment of Artifacts on a Tomcat Server
Setting up of Jenkins, Configure Maven, Setup Tomcat server, Integration of GitHub, Maven, Tomcat server with Jenkins and after that we will create a CI and CD Job.

![Deploy artifact on Tomcat server](assets/cicd-tomcat.png)

2. Deployment of Artifact on a Container
Setup of CI/CD with GitHub, Jenkins, Maven and Docker. in this setup we are going to setup a Docker environment, write a Dockerfile for deployment, create image and container, integrate docker host with jenkins and then finally create a CI/CD Job on Jenkins to build and deploy on a Container.

![Deploy Artifact on Container](assets/cicd-docker.png)

3. Deployment of Artifcat on a Container using Various Ansible playbooks. 
fot this we will be doing Setup of an Ansible server, integration of Docker host with Ansible, we will be writing 2 playbooks
* Ansible playbook to create a Docker Image
* Ansible playbook to create a Docker Container
![Deploy Artifact on Container using ansible](assets/cicd-ansible-docker.png)

4. Deployment of Artifact on a EKS - Kubernetes Cluster.
for this we are using AWS Managed kubernetes Service called EKS. we will be doing setup of EKS, writing Pod, Service, Deployment manifests, integrate Kubernetes with Ansible, will be writing Ansible playbooks for Deployment and Service Creation and finally CI/CD Job to build code on ansible and deploy it on Kubernetes
![Deploy Artifact on K8s using ansible](assets/cicd-ansible-kubernetes.png)
