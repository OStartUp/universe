

package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    name = "reflector",
    helm_srcs = glob(["reflector-chart/**"]), 
    images = { "//reflector_service/src:reflector-image" : "marcecaro/reflector"}, 
    config_srcs = glob(["environments/**"]),
    update_deps = True,
    registry = DOCKER_REGISTRY_URL
    )