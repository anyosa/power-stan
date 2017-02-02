data{
  int<lower=0> k;
  int<lower=0> n;
  int<lower=0, upper=1> y[n];
  matrix[n,k] X;
}

parameters{
  real beta0;
  vector[k] beta;
}

transformed parameters  {
  vector[n] prob;
  for (i in 1:n) {
  prob[i] <- 1-exp(-exp(beta0 + X[i]*beta));
  }
}

model {
  beta0 ~ normal(0.0,100);
  beta ~ normal(0.0,100);
  y ~ bernoulli(prob);
}

generated quantities {
  vector[n] log_lik;
  for (i in 1:n) {
    log_lik[i] <- bernoulli_log(y[i] , prob[i]);
  }
}