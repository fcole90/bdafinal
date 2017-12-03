data {
    int<lower=0> N;
    vector[N] x; // group indicator
    vector[N] y;
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
    y ~ normal(mu, sigma);
}

generated quantities {
    real ypred;
    ypred = normal_rng(alpha + beta*xpred, sigma);
}