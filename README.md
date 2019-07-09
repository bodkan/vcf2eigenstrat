# vcf2eigenstrat
Simple C++ command-line program for VCF -> EIGENSTRAT conversion.

## Installation

### macOS

The program depends on boost libraries. Assuming you use [homebrew](https://brew.sh)
for installing unix programs that are not available for macOS by default, you can simply
run `brew install boost`.

Fetch the sources from Github:

```
git clone https://github.com/bodkan/vcf2eigenstrat
cd vcf2eigenstrat
```

Run the compilation:

```
make
```

This will create a binary `vcf2eigenstrat` in a `bin/` subdirectory and run a small test suite.

### Other Unix systems

Same procedure as described for macOS above, but installing boost will differ depending
on your system.

### Usage

```
$ ./bin/vcf2eigenstrat 
Usage:
	./vcf_to_eigenstrat <path to VCF> <output EIGENSTRAT prefix>
```
