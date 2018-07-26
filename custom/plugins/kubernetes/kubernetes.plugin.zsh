# Aliases
alias k="kubectl"
alias kde="eval $(minikube docker-env)"
alias kpush="kubectl config use-context"
alias kpop="kubectl config use-context minikube"

# Functions
inspect_volume()
{
	VOLUME=$1
	kubectl run -it busybox --image=busybox --restart=Never --rm --overrides='
{
  "kind": "Pod",
  "apiVersion": "v1",
  "metadata": {
    "name": "inspector-'$RANDOM'"
  },
  "spec": {
    "volumes": [
      {
        "name": "'$VOLUME'",
        "persistentVolumeClaim": {
          "claimName": "'$VOLUME'"
        }
      }
    ],
    "containers": [
      {
        "name": "inspector-container",
        "image": "busybox",
        "volumeMounts": [
          {
            "mountPath": "/data",
            "name": "'$VOLUME'"
          }
        ],
		"tty": true,
		"stdin": true
      }
    ]
  }
}'
}
