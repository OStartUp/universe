

package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    name = "weave",
    helm_srcs = glob(["weave-chart/**"]), 
    images = { }, 
    config_srcs = glob(["environments/**"]),
    update_deps = True,
    registry = DOCKER_REGISTRY_URL
    )