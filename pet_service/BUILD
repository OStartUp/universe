

package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    name = "pet",
    helm_srcs = glob(["pet-chart/**"]), 
    images = [ "//pet_service/src:pet-image"], 
    config_srcs = glob(["environments/**"]),
    update_deps = True,
    repository = "marcecaro/pet",
    registry = DOCKER_REGISTRY_URL
    )