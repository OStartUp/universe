package(default_visibility = ["//visibility:public"]) 



load("@io_bazel_rules_docker//python3:image.bzl", "py3_image")
load("@io_bazel_rules_docker//docker:docker.bzl", "docker_push")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@my_deps//:requirements.bzl", "requirement")

py3_image(
    name = "echo-image",
    srcs = ["echo.py"],
    main = "echo.py",
    layers = [ ## Is like deps, but layered
            "//configlib:config", "//loggerlib:logger",
            requirement("flask"),
            requirement("jinja2"),
            requirement("markupsafe"),
            requirement("werkzeug"),
            requirement("itsdangerous"),
            requirement("click"),
            
          ],
    data = [ "BUILD"],
)

container_test(
    name = "StructureTests",
    image = ":echo-image",
    configs = [":tests/structure.yaml"]
)

DOCKER_REGISTRY_URL="index.docker.io"

## Optional
docker_push(
    name = "echo-push",
    image = ":echo-image",
    registry = DOCKER_REGISTRY_URL,
    repository = "marcecaro/echo",
    tag = "{STABLE_GIT_COMMIT}",
)
