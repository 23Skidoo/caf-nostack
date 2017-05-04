How to reproduce:

1. `cabal new-configure --enable-profiling`
1. `cabal new-build`
1. `./dist-newstyle/.../caf-nostack`
1. `./dist-newstyle/.../caf-nostack +RTS -xc`
