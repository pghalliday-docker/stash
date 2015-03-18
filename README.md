# stash

To build

```
docker build --rm --tag=pghalliday/stash .
```

To run

```
docker run -p 0.0.0.0:7990:7990 -p 0.0.0.0:7999:7999 -i -t pghalliday/stash
```

Map the following volume to persist stash data

```
/var/atlassian/application-data/stash 
```
