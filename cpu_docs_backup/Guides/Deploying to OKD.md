# Deploying to OKD

OKD is our Kubernetes cluster where we run most services. For a deeper understanding of how it works, see @[Infrastructure](mention://46363a10-2467-44b7-a902-77b17f79caef/document/d546a701-3cf6-4edc-959a-f6c8cedb07bf).

If you want to do a quick tutorial before deploying something real, check out quick starts (click the question mark in top right). "Get started with a sample application" is a quick way to become familiar with the web console and seeing some kubernetes concepts in action.

## Before you begin:

* Are you using an existing container image (e.g., from Quay.io, Docker Hub)?
  * If yes, skip to "Creating Resources."
* Do you need to build an image from source?
  * If yes, see "Building an Image from a Git Repository."

# Building an image from a git repository

\[TODO\]

# Creating resources

There are many ways to deploy to the cluster. The easiest is probably to use the web console.


1. Open the **Administrator** view (top-left switcher).
2. Navigate to **Home > Projects** and create a new project.

## Deployments


1. Open the **Administrator** view (top-left switcher).
2. Go to **Workloads > Deployments**.
3. Ensure you are in the correct project (top-left corner).
4. Click **Create Deployment** → Switch to **YAML view**.

Most of the contents here will depend on the requirements of the app you are deploying, but here is some general guidance.

### Metadata and names

Kubernetes uses labels to organize Deployments. These labels do not affect execution but help with organization and visibility.

```yaml
  labels:
    app.kubernetes.io/part-of: <application>   # Group related Deployments
    app.kubernetes.io/managed-by: okd          # Shows ownership (e.g., a Git repo name)
    app.kubernetes.io/component: <purpose>     # Role (e.g., database, cache, server)
    app.kubernetes.io/name: <type>             # Container type (e.g., postgres, nodejs)
    app.kubernetes.io/instance: <type>-<thing> # Unique instance (e.g., nodejs-api)
    app.kubernetes.io/version: '<x.y.z>'       # Version
```

Names can be reused within the same namespace as long as they are for different types of resources. Choose short and obvious names.

### Volume mounts

Files or directories in the running container that need to come from elsewhere.

```yaml
volumeMounts:
  - name: db-data              # Needs to match name of a volume
    mountPath: /var/lib/mysql  # Location inside the container
```

### Ports

```yaml
ports:
  - containerPort: 80
```

### Environment and config

* If you have a lot of envrionment variables, or they are shared between multiple pods, use either a ConfigMap or a Secret.

```yaml
envFrom:
  configMapRef:
    name: app-env
```

* Otherwise, use `env:`
* Config files should be stored in a ConfigMap and mounted into the pod using a volume definition like this:

```yaml
volumes:
  - name: config
    configMap:
      name: redis-conf
```

## Storage with PersistentVolumeClaims

First, define the volume in your Deployment YAML:

```yaml
volumes:
  - name: mysql-data
    persistentVolumeClaim:
      claimName: db-data
```


1. Open the **Administrator** view (top-left switcher).
2. Go to **Storage > PersistentVolumeClaims** → Click **Create PersistentVolumeClaim**.
3. Fill out:
   * **StorageClass**: klusterbitar 
   * **Name**: Matches claimName in Deployment.
   * **Access Mode**: Choose based on shared storage needs.
   * **Volume Mode**: Filesystem (required for NFS-based storage).

If you need to migrate data from an existing deployment, ask @[David Agardh](mention://c7bd28d7-f848-44f0-b8b2-01487949ae72/user/b7aca933-2918-4648-8de7-a9692cd6e477) for help.

## Service

Makes your pod discoverable for other pods by giving it a DNS name


1. Open the **Administrator** view (top-left switcher).
2. Go to **Networking > Routes** → Click **Create Route.**
3. Fill out the yaml:

   
   1. `name:` Will be the DNS name others use to find your service
   2. `labels:` Service should have the same recommended labels as the deployment it's referencing.
   3. `selector: app:` must match `app` label set in the container template of the Deployment.

### Routes

If your Service should be accessible over http/https from **outside** the cluster, you will add a Route.


1. Open the **Administrator** view (top-left switcher).
2. Go to **Networking > Routes** → Click **Create Route.**
3. Select **Form view** and fill out:
   * **Hostname:** use `<yourservice>.apps.okd.dsek.se` for testing, otherwise you need to create a DNS record in cloudflare.
   * **Secure Route:** if you want https.
     * **TLS termination:** Edge.
     * **Insecure traffic:** Redirect.

## Finished?

Go to **Developer** view and select **Topography**. Here you can see if the rollout of you app is going well or if there are any problems.

# Problems

## Permission denied

OKD enforces stricter security than Docker/Kubernetes. Some containers may require additional permissions, often because they expect a specific user ID. Check out [this guide](https://linuxdatahub.com/openshift-run-container-as-root/) or ask for help.