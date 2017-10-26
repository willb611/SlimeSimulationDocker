FROM debian:wheezy

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian wheezy main" | tee /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y apt-utils
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-apache24-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN echo "deb http://download.mono-project.com/repo/debian wheezy-libjpeg62-compat main" | tee -a /etc/apt/sources.list.d/mono-xamarin.list
RUN apt-get -y clean && apt-get -y update && apt-get install -y mono-devel \
        mono-complete \
        libglib2.0-cil \
        git
RUN git clone https://github.com/willb611/SlimeSimulation.git
RUN apt-get install -y nuget
RUN nuget restore SlimeSimulation/SlimeSimulation.sln
RUN xbuild /p:Configuration=Release SlimeSimulation/SlimeSimulation/SlimeSimulation.csproj
RUN apt-get purge -y nuget \
        git && apt-get autoremove -y

LABEL version="0.1"
LABEL description="Slime simulation"

CMD ["mono", "SlimeSimulation/SlimeSimulation/bin/Release/SlimeSimulation.exe"]