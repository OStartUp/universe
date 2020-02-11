#https://www.python.org/ftp/python/3.7.6/Python-3.7.6.tgz
package(default_visibility = ["//visibility:public"]) 


filegroup(
    name = "srcs_logger",
    srcs = ["BUILD"] + ["logger.py", "pretify.py"],
)

py_library(
    name = "logger",
    srcs = [":srcs_logger"],
    srcs_version = "PY3",
    deps = ["//configlib:config"],
)

filegroup(
    name = "srcs_dummy",
    srcs = ["BUILD"] + ["dummy.py"],
)

py_test(
    name = "test_logger",
    srcs = ["test/test_logger.py", "logger.py", "pretify.py"], 
    deps = ["//configlib:config"], 
)

py_test(
    name = "test_pretify",
    srcs = ["test/test_pretify.py", "pretify.py"],
)



py_binary(
    name = "dummy",
    srcs = [":srcs_dummy"],
    srcs_version = "PY3",
    deps = [":logger"], 
)

# test_suite(
#     name = "test_all_logger",
#     tests = [
#         "test_pretify",
#         "test_logger",
#     ],
# )


# config_pkg
# config-wheel
# config