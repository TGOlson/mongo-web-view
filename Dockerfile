FROM haskell:7.8

RUN cabal update

# Add .cabal file
ADD ./mongo-web-view.cabal /opt/mongo-web-view.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
RUN cd /opt && cabal install --only-dependencies -j4

# Add and Install Application Code
ADD ./ /opt
RUN cd /opt && cabal install

# Add installed cabal executables to PATH
ENV PATH /root/.cabal/bin:$PATH

# Default Command for Container
WORKDIR /opt
CMD ["mongo-web-view"]
