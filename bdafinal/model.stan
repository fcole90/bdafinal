data {
    int<lower=0> N; // number of data points
    int<lower=0> K; // number of groups
    int<lower=1,upper=K> x[N]; // group indicator
    vector[N] y; //
    int xpred; // input location for prediction of new measurement on 6th machine
}
parameters {
    vector[K] theta;             // group means
    vector<lower=0>[K] sigma; // group stds
}
model {
    y ~ binom(N, theta[x]);
}
generated quantities {
    vector[K] ypred;
    for (i in 1:K) 
        ypred[i] = binom_rng(N, theta[i]);
}




// Gaussian linear model with adjustable priors
data {
  int<lower=0> N; // number of data points
  vector[N] x; //
  vector[N] y; //
  real xpred; // input location for prediction
}
parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}
transformed parameters {
  vector[N] theta;
  theta = alpha + beta * x;
}
model {
  y ~ normal(theta, sigma);
}
generated quantities {
  real ypred;
  vector[N] log_lik;
  ypred = normal_rng(alpha + beta * xpred, sigma);
  for (i in 1:N)
    log_lik[i] = normal_lpdf(y[i] | theta[i], sigma);
}




data {
    int<lower=0> N; // number of data points
    int<lower=0> K; // number of groups
    int<lower=1,upper=K> x[N]; // group indicator
    vector[N] y; //
    int xpred; // input location for prediction of new measurement on 6th machine
}
parameters {
    vector[K] theta;             // group means
    vector<lower=0>[K] sigma; // group stds
}
model {
    y ~ normal(theta[x], sigma[x]);
}
generated quantities {
    real ypred;
    ypred = normal_rng(theta[xpred], sigma[xpred]);
}