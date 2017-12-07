data {
  int<lower=0> N; // number of data points
  int<lower=0> K; // number of groups
  int<lower=1,upper=K> x[N]; // group indicator
  vector[N] y; //
  int xpred;
}
parameters {
  vector[K] alpha;        // group means
  real mu_alpha;
  real sigma_alpha;
  
  vector[K] beta;        // group means
  real mu_beta;
  real sigma_beta;
  
  real<lower=0> sigma[K]; 
  real nu_0;
  real sigma_0;
}

transformed parameters {
    vector[N] mu;
    for (i in 1:N)
        mu[i] = alpha[x[i]] + beta[x[i]]*x[i];
}

model {
    sigma_alpha ~ cauchy(0, 1);
    sigma_beta ~ cauchy(0, 10);
    sigma_0 ~ cauchy(0, 1);
    nu_0 ~ gamma(2, 0.1);
    mu_alpha ~ normal(0,10);
    mu_beta ~ normal(0,10);
    
    alpha ~ normal(mu_alpha, sigma_alpha);
    beta ~ normal(mu_beta, sigma_beta);
    sigma ~ scaled_inv_chi_square(sigma_0, nu_0);
    
    y ~ normal(mu, sigma[x]);
}

generated quantities{
    real ypred[K];
    vector[N] log_lik;
    
    for (i in 1:K)
    {
        ypred[i] = normal_rng(alpha[i] + beta[i]*xpred, sigma[i]);
    }
    
    for (i in 1:N)
    {
        log_lik[i] = normal_lpdf(y[i] | mu[i], sigma[x[i]]);
    }
}