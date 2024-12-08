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
export FUNCTION_IMAGE=ghcr.io/krm-functions/source-packages@sha256:d1e43022c9615a400f2087d206d05d14a26a6885f844cdbfebdb649688973d71
export BUILDER=https://github.com/krm-functions/catalog/.github/workflows/build.yaml

cosign verify --certificate-identity $BUILDER@refs/heads/main --certificate-oidc-issuer https://token.actions.githubusercontent.com $FUNCTION_IMAGE
```

See below for latest image digests and builders.

## Image Digests

| Function                                                                                          | Digest                                                                                                            | Builder |
| ------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)         | `ghcr.io/krm-functions/apply-setters@sha256:18ecdb4940293d1ca1b46e144371d8575bf4c699bf4ad1c54d0b75138b83ef52`     | 1       |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                   | `ghcr.io/krm-functions/digester@sha256:8c2cac5e8301dfc573661d7cb0f8481bac5d6d2d4d9619a5942ccfb41cc52c44`          | 1       |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                         | `ghcr.io/krm-functions/gatekeeper@sha256:8c4524d8538e6d50842c3eec70c932672457189e09f2e10ee6616b9b74d867e6`        | 2       |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)         | `ghcr.io/krm-functions/helm-upgrader@sha256:1db6928926b1839c5ce89316c276dbfdfb3a55e05a1553d29b24530bddebc0d7`     | 1       |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)             | `ghcr.io/krm-functions/kubeconform@sha256:0a7b6c7e3925415784a34afa7eee06069bf57efc3b674bb2f4c7bc25eafc931d`       | 1       |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md) | `ghcr.io/krm-functions/render-helm-chart@sha256:43658c5171c70bd53c4bd8697fd1158aa27c19a652f2d8f9b8e7657178e3d30a` | 1       |
| [source-packages](https://github.com/krm-functions/catalog/blob/main/docs/source-packages.md)     | `ghcr.io/krm-functions/source-packages@sha256:d1e43022c9615a400f2087d206d05d14a26a6885f844cdbfebdb649688973d71`   | 1       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md) | `ghcr.io/krm-functions/source-helm-chart@sha256:1cf52c5bddf70f10ae55f8d5225a55e2e929db6d357c485af5e1ebf816afbcc5` | 1       |

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
