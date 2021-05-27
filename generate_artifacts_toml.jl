using Inflate: inflate_gzip
using Pkg.Artifacts: bind_artifact!
using SHA: sha1, sha256
using Tar: Tar

const artifact_name = "libp4est"
const base_url = "https://github.com/trixi-framework/P4est_jll_bindings/releases/download"

function generate_artifacts_toml(command_line_arguments)
  # Iterate over all arguments to check if help is needed
  for arg in command_line_arguments
    if arg in ("-h", "-help", "--help")
      println("Usage: julia --project generate_artifacts_toml.jl [-h|--help] ARTIFACT_FILE RELASE_NAME")
      return
    end
  end

  # Abort if wrong number of arguments are given
  if length(command_line_arguments) != 2
    error("wrong number of command line arguments (use `-h` for more information)")
  end

  # Unpack arguments
  filepath, release_name = command_line_arguments

  # Check if input file exists
  if !isfile(filepath)
    error("artifact file `$filepath` does not exist")
  end

  # Calculate tree hash
  tree_hash_string = Tar.tree_hash(IOBuffer(inflate_gzip(filepath)))
  tree_hash = Base.SHA1(hex2bytes(tree_hash_string))

  # Build url
  tarball = basename(filepath)
  url = base_url * "/" * release_name * "/" * tarball

  # Calculate sha256 hash of the artifact file
  file_hash = bytes2hex(open(sha256, filepath))

  # Generate Artifact.toml string
  artifact_toml = mktempdir() do tmpdir
    tmpfile = joinpath(tmpdir, "Artifacts.toml")
    bind_artifact!(tmpfile, artifact_name, tree_hash; download_info=[(url, file_hash)])
    lines = []
    for line in eachline(tmpfile, keep=true)
      push!(lines, "  " * line)
    end
    
    join(lines)
  end

  print("""
        * **$release_name**
          ```toml
        $artifact_toml  ```
        """)
end

generate_artifacts_toml(ARGS)
