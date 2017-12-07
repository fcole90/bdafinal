data {
    int<lower=0> N;
    vector[N] x; // group indicator
    vector[N] y;
    real ymean;
    real xpred;
}
parameters {
    real alpha;
    real beta;
    real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu;
  mu = alpha + beta*x;
}

model {
    alpha ~ normal(ymean, 100);
    beta ~ normal(0, 1);
    y ~ normal(mu, sigma);
}

generated quantities {
    real ypred;
    vector[N] log_lik;
    ypred = normal_rng(alpha + beta*xpred, sigma);
    for (i in 1:N)
        log_lik[i] = normal_lpdf(y[i] | mu[i], sigma);
}