load("@rules_pkg//:pkg.bzl", "pkg_zip")

genrule(
    name = "buildinfo",
    srcs = [],
    outs = ["build.txt"],
    cmd = "cat bazel-out/volatile-status.txt > $@ ; cat bazel-out/stable-status.txt >> $@ ",
    stamp = 1,
)

pkg_zip(
    name = "pet-artifact",
    srcs = [
        "//pet_service/pet-chart:chart",
        "//pet_service/environments:config",
        ":buildinfo"
    ],
)


