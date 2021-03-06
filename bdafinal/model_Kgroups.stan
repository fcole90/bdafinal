model_code = '''
data {
    int<lower=0> N;
    int<lower=0> K;
    int<lower=1,upper=K> x[N]; // group indicator
    vector[N] y;
    real xpred;
}

parameters {
    vector[K] alpha;
    vector[K] beta;
    vector[K] sigma;
}

transformed parameters {
  vector mu[N];
  for (i in 1:N)
      mu[i] = alpha[x[i]] + beta[x[i]]*x[i];
}

model {
    for (i in 1:N)
        y[i] ~ normal(mu[i], sigma[x[i]]);
}

generated quantities {
    real ypred[K];
    for (i in 1:K)
        ypred[i] = normal_rng(alpha[i] + beta[i]*xpred, sigma[i]);
}
'''

sm_sep = stan_utility.compile_model_plus(model_code)

K=1
nj = 10
N = nj*K
x = np.array([i for i in range(1,K+1) for j in range(10)])
print(x)
y = np.log(data[0:K]).ravel()  # observations
xpred=K+1

model_data = dict(
    N = N,
    K = K,  # 25 contries
    x = x,  # group indicators
    y = y,  # observations
    xpred=xpred
)

samplesk = sm_sep.sampling(n_jobs=4, data=model_data)

print('Completed ', samplesk)
