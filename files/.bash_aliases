alias ansa='source ~/.ansible/bin/activate'

# remap code-insiders to code if code-insiders is installed
if command -v code-insiders &> /dev/null
then
    alias code=code-insiders
fi

# azure login shorcut
# cca() {
#     az login --tenant 00000000-0000-0000-0000-000000000000 --output none
# }

# clear all credentials
# ccc() {
#     az account clear --output none
#     az logout --output none
#     docker logout all
#     kubelogin remove-tokens
#     kubelogin remove-tokens --token-cache-dir /mnt/c/Users/$USER/.kube/cache/kubelogin
# }

# get all kubenetes credentials
# cck() {
#     ssh k3s.local "sudo cat /etc/rancher/k3s/k3s.yaml" >$HOME/.kube/k3s
#     chmod 600 $HOME/.kube/k3s
#     yq -i '.clusters[].cluster.server |= "https://k3s.local:6443"' $HOME/.kube/k3s
#     yq -i 'del(.clusters[].cluster.certificate-authority-data)' $HOME/.kube/k3s
#     yq -i '.clusters[].cluster.insecure-skip-tls-verify |= true' $HOME/.kube/k3s
#     yq -i '.contexts[].name |= "k3s"' $HOME/.kube/k3s
#     yq -i '.current-context |= "k3s"' $HOME/.kube/k3s

#     az login --tenant 00000000-0000-0000-0000-000000000000 --output none

#     az account set --subscription 00000000-0000-0000-0000-000000000000

#     az aks get-credentials --resource-group rg-aks --name aks --file $HOME/.kube/aks --overwrite-existing
#     kubelogin convert-kubeconfig -l azurecli --kubeconfig $HOME/.kube/aks

#     az account clear --output none
#     az logout --output none
# }

# azure change subscription
# azaks() {
#     az account set --subscription 00000000-0000-0000-0000-000000000000
# }

# kcu() {
#     unset KUBECONFIG
# }

# kck3s() {
#     export KUBECONFIG=$HOME/.kube/k3s
# }

# kcpdc() {
#     export KUBECONFIG=$HOME/.kube/aks
# }
