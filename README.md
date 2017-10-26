# Run Slime simulation as docker (Unix)
Please note this is quite a bloated installation due to mono-complete (0.8GB) :(
## This is broken
It's broken because I added some stuff to build an .exe and put everything into that, allowing me to copy/paste the exe around and run it from whichever folder on my windows laptop.
Please see the [actual slime simulation code repository](https://github.com/willb611/SlimeSimulation).

## Start docker
``` sudo service docker start ```

## Build it
```sudo docker build -t slimesim:latest .```


## Run the application
```
sudo docker run -it --rm \
    --user=$USER \
    --env="DISPLAY" \
    --volume="/etc/group:/etc/group:ro" \
    --volume="/etc/passwd:/etc/passwd:ro" \
    --volume="/etc/shadow:/etc/shadow:ro" \
    --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    slimesim
```