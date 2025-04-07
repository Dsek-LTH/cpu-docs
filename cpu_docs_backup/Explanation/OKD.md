# OKD

WIP

\[Should explain the big picture of how our infrastructure is set up and why, similar to @[Tech stack](mention://a3242c8c-3e27-476a-9d2a-287779945fcb/document/f3fcae9d-f5d4-4468-b9fe-370d53235f40)\]


# Why OKD?

* OKD allows us to run containers. The system we move away from, oVirt, let us create virtual machines which can run any workload imaginable. However, deploying to VMs adds complexity and overhead while - for most of our use case - not providing any benefits compared to containers. Container technology is becoming (if it isn't already) the default way to develop and deploy applications for Linux.
* OKD combines our servers into a cluster. We want a solution that allows us to utilize our eight server nodes with minimal manual work. High-availability and being able to reboot a node without downtime is also desirable.
* OKD is Kubernetes. Kubernetes is the standard container orchestration tool. It's reliable and flexible and has a large and growing ecosystem based around it. Kubernetes can also be a useful skill for software developers in the job market.
* OKD is an opinionated deployment of Kubernetes. The Kubernetes ecosystem offer lots of choice in how to compose different components, like for example web GUI, IngressController, build system, user authentication, logging etc. With OKD, we don't have to make most of those decisions since RedHat has decided for us. This also means we don't have to document all these choices and subsystems, instead relying on the official OKD and RedHat docs. 
* OKD is easy to operate. Many common administration tasks on the Kubernetes cluster and its underlying infrastructure are much easier in OKD than regular Kubernetes. For example OS updates, graceful node reboots, adding nodes to the cluster, monitoring and alerts.

# How we use OKD

## Persistent storage

Currently, we use the NFS storage from pando. All data is stored is `/klusterbitar/okd`. There is a StorageClass called klusterbitar which automatically creates PersitentVolumes there as needed. `/klusterbitar` is a ZFS pool of three 8TB hard drives in raid5. 

The plan is to eventually run a storage cluster in OKD.

## Labels and naming

> *"There are only two hard things in Computer Science: cache invalidation and naming things"* ‒ Phil Karlton

Names can be reused within the same namespace as long as they are for different types of resources. The name does not need to explain the type of the resource. Choose names like `vaultwarden`, not `vaultwarden-deployment`.

Here is how we use the recommended labels:

* `app` is used to associate Pods with Services and ReplicaSets.
* `app.kubernetes.io/part-of` is used for grouping related Deployments. In the web console, for example in the Topology view, everyting with the same value is grouped as an App.
* `app.kubernetes.io/managed-by` shows ownership and origin and how someone should update the deployment. If, for example, the deployment yaml is tracked our dumbo-m git repo, the value should be `dumbo-m`.
* `app.kubernetes.io/component` shows the role within the application that this component serves. Example values: `database`, `cache`, `server`, `frontend`.
* `app.kubernetes.io/name` tells you what the container is running. It does not need to be unique. Example vaues: `postgresql`, `nodejs`, `rust`. This value also controls what icon is used in the Topology view.
* `app.kubernetes.io/instance` should consist of `name` and a unique postfix. Example values: `rust-sasta`, `nodejs-cpudocs`.
* `app.kubernetes.io/version` should be the version number of the thing running in the Deployment. `latest` is allowed if you don't really care.
* `app.openshift.io/runtime` \[optional\] can be used to specify an icon with higher priority than `/name`. Useful if the value you want to use for `/name` doesn't have an icon.