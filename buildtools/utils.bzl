load("@com_github_tmc_rules_helm//helm:helm.bzl", "helm_chart")
load("@io_bazel_rules_docker//docker:docker.bzl", "docker_push")
load("@rules_pkg//:pkg.bzl", "pkg_zip")

def expand_template_impl(ctx):
    ctx.actions.expand_template(
        template = ctx.file.template,
        output = ctx.outputs.out,
        substitutions = {
            k: ctx.expand_location(v, ctx.attr.data)
            for k, v in ctx.attr.substitutions.items()
        },
        is_executable = ctx.attr.is_executable,
    )

expand_template = rule(
    implementation = expand_template_impl,
    attrs = {
        "template": attr.label(mandatory = True, allow_single_file = True),
        "substitutions": attr.string_dict(mandatory = True),
        "out": attr.output(mandatory = True),
        "is_executable": attr.bool(default = False, mandatory = False),
        "data": attr.label_list(allow_files = True),
    },
)


def artifact_manifest_impl(ctx):
    ctx.actions.expand_template(
        template =  ctx.file.template ,
        output = ctx.outputs.manifest,
        substitutions = {
            "$ARTIFACT": ctx.file.zip_file.short_path
        },
  )

_artifact_manifest = rule(
    implementation = artifact_manifest_impl,
    attrs = {
        "zip_file": attr.label(allow_single_file = True),
        # "out": attr.output(mandatory = True),
        "template": attr.label(mandatory = True, allow_single_file = True),
    },
    outputs = {
        "manifest": "%{name}.manifest",
    }
)


def artifact_manifest(name, zip_file):
    _artifact_manifest(
        name = name,
        zip_file = zip_file,
        template = "//buildtools:artifact.manifest.template"
        )


def publish_service(srcs):
    artifact_manifest(name = "APPLICATION", zip_file = ":ARTIFACT")
    pkg_zip(
        name = "ARTIFACT",
        srcs = srcs + [":BUILDINFO"],
    )
    native.genrule(
        name = "BUILDINFO",
        srcs = [],
        outs = ["build.txt"],
        cmd = "cat bazel-out/volatile-status.txt > $@ ; cat bazel-out/stable-status.txt >> $@ ",
        stamp = 1,
    )


####
####
####

def push(name, image, repository, registry):
    docker_push(
        name = name,
        image = image,
        registry = registry,
        repository = repository,
        tag = "{STABLE_GIT_COMMIT}",
    )

def application(helm_srcs, images, config_srcs, repository, registry, update_deps):
    
    pushers = [name.split(":")[-1]+"_PUSHER" for i, name in enumerate(images)]

    for image, pusher in zip(images, pushers):
        push(
            name = pusher,
            image = image, 
            repository = repository,
            registry = registry,
            )

    helm_chart(
        name = "CHART",
        srcs = helm_srcs + pushers,
        update_deps = update_deps,
    )

    publish_service(
        srcs = [
            ":CHART",
            config_srcs, 
        ],
    )