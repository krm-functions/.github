# KRM Functions

This purpose of this organisation is to provide generally usable
functions for operating on configuration-as-code using the Kubernetes
Resource Model (KRM) as defined in [KRM Functions
Specification](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md).

For a general introduction to using KRM functions see [Replacing Helm and Kustomize with KRM Functions — a New Approach to Configuration Management](https://medium.com/@michael.vittrup.larsen/replacing-helm-and-kustomize-with-krm-functions-a-new-approach-to-configuration-management-676212cc1332).

For an broader description on how to use and develop new KRM functions see [the kpt book](https://kpt.dev/book/).

Functions:

| Name | Description |
| --- | --- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md) | Update resource field values through setters |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md) | Lookup container image digests and write back into e.g. RenderHelmChart values |
| [gatekeeper](https://github.com/krm-functions/gatekeeper/blob/main/README.md) | Verify Gatekeeper policies against resources |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md) | Lookup Helm chart upgrades and upgrade according to upgrade constraints |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md) | Validate resource schemas |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md) | Compose packages from other packages |
| [remove-local-config-resources](https://github.com/krm-functions/catalog/blob/main/docs/remove-local-config-resources.md) | Remove resources marked as local-config-only |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md) | Render Helm chart |
| [set-annotations](https://github.com/krm-functions/catalog/blob/main/docs/set-annotations.md) | Set resource annotations |
| [set-labels](https://github.com/krm-functions/catalog/blob/main/docs/set-labels.md) | Set resource labels |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md) | Source a Helm chart for use with render-helm-chart function in declarative pipelines |
| [starlark](https://github.com/krm-functions/starlark/blob/main/README.md) | Resource modification defined by Starlark programs |
| apply-replacement | See [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md), which can use setters read from other resources |

## Verifying Build Provenance

Function images are signed using Cosign and provenance can be verified
as e.g.:

```shell
export FUNCTION_IMAGE=ghcr.io/krm-functions/source-packages@sha256:5b63b6d52a9e72a59d6d6098d92975542daa9b79dbe11bc4fe36af7b8f2e4fdc
export BUILDER=https://github.com/krm-functions/catalog/.github/workflows/build.yaml

cosign verify --certificate-identity $BUILDER@refs/heads/main --certificate-oidc-issuer https://token.actions.githubusercontent.com $FUNCTION_IMAGE
```

See [catalog.json](catalog.json) for the list of image digests and builders.

## Links

The following are references to other KRM functions. These functions
are not associated with this `krm-functions` organization.

- [kispaljr/krm-functions](https://github.com/kispaljr/krm-functions)
- [Nephio project](https://github.com/nephio-project/nephio/tree/main/krm-functions)
- [bluebrown/krm-filter](https://github.com/bluebrown/krm-filter)

Generally there is also several functions available as 'kustomize plugins'.
