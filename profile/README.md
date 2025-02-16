# KRM Functions

This purpose of this organisation is to provide generally usable
functions for operating on configuration-as-code using the Kubernetes
Resource Model (KRM) as defined in [KRM Functions
Specification](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md).

For a general introduction to using KRM functions see [Replacing Helm and Kustomize with KRM Functions — a New Approach to Configuration Management](https://medium.com/@michael.vittrup.larsen/replacing-helm-and-kustomize-with-krm-functions-a-new-approach-to-configuration-management-676212cc1332).

For an broader description on how to use and develop new KRM functions see [the kpt book](https://kpt.dev/book/).

Functions:

| Name                                                                                                | Description                                                                                                                                                                                                                                                                                                                                                                   |
| --------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| apply-replacements                                                                                  | Replace resource values with values read from other resources, see [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)                                                                                                                                                                                                                  |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)           | A re-implementation and improvement of the [baseline `apply-setters`](https://catalog.kpt.dev/apply-setters/v0.2/) function, which supports merge of multiple sources of apply-setters configuration and accepts configuration through both function-config and primary resource list. Also supports reading setter values from other resources.                              |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                     | A function that can lookup container image digests for Helm charts and write-back digests into chart values.                                                                                                                                                                                                                                                                  |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                           | A re-implementation of the [baseline `gatekeeper`](https://catalog.kpt.dev/gatekeeper/v0.2/) function, which suppors newer variants of the Rego language (e.g. as used in the [gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library)) and which support gatekeeper [expansions](https://open-policy-agent.github.io/gatekeeper/website/docs/expansion) |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)           | Function for automating upgrades of Helm chart specifications in e.g. KRM `RenderHelmChart` format. Supports upgrade constraints.                                                                                                                                                                                                                                             |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)               | Function for validating resource schemas. Replacement for `kubeval`.                                                                                                                                                                                                                                                                                                          |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md) | Declarative management and composition of fleets of `kpt` packages, similar to [helmfile](https://github.com/helmfile/helmfile)                                                                                                                                                                                                                                               |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md)   | A re-implementation of the [baseline `render-helm-chart`](https://catalog.kpt.dev/render-helm-chart/v0.2/) function, which can be used in [declarative pipelines](https://kpt.dev/book/04-using-functions/01-declarative-function-execution) through Kptfiles.                                                                                                                |
| [set-annotations](https://github.com/krm-functions/catalog/blob/main/docs/set-annotations.md)       | Set annotations on resources                                                                                                                                                                                                                                                                                                                                                  |
| [set-labels](https://github.com/krm-functions/catalog/blob/main/docs/set-labels.md)                 | Set labels on resources                                                                                                                                                                                                                                                                                                                                                       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md)   | A function that implements sourcing of helm charts to support rendering using declarative pipelines. This function augments [render-helm-chart](docs/render-helm-chart.md).                                                                                                                                                                                                   |
| [starlark](https://github.com/krm-functions/starlark)                                               | A function that allows writing custom resource manipulation using Starlark (a Python dialect)                                                                                                                                                                                                                                                                                 |

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
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)           | `ghcr.io/krm-functions/apply-setters@sha256:49d288e8ceb4d39fd42e45aae00615f916562274de0aa5cd56601b5b8f7aa238`      | 1       |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                     | `ghcr.io/krm-functions/digester@sha256:1ea21e382fc0985f76ec2b87d805c125c50f0ce4d31671275271c3fde073224f`           | 1       |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                           | `ghcr.io/krm-functions/gatekeeper@sha256:a1a1f57286f50805c571a968c4d2e91cb5dea39451313c5b0bdede1c65e38922`                                                                      | 2       |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)           | `ghcr.io/krm-functions/helm-upgrader@sha256:2ab8e3ffbe920b791772158cfad8afa51a7f4fb8a1c4631886ea33c32d1ddfde`      | 1       |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)               | `ghcr.io/krm-functions/kubeconform@sha256:38bdfb40c787d88315f884b46075bb4d30efca81244492199eefd654e2f8ce1f`        | 1       |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md) | `ghcr.io/krm-functions/package-compositor@sha256:1ebd44de8945ab04758db2784d60ddbfb9634ed723b94e3fde7a5eac3436d681` | 1       |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md)   | `ghcr.io/krm-functions/render-helm-chart@sha256:9fe0be6cc585c29f115720fb532b31facf9bf4f14f1346c320da4ef2a19c8145`  | 1       |
| [set-annotations](https://github.com/krm-functions/catalog/blob/main/docs/set-annotations.md)       | `ghcr.io/krm-functions/set-annotations@sha256:5cb3052f79fdb537f2fb60ff95a86602dea8b55f1e358c01279503c694a561dd`    | 1       |
| [set-labels](https://github.com/krm-functions/catalog/blob/main/docs/set-labels.md)                 | `ghcr.io/krm-functions/set-labels@sha256:07f852ce40db665a4ce91b60dbac626b11298e8eae11dea0630ace0d07409f23`         | 1       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md)   | `ghcr.io/krm-functions/source-helm-chart@sha256:30284789798a75a9e92bcc59519938c9a4e0dbc84ccaa4e43256f6ace8fc1672`  | 1       |
| [starlark](https://github.com/krm-functions/starlark)                                               | `ghcr.io/krm-functions/starlark@sha256:2561824f4766eb35d2f31eb300c4dae0c6e0c1156bd7b37822d85850d984c2f7`           | 3       |

Builders:

```
1: https://github.com/krm-functions/catalog/.github/workflows/build.yaml
2: https://github.com/krm-functions/gatekeeper/.github/workflows/build.yaml
3: https://github.com/krm-functions/starlark/.github/workflows/build.yaml
```

## Links

The following are references to other KRM functions. These functions
are not associated with this `krm-functions` organization.

- [kispaljr/krm-functions](https://github.com/kispaljr/krm-functions)
- [Nephio project](https://github.com/nephio-project/nephio/tree/main/krm-functions)
- [bluebrown/krm-filter](https://github.com/bluebrown/krm-filter)

Generally there is also several functions available as 'kustomize plugins'.
