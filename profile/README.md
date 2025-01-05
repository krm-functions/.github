# KRM Functions

This purpose of this organisation is to provide generally usable
functions for operating on configuration-as-code using the Kubernetes
Resource Model (KRM) as defined in [KRM Functions
Specification](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md).

For a general introduction to using KRM functions see [Replacing Helm and Kustomize with KRM Functions — a New Approach to Configuration Management](https://medium.com/@michael.vittrup.larsen/replacing-helm-and-kustomize-with-krm-functions-a-new-approach-to-configuration-management-676212cc1332).

For an broader description on how to use and develop new KRM functions see [the kpt book](https://kpt.dev/book/).

Functions:

| Name                                                                                                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| --------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)           | A re-implementation and improvement of the [baseline `apply-setters`](https://catalog.kpt.dev/apply-setters/v0.2/) function, which supports merge of multiple sources of apply-setters configuration and accepts configuration through both function-config and primary resource list. Also supports reading setter values from other resources.                                                                                                                                                                     |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                     | A function that can lookup container image digests for Helm charts and write-back digests into chart values.                                                                                                                                                                                                                                                                                                                                                                                                         |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                           | A re-implementation of the [baseline `gatekeeper`](https://catalog.kpt.dev/gatekeeper/v0.2/) function, which suppors newer variants of the Rego language (e.g. as used in the [gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library)) and which support gatekeeper [expansions](https://open-policy-agent.github.io/gatekeeper/website/docs/expansion)                                                                                                                                        |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)           | Function for automating upgrades of Helm chart specifications in e.g. KRM `RenderHelmChart` format. Supports upgrade constraints.                                                                                                                                                                                                                                                                                                                                                                                    |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)               | Function for validating resource schemas. Replacement for `kubeval`.                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md)   | A re-implementation of the [baseline `render-helm-chart`](https://catalog.kpt.dev/render-helm-chart/v0.2/) function, which can be used in [declarative pipelines](https://kpt.dev/book/04-using-functions/01-declarative-function-execution) through Kptfiles. :warning: note, this function is dual purpose, it can both source and render charts. The sourcing feature is deprecated - use the [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md) for this instead. |
| [source-packages](https://github.com/krm-functions/catalog/blob/main/docs/source-packages.md)       | :warning: renamed to `package-compositor`                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md) | Declarative management and composition of fleets of `kpt` packages, similar to [helmfile](https://github.com/helmfile/helmfile)                                                                                                                                                                                                                                                                                                                                                                                      |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md)   | A function that implements sourcing of helm charts to support rendering using declarative pipelines. This function augments [render-helm-chart](docs/render-helm-chart.md).                                                                                                                                                                                                                                                                                                                                          |

## Verifying Build Provenance

Function images are signed using Cosign and provenance can be verified
as e.g.:

```
export FUNCTION_IMAGE=ghcr.io/krm-functions/source-packages@sha256:5b63b6d52a9e72a59d6d6098d92975542daa9b79dbe11bc4fe36af7b8f2e4fdc
export BUILDER=https://github.com/krm-functions/catalog/.github/workflows/build.yaml

cosign verify --certificate-identity $BUILDER@refs/heads/main --certificate-oidc-issuer https://token.actions.githubusercontent.com $FUNCTION_IMAGE
```

See below for latest image digests and builders.

## Image Digests

| Function                                                                                            | Digest                                                                                                             | Builder |
| --------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)           | `ghcr.io/krm-functions/apply-setters@sha256:83229abce139675f6491399591e5fbdd54271e8de848af486e928eaef623ca2b`      | 1       |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                     | `ghcr.io/krm-functions/digester@sha256:e57c6f0f3df3ce1549169b597321887abf702f296f20693f8dfce150f17c50d6`           | 1       |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                           | `ghcr.io/krm-functions/gatekeeper@sha256:8c4524d8538e6d50842c3eec70c932672457189e09f2e10ee6616b9b74d867e6`         | 2       |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)           | `ghcr.io/krm-functions/helm-upgrader@sha256:f4281a146fa8a8decae36f6bff60d2aa5fd9d30294d6ad0b3f890c0f115d4618`      | 1       |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)               | `ghcr.io/krm-functions/kubeconform@sha256:459dff1f5026ba45fbb16ee88519875ce835dc147ac630da485ae3f809d9b0f2`        | 1       |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md)   | `ghcr.io/krm-functions/render-helm-chart@sha256:b80ada67979bc0651f92f001fd44501b0851f9b07dac10f453f4acde36eb7808`  | 1       |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md) | `ghcr.io/krm-functions/package-compositor@sha256:53c8452ed490b379b54067010697b436987ac984a7dc2f303a16ca59c7af7461` | 1       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md)   | `ghcr.io/krm-functions/source-helm-chart@sha256:17d717d90df96b5b82dda65507fd04303d1e9d1b5f21c691c14de04a1230a253`  | 1       |

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
