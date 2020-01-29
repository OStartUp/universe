package(default_visibility = ["//visibility:public"])
load("//buildtools:utils.bzl", "application")

DOCKER_REGISTRY_URL="index.docker.io"


application(
    helm_srcs = glob(["**"]), 
    images = [ "//echo_service/src:echo-image"], 
    config_srcs = "//echo_service/environments:config", 
    update_deps = True,
    repository = "marcecaro/echo",
    registry = DOCKER_REGISTRY_URL
    )
