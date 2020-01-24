#https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
package(default_visibility = ["//visibility:public"]) 

load("@my_deps//:requirements.bzl", "requirement")
load("@rules_python//experimental/python:wheel.bzl", "py_package", "py_wheel")

py_library(
    name = "config",
    srcs = [":srcs"],
    deps = [requirement("ruamel.yaml")]
)

##IMPORTANT Making BUILD as part of the dependencies for py_library
filegroup(
    name = "srcs",
    srcs = ["BUILD"] + glob(["**/*.py"]),
)

py_test(
    name = "test_config",
    srcs = ["test/test_config.py"],
    deps = [":config"],
    imports = [":config"]
)

py_test(
    name = "test_utils",
    srcs = ["test/test_utils.py"],
    deps = [":config"],
    imports = [":config"]
)


test_suite(
    name = "all_tests",
    tests = [
        "test_config",
        "test_utils",
    ],
)

## ---------------
# Example creating a wheel
## -------------------------
# py_package(
#     name = "config_pkg",
#     # Only include these Python packages.
#     packages = ["config"],  ## packages
#     deps = [":config"],
# )

# py_wheel(
#     name = "config-wheel",
#     # Package data. We're building "example_minimal_package-0.0.1-py3-none-any.whl"
#     distribution = "config-wheel",
#     python_tag = "py3",
#     version = "0.0.1",
#     deps = [":config_pkg"],
# )