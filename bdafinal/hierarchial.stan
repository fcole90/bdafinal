


data {
    int<lower=0> N;
    int<lower=0> K;
    int<lower=1,upper=K> x[N]; // group indicator
    vector[N] y;
    int xpred;
}

parameters {
    vector[K] alpha;
    vector[K] beta;
    vector[K] sigma;
    real mu_a;
    real sigma_a;
    real mu_b;
    real sigma_b;
}

transformed parameters {
  vector[N] mu;
  for (i in 1:N)
      mu[i] = alpha[x[i]] + beta[x[i]]*x[i];
}

model {
    alpha ~ normal(mu_a, sigma_a);
    beta ~ normal(mu_b, sigma_b);
    
    for (i in 1:N)
        y[i] ~ normal(mu[i], sigma[x[i]]);
}

generated quantities {
    real ypred[K];
    for (i in 1:K)
        ypred[i] = normal_rng(alpha[i] + beta[i]*xpred, sigma[i]);
}
