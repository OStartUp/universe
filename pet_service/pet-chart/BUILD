package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    name = "pet-application",
    helm_srcs = glob(["**"]), 
    images = [ "//pet_service/src:pet-image"], 
    config_srcs = "//pet_service/environments:config", 
    update_deps = True,
    repository = "marcecaro/pet",
    registry = DOCKER_REGISTRY_URL
    )


