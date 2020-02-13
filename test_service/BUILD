

package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    name = "test",
    helm_srcs = glob(["test-chart/**"]), 
    images = { "//test_service/src:test-image" : "marcecaro/test"}, 
    config_srcs = glob(["environments/**"]),
    update_deps = True,
    registry = DOCKER_REGISTRY_URL
    )