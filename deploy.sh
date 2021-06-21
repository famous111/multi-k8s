docker build -t michaelzhu101/multi-client:latest -t michaelzhu101/multi-client:$SHA ./client
docker build -t michaelzhu101/multi-server:latest -t michaelzhu101/multi-server:$SHA ./server
docker build -t michaelzhu101/multi-worker:latest -t michaelzhu101/multi-worker:$SHA ./worker
# Log in to the docker CLI
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin
# Take those images and push them to docker hub
docker push michaelzhu101/multi-client:lastest
docker push michaelzhu101/multi-server:lastest
docker push michaelzhu101/multi-worker:lastest
docker push michaelzhu101/multi-client:$SHA
docker push michaelzhu101/multi-server:$SHA
docker push michaelzhu101/multi-worker:$SHA
#  apply all configs in the k8s folder
kubectl apply -f k8s
kubectl set image deployments/server-deployments server=michaelzhu101/multi-server:$SHA
kubectl set image deployments/client-deployments server=michaelzhu101/multi-client:$SHA
kubectl set image deployments/worker-deployments server=michaelzhu101/multi-worker:$SHA