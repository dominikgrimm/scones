# SConES


(**S**electing **Con**nected **E**xplanatory **S**NPs)

## Summary


MATLAB code implementing the method described in:  
* C.-A. Azencott, D. Grimm, M. Sugiyama, Y. Kawahara and K. Borgwardt (2013)
**Efficient network-guided multi-locus association mapping with graph cuts**,
 _Bioinformatics_ 29 (13), i171-i179  [link](http://bioinformatics.oxfordjournals.org/content/29/13/i171)



## Demo:

In the `code` folder, there is a MATLAB script `demo.m`.  

To run the demo start MATLAB and type in:   

```
demo()
```


## Data:

* `X` = Genotypematrix of size `n x s`, where `n` is the number of samples and `s` is the number of SNPs  
* `Y` = Phenotypevector of size `n x 1`, where `n` is the number of samples  
* `W` = sparse network with size `s x s`  


Demo files are provided in the `data` folder.


## SConES:


To run SConES two parameters are needed. The first one is a data cell array:

* `data.X` is the genotype data 
* `data.Y` is the phenotype  
* `data.W` is the sparse network  
* `data.selected_PCs` is the number of principle components that should be used for population structure correction  
* `data.lambda_values` is a vector of size `1 x k` with `k` values for `lambda`  
* `data.eta_values` is a vector of size `1 x h` with `h` values for `eta`  


The second parameter is a options cell array (optional - default values are specified):

* `options.automatic` : if this parameter is true `data.lambda_values` and `data.eta_values` are determined automatically (default: `true`)  
* `options.number_parameters` : this parameters specifices the number of eta and lambda values in the case `options.automatic` is set to true (default: `10`)  
* `options.stdout` : if this parameter is true output is printed into the terminal window (default: `true`)  
* `options.nfold` : if `scones_crossvalidation` is called this parameter specifices the number of folds (default: `10`)  
* `options.seed` : if `scones_crossvalidation` is called this parameter specifies a seed for splitting the data (default: 0)  

### Output: 

* indicators = indicator matrix of size `n x k x h`, where `n` is the length of vector `c`, `k` the length of vector `lambda_values` and `h` the length of vector `eta_values`
* objectives = matrix with all objective values with size `k x h` for the grid of `lambda x eta` values



## Contact 

Any questions can be directed to Chloe-Agathe Azencott: chloe-agathe.azencott@mines-paristech.fr

