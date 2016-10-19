# SConES


(**S**electing **Con**nected **E**xplanatory **S**NPs)

## Summary


MATLAB code implementing the method described in:  
> C.-A. Azencott, D. Grimm, M. Sugiyama, Y. Kawahara and K. Borgwardt (2013) 
> **Efficient network-guided multi-locus association mapping with graph cuts**,  _Bioinformatics_ 29 (13), i171-i179  [doi:10.1093/bioinformatics/btt238](http://bioinformatics.oxfordjournals.org/content/29/13/i171)

### Related work and repositories

* **EasyGWAS**: SConES has been integrated to [EasyGWAS](https://github.com/dominikgrimm/easyGWASCore), a framework for the analysis and meta-analysis of GWAS data. In particular, this offers a Python interface. 

* **sfan**: Regarding the feature selection part (i.e. after the GWAS data has been processed and the SNP scored), [sfan](https://github.com/chagaz/sfan) uses a different (faster) maxflow solver, is written in Python, and also incorporates the multi-task version proposed in 
> M. Sugiyama, C.-A. Azencott, D. Grimm, Y. Kawahara and K. Borgwardt (2014)
> **Multi-task feature selection on multiple networks via maximum flows**, _SIAM ICDM_, 199-207 [doi:10.1137/1.9781611973440.23](http://epubs.siam.org/doi/abs/10.1137/1.9781611973440.23)

* **MultiSConeS**: For the original version of this multi-task version, see [Multi-SConES](https://github.com/mahito-sugiyama/Multi-SConES).


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


<<<<<<< HEAD
## SConES:


=======
## Running SConES for given values of the lambda and eta parameters
`[indicators, objectives] = scones(data, option)`

### Input:
>>>>>>> a957a00a7dfd4d289aeb55fba4d65e96b145adba
To run SConES two parameters are needed. The first one is a data cell array:

* `data.X` is the genotype data 
* `data.Y` is the phenotype  
* `data.W` is the sparse network  
<<<<<<< HEAD
* `data.selected_PCs` is the number of principle components that should be used for population structure correction  
* `data.lambda_values` is a vector of size `1 x k` with `k` values for `lambda`  
* `data.eta_values` is a vector of size `1 x h` with `h` values for `eta`  


=======
* `data.selected_PCs` is the number of principal components that should be used for population structure correction  
* `data.lambda_values` is a vector of size `1 x k` with `k` values for `lambda`  
* `data.eta_values` is a vector of size `1 x h` with `h` values for `eta`  

>>>>>>> a957a00a7dfd4d289aeb55fba4d65e96b145adba
The second parameter is a options cell array (optional - default values are specified):

* `options.automatic` : if this parameter is true `data.lambda_values` and `data.eta_values` are determined automatically (default: `true`)  
* `options.number_parameters` : this parameters specifices the number of eta and lambda values in the case `options.automatic` is set to true (default: `10`)  
* `options.stdout` : if this parameter is true output is printed into the terminal window (default: `true`)  
<<<<<<< HEAD
* `options.nfold` : if `scones_crossvalidation` is called this parameter specifices the number of folds (default: `10`)  
* `options.seed` : if `scones_crossvalidation` is called this parameter specifies a seed for splitting the data (default: 0)  
=======
>>>>>>> a957a00a7dfd4d289aeb55fba4d65e96b145adba

### Output: 

* indicators = indicator matrix of size `n x k x h`, where `n` is the length of vector `c`, `k` the length of vector `lambda_values` and `h` the length of vector `eta_values`
* objectives = matrix with all objective values with size `k x h` for the grid of `lambda x eta` values

<<<<<<< HEAD

=======
## Using an inner cross-validation to determine the best values of the lambda and eta parameters
`[indicators, objectives] = scones_crossvalidation(data, option)`

### Input:
The first parameter (`data`) is the same as described above.

The second parameter (`options`) can additionally take the following values:
* `options.nfold` : if `scones_crossvalidation` is called this parameter specifices the number of folds (default: `10`)  
* `options.seed` : if `scones_crossvalidation` is called this parameter specifies a seed for splitting the data (default: 0)  
>>>>>>> a957a00a7dfd4d289aeb55fba4d65e96b145adba

## Contact 

Any questions can be directed to Chloe-Agathe Azencott: chloe-agathe.azencott [at] mines-paristech.fr

