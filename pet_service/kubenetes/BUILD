
package(default_visibility = ["//visibility:public"])
# load("@io_bazel_rules_k8s//k8s:object.bzl", "k8s_object")
load("@io_bazel_rules_k8s//k8s:objects.bzl", "k8s_objects")
load("@k8s_object//:defaults.bzl", "k8s_object")


## https://github.com/bazelbuild/rules_k8s
## https://github.com/bazelbuild/rules_k8s/tree/master/examples
## https://github.com/bazelbuild/rules_k8s/tree/master/examples/hellogrpc


k8s_object(
  name = "pet-deploy",
  kind = "deployment",

  # A template of a Kubernetes Deployment object yaml.
  ## https://docs.bazel.build/versions/master/skylark/lib/actions.html#expand_template
  template = ":deployment.yaml",

  # An optional collection of docker_build images to publish
  # when this target is bazel run.  The digest of the published
  # image is substituted as a part of the resolution process.
  images = {
    "marcecaro/echo:latest": "//pet_service/src:echo_image",
  },

#   substitutions = {
#                 "gcr.io/pet/echo:latest": "$(make_expanded_variable}",
#             },
)

k8s_object(
  name = "pet-service",
  kind = "service",
  template = ":service.yaml",
)

k8s_objects(
   name = "pet",
   objects = [
      ":pet-deploy",
      ":pet-service",
   ]
)

# _run_all rule //pet_service/kubenetes:service.replace
# _run_all rule //pet_service/kubenetes:service.delete
# _run_all rule //pet_service/kubenetes:service.create
# _run_all rule //pet_service/kubenetes:service.apply
# _run_all rule //pet_service/kubenetes:service


# bazel build //pet_service/kubenetes:service

# bazel run //pet_service/kubenetes:pet.apply