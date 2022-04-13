# P4est_jll_bindings

[![License: MIT](https://img.shields.io/badge/License-MIT-success.svg)](https://opensource.org/licenses/MIT)

Generate and host Julia bindings for the
[p4est](https://github.com/cburstedde/p4est) library provided by
[P4est_jll.jl](https://github.com/JuliaBinaryWrappers/P4est_jll.jl).
The content of the
[P4est_jll_bindings](https://github.com/trixi-framework/P4est_jll_bindings)
repository itself is not immediately relevant for users of p4est in Julia. However,
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
This step is only necessary once. Then, proceed as follows:

1. **Create new bindings**  
   Create a new bindings file, e.g., using the build process of P4est.jl with
   the environment variable `JULIA_P4EST_GENERATE_BINDINGS` set to `yes`.
2. **Create new bindings artifact**  
   To create a new artifact with a given bindings file, run
   [`create_bindings_artifact.jl`](create_bindings_artifact.jl) as follows:
   ```bash
   julia --project create_bindings_artifact.jl path/to/bindings.jl X.Y.Z
   ```
   Here, `X.Y.Z` should be the P4est_jll.jl
   [release version](https://github.com/JuliaBinaryWrappers/P4est_jll.jl/releases)
   *in [semver](https://semver.org) format* for which the bindings have been
   generated, e.g., `2.3.1`. This will create a new artifact archive that can be
   attached as an asset to a new release of this repository, e.g., `P4est.v2.3.1.tar.gz`,
   and return its name to the terminal.
3. **Generate entries for Artifacts.toml**  
   Note the *exact* release name of the P4est_jll.jl release for which the
   bindings have been generated. They can be found on the P4est_jll.jl
   [release page](https://github.com/JuliaBinaryWrappers/P4est_jll.jl/releases).
   For example, for the p4est version `2.3.1`, the corresponding release name
   is `P4est-v2.3.1+0` (including the `+0`).  Run the script
   [`generate_artifacts_toml.jl`](generate_artifacts_toml.jl) as
   ```bash
   julia --project generate_artifacts_toml.jl ARTIFACT_FILE RELASE_NAME
   ```
   where `ARTIFACT_FILE` is the archive you created in the previous step and
   `RELEASE_NAME` is the noted release name. Use the output of the script to
   create a new entry in the
   [Entries for Artifacts.toml](#entries-for-artifactstoml) section below, i.e.,
   edit this `README.md` and commit it to the repository.
4. **Create a new release**  
   [Create a new release](https://github.com/trixi-framework/P4est_jll_bindings/releases/new)
   of the
   [P4est_jll_bindings](https://github.com/trixi-framework/P4est_jll_bindings)
   repository and use the release name from the previous step for both the `Tag
   version` and the `Release title`. At the bottom of the page, attach the newly
   created artifact file, e.g., `P4est.v2.3.1.tar.gz`. Then, publish the
   release.


## Authors
P4est_jll_bindings was initiated by
[Michael Schlottke-Lakemper](https://www.mi.uni-koeln.de/NumSim/schlottke-lakemper)
(University of Cologne, Germany) and
[Hendrik Ranocha](https://ranocha.de) (University of Münster, Germany).


## License
P4est_jll_bindings is licensed under the MIT license (see [LICENSE.md](LICENSE.md)).


## Entries for Artifacts.toml
Please add new release at the top, i.e., the list is sorted by decreasing
version number.

* **P4est-v2.8.0+0-v2**
  ```toml
  [libp4est]
  git-tree-sha1 = "3f5d810564ee7aa8f388d206123c891e97e65c65"
  
      [[libp4est.download]]
      sha256 = "af48410539e41c990300966c22d4012a94d5ac0f05045091687803eaef9d381b"
      url = "https://github.com/trixi-framework/P4est_jll_bindings/releases/download/P4est-v2.8.0+0-v2/P4est.v2.8.0.tar.gz"
  ```

* **P4est-v2.8.0+0**
  ```toml
  [libp4est]
  git-tree-sha1 = "ab08f50b99b6c4060e331e5ece8352645c380dd5"
  
      [[libp4est.download]]
      sha256 = "837eacdd075584af5a5e5f727973b0a216717919ab6e2bdd0200b222c3c3f38d"
      url = "https://github.com/trixi-framework/P4est_jll_bindings/releases/download/P4est-v2.8.0+0/P4est.v2.8.0.tar.gz"
  ```
* **P4est-v2.3.1+0**
  ```toml
  [libp4est]
  git-tree-sha1 = "45086a10bb6c634ab1f35758ecaadcefbbbbaf13"

      [[libp4est.download]]
      sha256 = "0ff5f74c9391a9e32fe517327819ac8917a906925605db0569a5beca7b45bcb8"
      url = "https://github.com/trixi-framework/P4est_jll_bindings/releases/download/P4est-v2.3.1+0/P4est.v2.3.1.tar.gz"
  ```
