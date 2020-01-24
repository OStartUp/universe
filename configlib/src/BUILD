#https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
package(default_visibility = ["//visibility:public"]) 

load("@my_deps//:requirements.bzl", "requirement")
load("@rules_python//experimental/python:wheel.bzl", "py_package", "py_wheel")

py_library(
    name = "config",
    srcs = ["config.py", "__init__.py"],
    deps = [requirement("ruamel.yaml")]
)

# filegroup(
#     name = "srcs",
#     srcs = ["BUILD"] + glob(["**/*.py"]),
# )



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