# P4est_jll_bindings

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)

Generate and host Julia bindings for the
[p4est](https://github.com/cburstedde/p4est) library provided by P4est_jll.jl.
The contents of the
[P4est_jll_bindings](https://github.com/trixi-framework/P4est_jll_bindings)
repository are not immediately relevant for users of p4est in Julia. However,
the Julia wrapper package
[P4est.jl](https://github.com/trixi-framework/P4est.jl) uses the artifacts
attached to the releases of this repository to automatically retrieve
pre-generated Julia bindings. In general, we try to track the releases of
[P4est_jll.jl](https://github.com/JuliaBinaryWrappers/P4est_jll.jl) and thus use
the same version numbers to avoid confusion.

If you are just looking for the relevant `Artifacts.toml` entries to
automatically download the bindings, check out the
[Entries for Artifacts.toml](#entries-for-artifactstoml) section below.


## Procedure for creating a new bindings release
To use Julia scripts in this repository, you first need to install a few
dependencies by executing the following command in the repository folder:
```bash
julia --project=@. -e 'import Pkg; Pkg.instantiate()'
```
This step is only necessary once.

1. **Create new bindings**  
   Create a new bindings file, e.g., using the build process of P4est.jl with
   the environment variable `JULIA_P4EST_GENERATE_BINDINGS` set to `yes`.
2. **Create new bindings artifact**
   To create a new artifact for a given bindings file, run
   [`create_bindings_artifact.jl`](create_bindings_artifact.jl) as follows:
   ```bash
   julia --project=@. create_bindings_artifact.jl path/to/bindings.jl X.Y.Z
   ```
   Here, `X.Y.Z` should be the P4est_jll.jl release version
   (in [semver](https://semver.org) format) for which the bindings have been
   generated, e.g., `2.3.1`. This will create a new artifact file that can be
   attached as an asset to a new bindings release, e.g., `P4est.v2.3.1.tar.gz`.
3. **Generate entries for Artifacts.toml**  
   Note the *exact* release name of the P4est_jll.jl package for which the
   bindings have been generated. For example, for the p4est version `2.3.1`,
   they corresponding release name is `P4est-v2.3.1+0` (including the `+0`).
   Run the script [`generate_artifacts_toml.jl`](generate_artifacts_toml.jl) as
   ```bash
   julia --project=@. generate_artifacts_tom.jl RELASE_NAME
   ```
   where `RELEASE_NAME` is the noted release name. Use the output of the script
   to create a new entry in the
   [Entries for Artifacts.toml](#entries-for-artifactstoml) section below.
4. **Create a new release**  
   [Create a new release](https://github.com/trixi-framework/P4est_jll_bindings/releases/newhttps://github.com/trixi-framework/P4est_jll_bindings/releases/new)
   and use the release name from the previous step for both the `Tag version`
   and the `Release title`. At the bottom of the page, attach the newly create
   bindings release file, e.g., `P4est.v2.3.1.tar.gz`. Then, publish the
   release.


## Authors
P4est_jll_bindings was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
(University of Cologne, Germany) and
[Hendrik Ranocha](https://ranocha.de) (University of Münster, Germany).


## License
P4est_jll_bindings is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).


## Entries for Artifacts.toml

