# Run Slime simulation as docker (Unix)
Please note this is quite a bloated installation due to mono-complete (0.8GB) :(
##Start docker
``` sudo service docker start ```

##Build it
```sudo docker build -t slimesim:latest .```


##Run the application
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

Fails due to windows vs Unix PreBuildEvent.
For now removed the prevent, and manually copying the nlog release file.
However issue on build due to a bug in Fody.
If the build is updated to use Fody 1.29.0-beta01 it fixes one bug, but then another one occurs. See discussion at:  [Issue 177](https://github.com/Fody/Fody/issues/177) seems unfixed, and a bug in mono. Only solution would be to somehow remove fody/costura target during build.

Removed Fody from the build process. Now fails due to missing configuration in Nlog when Logger.GetCurrentClassLogger() is called.