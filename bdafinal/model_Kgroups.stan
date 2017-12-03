data {
    int<lower=0> N;
    int<lower=0> K;
    int<lower=1,upper=K> x[N]; // group indicator
    vector[N] y;
    real xpred;
}
parameters {
    real alpha[K];
    real beta[K];
    real<lower=0> sigma[N];
}

transformed parameters {
  vector[N] mu;
  for (i in 1:N)
      mu[i] = alpha[x[i]] + beta[x[i]]*x[i];
}

model {
    y ~ normal(mu, sigma);
}

generated quantities {
    real ypred[K];
    for (i in 1:K)
        ypred[i] = normal_rng(alpha[i] + beta[i]*xpred, sigma[i]);
}