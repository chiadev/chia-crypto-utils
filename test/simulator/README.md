# Simulator

The Chia simulator can be used to write integration tests

## Building

```console
Irulast-MacBook-Pro:simulator irulastdev$ docker build . -t chia_sim
```

## Running

This starts the simulator running on port 5000 accessible from the host system.

```console
Irulast-MacBook-Pro:simulator irulastdev$ docker run -e TARGET_UID="$(id -u)" -e TARGET_GID="$(id -g)" -e CLIENT_CONFIG_DIR="/temp/config/" -p 5000:8555 -v "$(pwd)/temp/test-plots":/root/.chia/mainnet/test-plots -v "$(pwd)/temp/config:/temp/config" -it chia_sim:latest
```

The simulator can be interacted with from the host system.

```console
Irulast-MacBook-Pro:simulator irulastdev$ curl --insecure --cert temp/config/ssl/full_node/private_full_node.crt --key temp/config/ssl/full_node/private_full_node.key -d '{"address": "xch1jln3f7eg65s63khmartj0t6ufsamqnm4xqqzrm7z3t0lux5v6m4spe8ef6"}' -H "Content-Type: application/json" -X POST https://localhost:5000/farm_tx_block
```

```console
Irulast-MacBook-Pro:simulator irulastdev$ curl --insecure --cert temp/config/ssl/full_node/private_full_node.crt --key temp/config/ssl/full_node/private_full_node.key -d '{}' -H "Content-Type: application/json" -X POST https://localhost:5000/get_blockchain_state
```

## Debugging

List the running containers then exec into the container to interact with the local system.

```console
Irulast-MacBook-Pro:simulator irulastdev$ docker ps
CONTAINER ID   IMAGE             COMMAND             CREATED          STATUS          PORTS                                                                                 NAMES
0c929e41a294   chia_sim:latest   "docker-start.sh"   23 minutes ago   Up 23 minutes   3496/tcp, 8555/tcp, 55400/tcp, 58555/tcp, 0.0.0.0:5000->8444/tcp, :::5000->8444/tcp   nervous_blackwell

Irulast-MacBook-Pro:simulator irulastdev$ docker exec -it 0c929e41a294 bash
...

root@0c929e41a294:/chia-blockchain# curl --insecure --cert ~/.chia/mainnet/config/ssl/full_node/private_full_node.crt --key ~/.chia/mainnet/config/ssl/full_node/private_full_node.key -d '{"address": "xch1jln3f7eg65s63khmartj0t6ufsamqnm4xqqzrm7z3t0lux5v6m4spe8ef6"}' -H "Content-Type: application/json" -X POST https://localhost:8555/farm_tx_block

```

The following command overrides `docker-start.sh` allowing for exploration of the container environment.

```console
Irulast-MacBook-Pro:simulator irulastdev$ docker run -p 8555:8555 -v "$(pwd)/temp/chia_plots":/root/.chia/mainnet/test-plots -it chia_sim:latest bash
```