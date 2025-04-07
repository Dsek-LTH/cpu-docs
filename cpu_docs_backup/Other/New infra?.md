# ✏️ New infra?

# Researching new infrastructure

# Intro

### **What problem(s) are we trying to solve?**


1. As a developer, I struggle with easily deploying SaaS applications. I have to rely on our infra team to help me deploy applications. This is in stark contrast to something like Vercel or GitHub Pages where I can easily set it up deploy new versions of my application on push or a new release.
2. As a newbie to our infra team, I struggle with getting an overview of all of our systems and services. Services seem to be arbitrarily scattered across different VMs and Raspberry Pis. Some services run inside containers and tracking down the Dockerfile can be difficult. Other services run directly in the VM and again, I have to find out where and how the process is being run. Finally, the performance of our main web application is not at all where it needs to be. There is currently no easy way of quickly scaling up applications across nodes.
3. As a manager of our infra team, I want new users to be able to experiment on fresh nodes without having to worry about destroying anything. Currently, whenever a user wants to try running a service "for real" they find an existing VM that looks like it's not too full and deploys the service there alongside any previous services. Alternatively, a long process of provisioning a new VM begins which slows down development. ==I also want to give users granular access to the services they manage/contribute to.==

### **What does a high-level solution look like?**


1. A platform that allows developers to easily self-service their software deployments. Just like any PaaS, i.e Vercel.
2. A platform that provides an overview of all running services across all nodes, regardless of whether they are deployed as a container or not.
3. (optional) A platform that automatically moves and easily scales applications across nodes.

### **How can these solutions be implemented?**

* We have a few servers that act as nodes. An easy approach would be to deploy all containers on one server. Optionally, we could provide Coolify for developer convenience, but either way we can easily get an overview of all containers if they are running on one machine. New services are easy to add — just add a new container. Everything could be handled through docker-compose files placed in one directory per application.

  For non-containerized applications, we could deploy them manually on the remaining servers. Hopefully, there wouldn't be that many of them.

  This implementation starts to break down when we need to spread out applications across multiple nodes. Suddenly, it's no longer trivial to get an overview of all applications. Coolify helps with this — it can handle multiple nodes. But there is still the issue of choosing which node to deploy an application to; what determines when a node is at capacity?
* *Sidenote: Why use VMs?*

  VMs provide isolation and stability. So do containers.

# Conclusion

Kubernetes is the enterprise standard for multi-node container orchestration. However, it is seen as very complicated and a big step up from just deploying Docker containers normally.

Proxmox is the de-facto standard for managing VMs (and system containers) in a homelab. However, it provides no OCI container management.


:::success
HashiCorp Nomad strikes a good balance. It can provision VMs, system containers and application containers with a focus on the latter. It is simple yet powerful enough and supports both OIDC SSO and access control policies.

:::

# Comparison

 ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/1949cdde-539b-430d-ae88-10477de1820d/3bfe1785-217b-4ba3-a3de-cb45c7aab6f6/image.png)

## **Orchestration**

*Orchestration is the automated configuration, coordination, deployment, development, and management of computer systems and software.*

[Why do we need orchestrators?](https://chaordic.io/blog/is-nomad-a-better-kubernetes/)

* HashiCorp Nomad — KVM, OCI, hybrid cloud

  > Nomad is a highly available, distributed, data-center aware cluster and application scheduler designed to support the modern datacenter with support for long-running services, batch jobs, and much more.
  * ==Simple for devs and lots of supported runtimes==
  * ==Mainly developed by HashiCorp==
* ~~K3s — containers~~

  > Kubernetes is a portable, open source platform for managing containerized workloads and services, that facilitates both declarative configuration and automation. K3s is easy to install, half the memory, all in a binary of less than 100 MB.
  * ==Practically the default scheduler in the industry==
  * ==Too complex and mainly supports containers==

## PaaS

*Platform as a service is a cloud service model where users provision, run and manage a bundle of a computing platform and applications, without the complexity of managing the underlying infrastructure.*

* Coolify

  > Coolify is an all-in one PaaS that helps you to self-host your own applications, databases or services without managing your servers and all the complexity that comes with it. It is also known as an **open-source & self-hostable Heroku / Netlify / Vercel alternative**.
* ~~Portainer~~

  > Portainer hides the complexity of managing containers behind an easy-to-use UI. By removing the need to use the CLI, write YAML or understand manifests, Portainer makes deploying apps and troubleshooting problems so easy that anyone can do it.
  * ==No free RBAC==
* ~~Rancher~~

  > Rancher is a Kubernetes management tool to deploy and run clusters anywhere and on any provider. Rancher can provision Kubernetes from a hosted provider, provision compute nodes and then install Kubernetes onto them, or import existing Kubernetes clusters running anywhere.
  * ==Too in-depth Kubernetes==
* ~~Dokku~~

  > Dokku is an extensible, open source PaaS that runs on a single server of your choice. Dokku supports building apps on the fly from a git push via either Dockerfile or by auto-detecting the language with Buildpacks, and then starts containers based on your built image.
  * ~~==No UI==~~
* ~~Red Hat OpenShift~~

  > OpenShift Container Platform is a cloud-based Kubernetes container platform. The foundation of OpenShift Container Platform is based on Kubernetes and therefore shares the same technology. It is designed to allow applications and the data centers that support them to expand from just a few machines and applications to thousands of machines that serve millions of clients. ⇒ Kubernetes PaaS

## IaaS

* Apache CloudStack — LDAP/SSO, audit logs, networking, storage, KVM, LXC

  > Apache CloudStack is an open source Infrastructure-as-a-Service platform that manages and orchestrates pools of storage, network, and computer resources to build a public or private IaaS compute cloud.
* Proxmox VE — KVM, LXC, networking, storage

  > Proxmox Virtual Environment is a complete, open-source server management platform for enterprise virtualization. It tightly integrates the KVM hypervisor and Linux Containers (LXC), software-defined storage and networking functionality, on a single platform.
* MicroStack — LCD, LXC, OVN, Ceph

  > OpenStack is a cloud operating system that controls large pools of compute, storage, and networking resources throughout a datacenter, all managed through a dashboard that gives administrators control while empowering their users to provision resources through a web interface. MicroStack is a modern cloud solution that uses snaps, Juju, and Kubernetes to deploy and manage OpenStack.

## Others

* Incus — container and VMs

  Looks awesome, but lacks RBAC (?)
* [OpenFaaS](https://www.openfaas.com/)
* [MaaS](https://maas.io/)
* Terraform — IaC
* LXD — custom lightweight proxmox