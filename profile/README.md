# KRM Functions

This purpose of this organisation is to provide generally usable
functions for operating on configuration-as-code using the Kubernetes
Resource Model (KRM) as defined in [KRM Functions
Specification](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md).

For a general introduction to using KRM functions see [Replacing Helm and Kustomize with KRM Functions — a New Approach to Configuration Management](https://medium.com/@michael.vittrup.larsen/replacing-helm-and-kustomize-with-krm-functions-a-new-approach-to-configuration-management-676212cc1332).

For an broader description on how to use and develop new KRM functions see [the kpt book](https://kpt.dev/book/).

Functions:

| Name                                                                                              | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)         | A re-implementation and improvement of the [baseline `apply-setters`](https://catalog.kpt.dev/apply-setters/v0.2/) function, which supports merge of multiple sources of apply-setters configuration and accepts configuration through both function-config and primary resource list. Also supports reading setter values from other resources.                                                                                                                                                                     |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                   | A function that can lookup container image digests for Helm charts and write-back digests into chart values.                                                                                                                                                                                                                                                                                                                                                                                                         |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                         | A re-implementation of the [baseline `gatekeeper`](https://catalog.kpt.dev/gatekeeper/v0.2/) function, which suppors newer variants of the Rego language (e.g. as used in the [gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library)) and which support gatekeeper [expansions](https://open-policy-agent.github.io/gatekeeper/website/docs/expansion)                                                                                                                                        |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)         | Function for automating upgrades of Helm chart specifications in e.g. KRM `RenderHelmChart` format. Supports upgrade constraints.                                                                                                                                                                                                                                                                                                                                                                                    |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)             | Function for validating resource schemas. Replacement for `kubeval`.                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md) | A re-implementation of the [baseline `render-helm-chart`](https://catalog.kpt.dev/render-helm-chart/v0.2/) function, which can be used in [declarative pipelines](https://kpt.dev/book/04-using-functions/01-declarative-function-execution) through Kptfiles. :warning: note, this function is dual purpose, it can both source and render charts. The sourcing feature is deprecated - use the [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md) for this instead. |
| [source-packages](https://github.com/krm-functions/catalog/blob/main/docs/source-packages.md)     | Declarative management of fleets of `kpt` packages, similar to [helmfile](https://github.com/helmfile/helmfile)                                                                                                                                                                                                                                                                                                                                                                                                      |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md) | A function that implements sourcing of helm charts to support rendering using declarative pipelines. This function augments [render-helm-chart](docs/render-helm-chart.md).                                                                                                                                                                                                                                                                                                                                          |

## Verifying Build Provenance

Function images are signed using Cosign and provenance can be verified
as e.g.:

```
export FUNCTION_IMAGE=ghcr.io/krm-functions/source-packages@sha256:43d9fa9a28dc12c1c0cfe9bf1b7795acca683e11bfdd82c49218ac951879d5b3
export BUILDER=https://github.com/krm-functions/catalog/.github/workflows/build.yaml

cosign verify --certificate-identity $BUILDER@refs/heads/main --certificate-oidc-issuer https://token.actions.githubusercontent.com $FUNCTION_IMAGE
```

See below for latest image digests and builders.

## Image Digests

| Function                                                                                          | Digest                                                                                                            | Builder |
| ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)         | `ghcr.io/krm-functions/apply-setters@sha256:ffeae3ad7f1b7b219743841fc21c302675096e6dbb3f52f87eec8598ae667f69`     | 1       |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                   | `ghcr.io/krm-functions/digester@sha256:3ce03c91fabc6add9c65bb406acb1ed2090e6cb1914a945cdad8217a296ee226`          | 1       |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                         | `ghcr.io/krm-functions/gatekeeper@sha256:8c4524d8538e6d50842c3eec70c932672457189e09f2e10ee6616b9b74d867e6`        | 2       |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)         | `ghcr.io/krm-functions/helm-upgrader@sha256:c60fc1e943c0be695b969d9ce2b040cd2f74404744ce7b0057c037136ce00be7`     | 1       |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)             | `ghcr.io/krm-functions/kubeconform@sha256:f75b8b50eb046d323cf3783e7a78a6fdacf2a6c0d5d84dadb271133774585c47`       | 1       |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md) | `ghcr.io/krm-functions/render-helm-chart@sha256:1a41df64aa0fdc61bf29721fdfba4c8e82089890d2d60980a8dd0d652d32f39a` | 1       |
| [source-packages](https://github.com/krm-functions/catalog/blob/main/docs/source-packages.md)     | `ghcr.io/krm-functions/source-packages@sha256:43d9fa9a28dc12c1c0cfe9bf1b7795acca683e11bfdd82c49218ac951879d5b3`   | 1       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md) | `ghcr.io/krm-functions/source-helm-chart@sha256:df1fa9f705193222a8d177035bec1f9477bdd3dbf2d2202712703c6f8336b99e` | 1       |

Builders:

```
1: https://github.com/krm-functions/catalog/.github/workflows/build.yaml
2: https://github.com/krm-functions/gatekeeper/.github/workflows/build.yaml
```

## Links

The following are references to other KRM functions. These functions
are not associated with this `krm-functions` organization.

- [kispaljr/krm-functions](https://github.com/kispaljr/krm-functions)
- [Nephio project](https://github.com/nephio-project/nephio/tree/main/krm-functions)
- [bluebrown/krm-filter](https://github.com/bluebrown/krm-filter)

Generally there is also several functions available as 'kustomize plugins'.
