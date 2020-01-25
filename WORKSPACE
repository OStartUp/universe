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
####
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
    "@io_bazel_rules_docker//python3:image.bzl",
    _py_image_repos = "repositories",
)

_py_image_repos()


# load(
#     "@io_bazel_rules_docker//repositories:repositories.bzl",
#     container_repositories = "repositories",
# )
# container_repositories()

# # This is NOT needed when going through the language lang_image
# # "repositories" function(s).
# load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

# container_deps()

# load(
#     "@io_bazel_rules_docker//container:container.bzl",
#     "container_pull",
# )

# container_pull(
#   name = "java_base",
#   registry = "gcr.io",
#   repository = "distroless/java",
#   # 'tag' is also supported, but digest is encouraged for reproducibility.
#   digest = "sha256:deadbeef",
# )