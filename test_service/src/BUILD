package(default_visibility = ["//visibility:public"]) 
load("//buildtools:utils.bzl", "push")
load("@io_bazel_rules_docker//python3:image.bzl", "py3_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@my_deps//:requirements.bzl", "requirement")

py3_image(
    name = "test-image",
    srcs = ["test.py"],
    main = "test.py",
    layers = [ ## Is like , but layered
            requirement("flask"),
            requirement("jinja2"),
            requirement("markupsafe"),
            requirement("werkzeug"),
            requirement("itsdangerous"),
            requirement("click"),
            
          ],
    data = [ "BUILD"],
)


