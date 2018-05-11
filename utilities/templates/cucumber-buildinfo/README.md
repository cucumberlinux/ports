# Cucumber Template (buildscript-buildinfo format)
This is a template for the standard Cucumber Linux buildscript format. Documentation on writing buildinfo files in this format can be found in ports/utiltiies/documentation/cucumber-buildinfo. A tool to aid in generating buildinfo files can be found in ports/utilities/tools/generate-cucumber-buildinfo-template.

This format splits buildscript into to separate files: a .buildscript file and a .buildinfo file. The files server the following two distinct purposes:

## .buildinfo
This is the file you want to edit.

Sets various package specific variables (such as the package name) and contains a function called `build`. The `build` function should run the commands necessary to build the actual package, starting with extracting the source tarball and ending immediately before compressing the package into a *.txz file with makepkg.

Can optionally contain a `verify` function as well (see Checksum/Signature Verification section for details).

## .buildscript
This is the script you want to run, but you do not want to edit this file.

This is effectively a driver for .buildinfo files. It sources the .buildinfo file and uses the variables and functions defined in there to facilitate building the package.

It also allows for different tasks to be done depending on what the first argument to the script is. It supports the following arguments:
* download - Downloads the source tarballs and other source files from the upstream provider.
* verify - Verifies the checksums/signatures of the downloaded source tarballs and files.
* builddeps - Lists the build time dependencies for this package. These are defined in the *.buildinfo file by setting the `pkg_build_dependencies` to an array containing the names of the packages it depends on, as they appear in the Cucumber Linux source/ports tree.
* help -  Displays a help message.
* no argument|build - Builds the package, accepting the same variables that the original buildscript format did.

This file should be the same for every single package. This allows us to make global package changes by editing this one file.

# Checksum/Signature Verification
When running `./iproute2.buildscript verify`, the following actions occur:
1. If the file 'sha512sums' exists, verify those SHA512 checksums
2. If the file 'sha256sums' exists, verify those SHA256 checksums
3. If the file 'sha1sums' exists, verify those SHA1 checksums
4. If the file 'shasums' exists, verify those SHA1 checksums
5. If the file 'md5sums' exists, verify those MD5 checksums
6. Run the 'verify' function in iproute2.buildinfo

If any of these steps fails (i.e. exits with a non-zero status), then the checksum/signature verification step fails. If all of them succeed, the checksum/signature verification step succeeds.

The 'verify' function in *.buildinfo is optional; if it is not present then only steps 1 through 5 will be run. The reason for supporting a custom 'verify' function is to allow for signature verification; the process for verifying signatures varies significantly from one package to the next, so it is necessary for this to be defined on a per package basis.

