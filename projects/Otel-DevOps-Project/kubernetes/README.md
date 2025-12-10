by default we may not be able to see the kubernetes running nodes.
we need to set the cluster config

kubectl config view
kubectl config current-context

aws eks update-kubeconfig --region <aws-region-here> --name <cluster-nam>

this will add the created kubernetes cluster context.