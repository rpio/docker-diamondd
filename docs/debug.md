# Debugging

## Things to Check

* RAM utilization -- diamondd is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The diamond blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing diamondd Logs

    docker logs diamondd-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the diamondd node, but will not connect to already running containers or processes.

    docker run --volumes-from=diamondd-data --rm -it rpio/diamondd bash -l
