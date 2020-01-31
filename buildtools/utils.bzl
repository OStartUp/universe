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
            "$ARTIFACT": ctx.file.zip_file.path
        },
  )

application_manifest = rule(
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
    application_manifest(
        name = name,
        zip_file = zip_file,
        template = "//buildtools:artifact.manifest.template"
        )


def gen_zip(srcs):
    artifact_manifest(name = "APPLICATION", zip_file = ":ZIP_ARTIFACT")
    pkg_zip(
        name = "ZIP_ARTIFACT",
        srcs = srcs #+ [":BUILDINFO"],
    )
    # native.genrule(
    #     name = "BUILDINFO",
    #     srcs = [],
    #     outs = ["build.txt"],
    #     cmd = "cat bazel-out/volatile-status.txt > $@ ; cat bazel-out/stable-status.txt >> $@ ",
    #     stamp = 1,
    # )

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


def application(name, helm_srcs, images, config_srcs, registry, update_deps):
    all_info = [(name, name.split(":")[-1]+"_PUSHER", images[name] ) for name in images.keys()]
    chart_name = name + "_CHART" 
    helm_chart(
        name = chart_name, 
        srcs = helm_srcs, # + [pusher for (_, pusher, _) in all_info],
        update_deps = update_deps,
    )

    sha256_list =[]
    for n, (image, pusher, repository) in enumerate(all_info):
        push(
            name = pusher,
            image = image, 
            repository = repository,
            registry = registry,
            )
        sha_name = "SHA256_" + str(n)
        sha256_list.append(sha_name)
        native.genrule(
            name = sha_name,
            srcs = [pusher],
            tools = [pusher],
            outs = ["sha256.yaml"],
            cmd = """
echo "sha256:" >> $@
for s in $(SRCS); do
    if [[ $$s = *digest* ]]
    then
        echo "    {repository}": $$(cat $$s) >> $@
    fi
done
""".format(repository=repository)        
)
    native.filegroup(
        name = "ENVIRONMENT_CONFIG",
        srcs = native.glob(config_srcs),
    )
    native.filegroup(
        name = "SHA256",
        srcs = sha256_list,
    )
    gen_zip(
        srcs = [
            ":"+chart_name,
            ":ENVIRONMENT_CONFIG", 
            ":SHA256",
        ],
    )