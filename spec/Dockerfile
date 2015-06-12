FROM haskell:7.8

RUN cabal update

# Add .cabal file
ADD spec.cabal ./code/spec.cabal

# Docker will cache this command as a layer, freeing us up to
# modify source code without re-installing dependencies
# RUN cd code/ && cabal install --only-dependencies -j4
RUN cd code/ && cabal install --only-dependencies

# Add and Install Application Code
ADD . /code
RUN cd code/ && cabal install
RUN cd code/ && cabal configure

# Add installed cabal executables to PATH
ENV PATH /root/.cabal/bin:$PATH

# Default Command for Container
WORKDIR /code
