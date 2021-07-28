## 1. Lanzar dbt desde versión debug local

Debian:

```bash
docker run --rm -v $(pwd):/usr/app -v $(pwd):/root/.dbt fishtownanalytics/dbt:0.19.0 deps
docker run --rm -v $(pwd):/usr/app -v $(pwd):/root/.dbt fishtownanalytics/dbt:0.19.0 compile -- opcional (interesante para debugging)
docker run --rm -v $(pwd):/usr/app -v $(pwd):/root/.dbt fishtownanalytics/dbt:0.19.0 run
docker run --rm -v $(pwd):/usr/app -v $(pwd):/root/.dbt fishtownanalytics/dbt:0.19.0 test
docker run --rm -v $(pwd):/usr/app -v $(pwd):/root/.dbt fishtownanalytics/dbt:0.19.0 docs generate
docker run --rm -ip 8080:8080 -v $(pwd):/usr/app -v $(pwd)/:/root/.dbt fishtownanalytics/dbt:0.19.0 docs serve
docker run --rm -ip 8080:8080 -v $(pwd):/usr/app -v $(pwd)/:/root/.dbt fishtownanalytics/dbt:0.19.0 clean
```
