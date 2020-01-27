package(default_visibility = ["//visibility:public"]) 



load("@io_bazel_rules_docker//python3:image.bzl", "py3_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@my_deps//:requirements.bzl", "requirement")

py3_image(
    name = "echo_service",
    srcs = ["echo.py"],
    main = "echo.py",
    layers = [ ## Is like deps, but layered
            "//configlib:config", "//loggerlib:logger",
            requirement("flask")
          ],
    data = [ "BUILD"],
)

container_test(
    name = "StructureTests",
    image = ":echo_service",
    configs = [":tests/structure.yaml"]
)