#https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
package(default_visibility = ["//visibility:public"]) 


filegroup(
    name = "srcs_logger",
    srcs = ["BUILD"] + ["logger.py"],
)

py_library(
    name = "logger",
    srcs = [":srcs_logger"],
    srcs_version = "PY3",
    imports= ["config"],
    deps = ["//configlib/src:config"],
)


filegroup(
    name = "srcs_dummy",
    srcs = ["BUILD"] + ["dummy.py"],
)


py_binary(
    name = "dummy",
    srcs = [":srcs_dummy"],
    srcs_version = "PY3",
    imports= ["config"],
    deps = [":logger", "//configlib/src:config"], 
)

# config_pkg
# config-wheel
# config