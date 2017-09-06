FROM debian:latest

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y apt-utils
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get -y clean && apt-get -y update && apt-get install -y mono-devel \
        mono-complete \
        libglib2.0-cil \
        git \
        nuget
RUN git clone https://github.com/willb611/SlimeSimulation.git
RUN (cd SlimeSimulation && sed -i".bak" '/<PreBuildEvent>/,/<\/PreBuildEvent>/d' SlimeSimulation/SlimeSimulation.csproj)
RUN (cd SlimeSimulation && rm SlimeSimulation/FodyWeavers.xml)
RUN (cd SlimeSimulation && sed -i".bak" '/Fody.1.29.4/,+1 d' SlimeSimulation/SlimeSimulation.csproj)
RUN (cd SlimeSimulation && sed -i".bak" '/Fody.1.29.4/,/<\/Target>/d' SlimeSimulation/SlimeSimulation.csproj)
RUN (cd SlimeSimulation && sed -i".bak" '/CleanReferenceCopyLocalPaths/,/<\/Target>/d' SlimeSimulation/SlimeSimulation.csproj)
RUN (cd SlimeSimulation && sed -i".bak" '/Fody/,+1 d' SlimeSimulation/packages.config)
RUN (cd SlimeSimulation && cp SlimeSimulation/NLog.release.config SlimeSimulation/NLog.config)
RUN (cd SlimeSimulation && nuget restore SlimeSimulation.sln)
RUN (cd SlimeSimulation && xbuild /p:Configuration=Release SlimeSimulation/SlimeSimulation.csproj)
#RUN (cd SlimeSimulation && git reset --hard && cp "SlimeSimulation/NLog.release.config" "SlimeSimulation/NLog.config")
#RUN apt-get purge -y nuget \
 #       git && apt-get autoremove -y

LABEL version="0.1"
LABEL description="Slime simulation"

CMD ["mono", "SlimeSimulation/SlimeSimulation/bin/Release/SlimeSimulation.exe"]