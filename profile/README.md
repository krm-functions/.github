# KRM Functions

This purpose of this organisation is to provide generally usable
functions for operating on configuration-as-code using the Kubernetes
Resource Model (KRM) as defined in [KRM Functions
Specification](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md).

For a general introduction to using KRM functions see [Replacing Helm and Kustomize with KRM Functions — a New Approach to Configuration Management](https://medium.com/@michael.vittrup.larsen/replacing-helm-and-kustomize-with-krm-functions-a-new-approach-to-configuration-management-676212cc1332).

For an broader description on how to use and develop new KRM functions see [the kpt book](https://kpt.dev/book/).

Functions:

| Name                                                                                                                      | Description                                                                                                                                                                                                                                                                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| apply-replacements                                                                                                        | Replace resource values with values read from other resources, see [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)                                                                                                                                                                                                                  |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)                                 | A re-implementation and improvement of the [baseline `apply-setters`](https://catalog.kpt.dev/apply-setters/v0.2/) function, which supports merge of multiple sources of apply-setters configuration and accepts configuration through both function-config and primary resource list. Also supports reading setter values from other resources.                              |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                                           | A function that can lookup container image digests for Helm charts and write-back digests into chart values.                                                                                                                                                                                                                                                                  |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                                                 | A re-implementation of the [baseline `gatekeeper`](https://catalog.kpt.dev/gatekeeper/v0.2/) function, which suppors newer variants of the Rego language (e.g. as used in the [gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library)) and which support gatekeeper [expansions](https://open-policy-agent.github.io/gatekeeper/website/docs/expansion) |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)                                 | Function for automating upgrades of Helm chart specifications in e.g. KRM `RenderHelmChart` format. Supports upgrade constraints.                                                                                                                                                                                                                                             |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)                                     | Function for validating resource schemas. Replacement for `kubeval`.                                                                                                                                                                                                                                                                                                          |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md)                       | Declarative management and composition of fleets of `kpt` packages, similar to [helmfile](https://github.com/helmfile/helmfile)                                                                                                                                                                                                                                               |
| [remove-local-config-resources](https://github.com/krm-functions/catalog/blob/main/docs/remove-local-config-resources.md) | Remove resources that are only intended as local function configutation                                                                                                                                                                                                                                                                                                       |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md)                         | A re-implementation of the [baseline `render-helm-chart`](https://catalog.kpt.dev/render-helm-chart/v0.2/) function, which can be used in [declarative pipelines](https://kpt.dev/book/04-using-functions/01-declarative-function-execution) through Kptfiles.                                                                                                                |
| [set-annotations](https://github.com/krm-functions/catalog/blob/main/docs/set-annotations.md)                             | Set annotations on resources                                                                                                                                                                                                                                                                                                                                                  |
| [set-labels](https://github.com/krm-functions/catalog/blob/main/docs/set-labels.md)                                       | Set labels on resources                                                                                                                                                                                                                                                                                                                                                       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md)                         | A function that implements sourcing of helm charts to support rendering using declarative pipelines. This function augments [render-helm-chart](docs/render-helm-chart.md).                                                                                                                                                                                                   |
| [starlark](https://github.com/krm-functions/starlark)                                                                     | A function that allows writing custom resource manipulation using Starlark (a Python dialect)                                                                                                                                                                                                                                                                                 |

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

| Function                                                                                                                  | Digest                                                                                                             | Builder |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------ | ------- |
| [apply-setters](https://github.com/krm-functions/catalog/blob/main/docs/apply-setters.md)                                 | `ghcr.io/krm-functions/apply-setters@sha256:c62bd0fdbd0123b37bb9718b17be46af5122135649ffe0f04b4dd053a5636c13`      | 1       |
| [digester](https://github.com/krm-functions/catalog/blob/main/docs/digester.md)                                           | `ghcr.io/krm-functions/digester@sha256:9a5dbd530cfdcff09dc0088719bc3fbd6a3e610148419ddd793106a28398da3b`           | 1       |
| [gatekeeper](https://github.com/krm-functions/gatekeeper)                                                                 | `ghcr.io/krm-functions/gatekeeper@sha256:a1a1f57286f50805c571a968c4d2e91cb5dea39451313c5b0bdede1c65e38922`         | 2       |
| [helm-upgrader](https://github.com/krm-functions/catalog/blob/main/docs/helm-upgrader.md)                                 | `ghcr.io/krm-functions/helm-upgrader@sha256:cd28b5a163b9c9a8126d8192749ac023729217372acef98bec32f7ed0d19516c`      | 1       |
| [kubeconform](https://github.com/krm-functions/catalog/blob/main/docs/kubeconform.md)                                     | `ghcr.io/krm-functions/kubeconform@sha256:2a992e13491a32c5b4c8525b20a9de47de1f342599c1a7ab80168de526d60e4c`        | 1       |
| [package-compositor](https://github.com/krm-functions/catalog/blob/main/docs/package-compositor.md)                       | `ghcr.io/krm-functions/package-compositor@sha256:ce99dce59fb669c989c7636549ac413df209bf36f498d22b29288db9471b0be3` | 1       |
| [remove-local-config-resources](https://github.com/krm-functions/catalog/blob/main/docs/remove-local-config-resources.md) | `ghcr.io/krm-functions/remove-local-config-resources@sha256:6a47d6ebcf626e1666e0a301ff7be0b6b3997edce60d729b3c9a576464f34d6d`                                                 | 1       |
| [render-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/render-helm-chart.md)                         | `ghcr.io/krm-functions/render-helm-chart@sha256:3a9bb178644939a651902b0cfe3f74df0a7533ffbbcf8769983d8ed3ba763bcd`  | 1       |
| [set-annotations](https://github.com/krm-functions/catalog/blob/main/docs/set-annotations.md)                             | `ghcr.io/krm-functions/set-annotations@sha256:d7a6e7090aad1179b7c713d1a6aa8fbdee1523b651e198b2357c6c854e3f519b`    | 1       |
| [set-labels](https://github.com/krm-functions/catalog/blob/main/docs/set-labels.md)                                       | `ghcr.io/krm-functions/set-labels@sha256:1ea1c0a48988bdae3cf0248d83e9551d714b258e4b95aedf4ce6ac0fd6f90ff2`         | 1       |
| [source-helm-chart](https://github.com/krm-functions/catalog/blob/main/docs/source-helm-chart.md)                         | `ghcr.io/krm-functions/source-helm-chart@sha256:2d4a075df6104e83b9604a8b2ddad5e7c082dbabcdbd3f64e98c67f48897357a`  | 1       |
| [starlark](https://github.com/krm-functions/starlark)                                                                     | `ghcr.io/krm-functions/starlark@sha256:c90afc8fef427f768afdaaced5927f350fb60d866efb29caf42514fa11b89315`           | 3       |

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
