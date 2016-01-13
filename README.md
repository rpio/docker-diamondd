Bitcoind for Docker
===================

Docker image that runs a diamondd node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 40 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on [Vultr 1024 MB RAM/320 GB disk instance @ $8/mo](http://bit.ly/vultrdiamondd).  Vultr also *accepts Bitcoin payments*!  May run on the 512 MB instance, but took *forever* (1+ week) to initialize due to swap and disk thrashing.


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/rpio/docker-diamondd/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `diamondd-data` volume to persist the diamondd blockchain data, should exit immediately.  The `diamondd-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker run --name=diamondd-data -v /diamond busybox chown 1000:1000 /diamond
        docker run --volumes-from=diamondd-data --name=diamondd-node -d \
            -p 17772:17772 \
            -p 127.0.0.1:17771:17771 \
            rpio/diamondd

2. Verify that the container is running and diamondd node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        rpio/diamondd:latest     "dmd_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:17771->17771/tcp, 0.0.0.0:17772->17772/tcp   diamondd-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f diamondd-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).
