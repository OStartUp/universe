load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_python",
    remote = "https://github.com/bazelbuild/rules_python.git",
    commit = "38f86fb55b698c51e8510c807489c9f4e047480e",
)

load("@rules_python//python:repositories.bzl", "py_repositories")
py_repositories()
# Only needed if using the packaging rules.
load("@rules_python//python:pip.bzl", "pip_repositories")
pip_repositories()

load("@rules_python//python:pip.bzl", "pip3_import")
pip3_import(   # or pip3_import
   name = "my_deps",
   requirements = ":requirements.txt",
)

load("@my_deps//:requirements.bzl", "pip_install")
pip_install()


####
#### Docker
#### https://github.com/bazelbuild/rules_docker/blob/master/README.md#setup
#### 

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# Download the rules_docker repository at release v0.14.1
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "dc97fccceacd4c6be14e800b2a00693d5e8d07f69ee187babfd04a80a9f8e250",
    strip_prefix = "rules_docker-0.14.1",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.14.1/rules_docker-v0.14.1.tar.gz"],
)



load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
container_repositories()

# This is NOT needed when going through the language lang_image
# "repositories" function(s).
#load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")
#container_deps()

load(
    "@io_bazel_rules_docker//container:container.bzl",
    "container_pull",
)

container_pull(
  name = "python3_base",
  registry = "gcr.io",
  repository = "distroless/java",
  # 'tag' is also supported, but digest is encouraged for reproducibility.
  digest = "sha256:deadbeef",
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")
container_repositories()

load("@io_bazel_rules_docker//python3:image.bzl", _py_image_repos = "repositories")
_py_image_repos()


### 
### Kubernetes
### 

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# This requires rules_docker to be fully instantiated before
# it is pulled in.
# Download the rules_k8s repository at release v0.3.1
http_archive(
    name = "io_bazel_rules_k8s",
    #sha256 = "cc75cf0d86312e1327d226e980efd3599704e01099b58b3c2fc4efe5e321fcd9",
    strip_prefix = "rules_k8s-0.4",
    urls = ["https://github.com/bazelbuild/rules_k8s/releases/download/v0.4/rules_k8s-v0.4.tar.gz"],
)

load("@io_bazel_rules_k8s//k8s:k8s.bzl", "k8s_repositories", "k8s_defaults")
load("@io_bazel_rules_k8s//k8s:k8s_go_deps.bzl", k8s_go_deps = "deps")

k8s_repositories()
k8s_go_deps()

##
## Kubernetes Defaults
## 

_CLUSTER = "kind-kind"
_CONTEXT = "kind-kind"
_NAMESPACE = "default"

k8s_defaults(
    name = "k8s_object",
    cluster = _CLUSTER,
    context = _CONTEXT,
    image_chroot = "index.docker.io",
    namespace = _NAMESPACE,
)


# k8s_defaults(
#     name = "k8s_deploy",
#     cluster = _CLUSTER,
#     context = _CONTEXT,
#     image_chroot = "localhost:5000/pet",  #"us.gcr.io/rules_k8s/{BUILD_USER}",
#     kind = "deployment",
#     namespace = _NAMESPACE,
# )

[k8s_defaults(
    name = "k8s_" + kind,
    cluster = _CLUSTER,
    context = _CONTEXT,
    kind = kind,
    namespace = _NAMESPACE,
    image_chroot = "index.docker.io",
) for kind in [
    "service",
    "crd",
    "todo",
]]

###
### Helm
###

# git_repository(
#     name = "com_github_tmc_rules_helm",
#     tag = "0.4.0",
#     remote = "https://github.com/marcecaro/rules_helm.git",
# )

local_repository(
    name = "com_github_tmc_rules_helm",
    path = "/home/appsadm/workbench/OpenStartUp/rules_helm",
)

load("@com_github_tmc_rules_helm//:repos.bzl", "helm_repositories")
helm_repositories()


http_archive(
    name = "rules_pkg",
    url = "https://github.com/bazelbuild/rules_pkg/releases/download/0.2.4/rules_pkg-0.2.4.tar.gz",
    sha256 = "4ba8f4ab0ff85f2484287ab06c0d871dcb31cc54d439457d28fd4ae14b18450a",
)
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()
