# universe
Load all Service to crete a Bazel universe

```
docker login  <-  marcecaro
```

```
curl -v localhost:8001/api/v1/namespaces/echo/services/echo/proxy/
curl -v localhost:8001/api/v1/namespaces/pet/services/pet/proxy/
kubectl logs -l app=echo-deploy
./deploy_impacted 
./test_impacted 
```


```
./generate_deps  -> Generate deps graphics
./get_all        -> Get all target by label
./get_impacted   -> Get all target impacted by current changes
./get_kind_impacted   -> Get all target impacted by current changes, filtered by kind (i.e: ./get_kind_impacted binary)
```

All tests vs impacted tests:
```
./get_all |grep py_test
./get_kind_impacted test
```

Usefull queries:
```
bazel query "kind(binary, rdeps(//..., {file}))" 
bazel query "rdeps(//..., {file})" 
```

Examples:
```
bazel query "kind(rule,rdeps(//..., //configlib:utils.py))"  --output label_kind
```

