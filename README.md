# Run Slime simulation as docker (Unix)
Please note this is quite a bloated installation due to mono-complete (0.8GB) :(
##Start docker
``` sudo docker service start ```

##Build it
```sudo docker build . -t slimesim:latest```


##Run the application
```
sudo docker run -it \
    --user=$USER \
    --env="DISPLAY" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    slimesim
```