# Image registry

| **🌐 URL** | <https://registry.dsek.se> |
|----|----|
| **💡 Purpose** | Lagring av container images. |
| **👥 Stakeholders** | CPU |
| **🏗️ Infrastructure** | OKD |
| **🔗 Dependencies** | none |
| **🚦 Status** | active |
| **⚠️ Criticality** | medium |
| **🗃️ Source** | OKD builtin (based on [registry](https://github.com/distribution/distribution)) |

## Accessing the registry

### With `oc`

See @[OKD cli](mention://68108653-8cd4-457c-8c57-c60569002b64/document/521849f4-6a91-4948-91ce-21d527c78ab1)

```bash
podman login -u kubeadmin -p $(oc whoami -t) registry.dsek.se
```

Or

```bash
docker login -u kubeadmin -p $(oc whoami -t) registry.dsek.se
```