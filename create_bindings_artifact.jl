using CodecZlib: GzipCompressorStream
using Tar: Tar

const bindings_filename = "libp4est.jl"
const tarball_template = "P4est.vVERSION.tar.gz"

function create_bindings_artifact(command_line_arguments)
  # Iterate over all arguments to check if help is needed
  for arg in command_line_arguments
    if arg in ("-h", "-help", "--help")
      println("Usage: julia --project create_bindings_artifact.jl [-h|--help] BINDINGS_FILE VERSION")
      return
    end
  end

  # Abort if wrong number of arguments are given
  if length(command_line_arguments) != 2
    error("wrong number of command line arguments (use `-h` for more information)")
  end

  # Unpack arguments
  filepath, version_string = command_line_arguments

  # Check if input file exists
  if !isfile(filepath)
    error("bindings file `$filepath` does not exist")
  end

  # Parse version string
  version = VersionNumber(version_string)

  # Verify that it only contains MAJOR.MINOR.PATCH
  if version != VersionNumber(version.major, version.minor, version.patch)
    error("version number should only contain MAJOR.MINOR.PATCH, but found $version")
  end

  # OK, we got here, so everything *seems* to be OK to start creating the artifact archive

  # Determine canonical tarball filename
  tarball = replace(tarball_template, "VERSION" => string(version))

  # Create temporary directory, copy bindings file there, and create tarball
  mktempdir() do tmpdir
    cp(filepath, joinpath(tmpdir, bindings_filename))
    open(tarball, write=true) do tar_gz
      tar = GzipCompressorStream(tar_gz)
      Tar.create(tmpdir, tar)
      close(tar)
    end
  end

  # Print name of created file
  println(tarball)
end

create_bindings_artifact(ARGS)
