# vcf2eigenstrat

This repo used to contain a simple C++ command-line program for VCF ->
EIGENSTRAT conversion. However, the code was not actively maintained
and, in fact, has never been used in production as I found an easier
solution for doing the conversion. In order to avoid issues with
undiscovered bugs, I have decided to retire the repository. The main
purpose of the program was to test some new features in the latest C++
standard and it served its purpose. If you're interested, the original
code is still available in the git history.

A shell script with a sketch of a simpler alternative using bcftools,
shell utilities and Perl can be found in `conversion.sh`. This is the
solution I've been using for the past couple of years.
