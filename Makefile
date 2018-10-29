dir := bin tmp

binary := bin/vcf2eigenstrat
source := src/vcf2eigenstrat.cpp

.PHONY: all tests

all: $(dir) $(binary) tests

$(binary): $(dir) $(source)
	g++ -std=c++14 -Wall -I /usr/include/boost -L /usr/lib/x86_64-linux-gnu $(source) -lboost_iostreams -o $@

tests:
	@./$(binary) tests/test_vcf.vcf tmp/test_eigenstrat 
	@for suffix in ind snp geno; do \
	    res=`diff tests/expected.$${suffix} tmp/test_eigenstrat.$${suffix}`; \
	    if [ "$$res" != "" ]; then \
		    echo "Test of tmp/test_eigenstrat.$${suffix} failed"; \
			exit -1; \
	    fi \
    done; \
	echo "All tests passed."

clean:
	rm -rf $(dir)

$(dir):
	mkdir -p $@
