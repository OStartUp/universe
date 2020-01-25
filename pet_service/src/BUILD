package(default_visibility = ["//visibility:public"]) 

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load(
    "@io_bazel_rules_docker//python:image.bzl",
    _py_image_repos = "repositories",
)

_py_image_repos()


load("@io_bazel_rules_docker//python:image.bzl", "py3_image")

py3_image(
    name = "echo_service",
    srcs = [":echo_service.py"],
    deps = ["//configlib:config", "//loggerlib:logger"],
    #main = "py_image.py",
)