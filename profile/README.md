# KRM Functions

This purpose of this organisation is to provide generally usable
functions for operating on configuration-as-code using the Kubernetes
Resource Model (KRM) as defined in [KRM Functions
Specification](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md).

For a general introduction to using KRM functions see [Replacing Helm and Kustomize with KRM Functions — a New Approach to Configuration Management](https://medium.com/@michael.vittrup.larsen/replacing-helm-and-kustomize-with-krm-functions-a-new-approach-to-configuration-management-676212cc1332).

For an broader description on how to use and develop new KRM functions see [the kpt book](https://kpt.dev/book/).

Functions:

| Name | Description |
| ---- | ----------- |
| [helm-upgrader](docs/helm-upgrader.md) | Function for automating upgrades of Helm chart specifications in e.g. KRM `RenderHelmChart` format. Supports upgrade constraints. |
| [render-helm-chart](docs/render-helm-chart.md) | A re-implementation of the [baseline `render-helm-chart`](https://catalog.kpt.dev/render-helm-chart/v0.2/) function, which can be used in [declarative pipelines](https://kpt.dev/book/04-using-functions/01-declarative-function-execution) through Kptfiles. :warning: note, this function is dual purpose, it can both source and render charts. The sourcing feature is deprecated - use the [source-helm-chart](docs/source-helm-chart.md) for this instead. |
| [source-helm-chart](docs/source-helm-chart.md) | A function that implements sourcing of helm charts to support rendering using declarative pipelines. This function augments [render-helm-chart](docs/render-helm-chart.md). |
| [apply-setters](docs/apply-setters.md) | A re-implementation and improvement of the [baseline `apply-setters`](https://catalog.kpt.dev/apply-setters/v0.2/) function, which supports merge of multiple sources of apply-setters configuration and accepts configuration through both function-config and primary resource list. Also supports reading setter values from other resources. |
| [gatekeeper](https://github.com/krm-functions/gatekeeper) | A re-implementation of the [baseline `gatekeeper`](https://catalog.kpt.dev/gatekeeper/v0.2/) function, which suppors newer variants of the Rego language (e.g. as used in the [gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library)) and which support gatekeeper [expansions](https://open-policy-agent.github.io/gatekeeper/website/docs/expansion) |
| [digester](docs/digester.md) | A function that can lookup container image digests for Helm charts and write-back digests into chart values. |
