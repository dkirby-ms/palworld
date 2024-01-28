#!/bin/bash
./steamcmd.sh +force_install_dir /data +login anonymous +app_update 2394010 +quit

/data/PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultiThreadForDS
