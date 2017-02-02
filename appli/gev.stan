data{
  int<lower=0> k;
  int<lower=0> n;
  int<lower=0, upper=1> y[n];
  matrix[n,k] X;
}

parameters{
  real beta0;
  vector[k] beta;
  real eta;
}

transformed parameters  {
//vector[n] auxw;
vector[n] w;
vector[n] prob;

for (i in 1:n) {
//auxw[i] <- 1-(beta0 + X[i]*beta)*eta;
w[i] <- fmax(1-(beta0 + X[i]*beta)*eta,0);
prob[i] <- 1-exp(-pow(w[i],-1/eta));
}
}

model {
  beta0 ~ normal(0.0,100);
  beta ~ normal(0.0,100);
  eta ~ uniform(-1,1);
  y ~ bernoulli(prob);
}

//generated quantities {
//  vector[n] log_lik;
//  for (i in 1:n) {
//    log_lik[i] <- bernoulli_log(y[i] , prob[i]);
//  }
//}