% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_logpermanents.R
\name{get_log_perms}
\alias{get_log_perms}
\title{get_log_perms}
\usage{
get_log_perms(X, tt, y, debug = FALSE, parallel = TRUE, num_cores = NULL)
}
\arguments{
\item{X}{A matrix of dimension S x n, in which each row contains a sample from
the data model.}

\item{tt}{Either: A vector of length n containing the observed values of the covariate,
Or: A matrix of dimension S x n (if there are several covariates).}

\item{y}{A vector of length n indicating whether x_i<=t_i for each i in the observed data.}

\item{debug}{If \code{TRUE}, debug information is printed.}

\item{parallel}{If \code{TRUE}, computation is run on several cores}

\item{num_cores}{(Optional) Specifies the number of cores to use if \code{parallel = TRUE}}
}
\value{
Vector of log permanents,each element associated to the corresponding row in X.
A zero valued permanent is indicated by a NA value.
}
\description{
Computes log permanents associated with simulated latent variables.
Each row of the S x n matrix X contains a random sample of size n from the data model. 
If there is only a single covariate, then the
observed data are represented as (t,y), where t is the observed
values of the covariate and y is the vector of indicator variables.
If there are more covariates or the problem is phrased as binary
classification (see Section 5 in [1]), then t is an S x n matrix
since the threshold values change in each iteration. The function returns
a vector of log permanents corresponding to each sample in X.
}
\examples{
library(perms)
set.seed(1996)
n = 100
t = seq(0, 1, length.out=n)
y = c(rep(0, n/2), rep(1, n/2))
S = 200
X = matrix(runif(n*S),nrow = S, ncol = n)

log_perms = get_log_perms(X, t, y, debug = FALSE, parallel = FALSE, num_cores = NULL)

num_nonzero_perms = sum(!is.na(log_perms))
num_nonzero_perms

log_ML = get_log_ML(log_perms, n, FALSE)
log_ML
}
\references{
[1] Christensen, D (2024). Inference for Bayesian nonparametric models with binary response data via permutation counting. Bayesian Analysis, DOI: 10.1214/22-BA1353.
}
