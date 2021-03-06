import os
import sipconfig

# The name of the SIP build file generated by SIP and used by the build
# system.
build_file = "word.sbf"

# Get the SIP configuration information.
config = sipconfig.Configuration()

# Create the Makefile.
makefile = sipconfig.SIPModuleMakefile(config, build_file)

# Generate the Makefile itself.
makefile.generate()
