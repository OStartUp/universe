

package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    name = "echo",
    helm_srcs = glob(["echo-chart/**"]), 
    images = { "//echo_service/src:echo-image" : "marcecaro/echo"}, 
    config_srcs = glob(["environments/**"]),
    update_deps = True,
    registry = DOCKER_REGISTRY_URL
    )