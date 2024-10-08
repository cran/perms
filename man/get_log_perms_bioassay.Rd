% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_logpermanents_bioassay.R
\name{get_log_perms_bioassay}
\alias{get_log_perms_bioassay}
\title{get_log_perms_bioassay}
\usage{
get_log_perms_bioassay(
  X,
  levels,
  successes,
  trials,
  debug = FALSE,
  parallel = TRUE,
  num_cores = NULL
)
}
\arguments{
\item{X}{A matrix of dimension S x n, in which each row contains a sample from
the data model.}

\item{levels}{A vector containing the levels at which trials were conducted.}

\item{successes}{A vector containing the number of successful trials at each level.}

\item{trials}{A vector containing the number of trials at each level.}

\item{debug}{If \code{TRUE}, debug information is printed.}

\item{parallel}{If \code{TRUE}, computation is run on several cores}

\item{num_cores}{(Optional) Specifies the number of cores to use if \code{parallel = TRUE}}
}
\value{
Vector of log permanents, each element associated to the corresponding row in X.
A zero valued permanent is indicated by a NA value.
}
\description{
Computes log permanents associated with simulated latent variables X with bioassay data.
Each row of the matrix X contains a random sample of size n from the data model. 
The observed data are represented as (levels, successes, trials), where levels are the different
 levels at which trials were conducted, successes is the vector of the number of successes per level, 
 and trials is the vector of the total number of trials per level. The function returns a vector of
 log permanents corresponding to each sample. Note that n must be equal to the sum of the entries of trials.
}
\examples{
## Dirichlet toy model
library(perms)
set.seed(1996)
n = 500
num_trials = 10
levels = seq(-1, 1, length.out = num_trials)

trials = rep(n \%/\% num_trials, num_trials)
successes = c(10, 26, 10, 20, 20, 19, 29, 24, 31, 33)

S = 200
alpha = 1.0

get_X = function(S,n,alpha,seed){
  set.seed(seed)
  X = matrix(0, nrow = S, ncol = n)
  for (s in 1:S) {
    X[s,1] = rnorm(1)
    for (i in 2:n) {
      u = runif(1)
      if(u < (alpha/(alpha+i-1))){
        X[s,i] = rnorm(1)
      }else{
        if(i==2){
          X[s,i] = X[s,1]
        }else{
          X[s,i] = sample(X[s, 1:(i-1)],size=1)
        }
      }
      
    }
    
  }
  return(X)
}

seed = 1996
X = get_X(S, n, alpha, seed)
log_perms = get_log_perms_bioassay(X, levels, successes, trials,
           debug=FALSE,parallel = FALSE)
proportion = sum(!is.na(log_perms)) / S*100

proportion 
}
\references{
[1] Christensen, D (2024). Inference for Bayesian nonparametric models with binary response data via permutation counting. Bayesian Analysis, DOI: 10.1214/22-BA1353.
}
