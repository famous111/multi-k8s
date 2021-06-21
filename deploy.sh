docker build -t michaelzhu101/multi-client:latest -t michaelzhu101/multi-client:$SHA ./client
docker build -t michaelzhu101/multi-server:latest -t michaelzhu101/multi-server:$SHA ./server
docker build -t michaelzhu101/multi-worker:latest -t michaelzhu101/multi-worker:$SHA ./worker
# Log in to the docker CLI
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin
# Take those images and push them to docker hub
docker push michaelzhu101/multi-client:latest
docker push michaelzhu101/multi-server:latest
docker push michaelzhu101/multi-worker:latest
docker push michaelzhu101/multi-client:$SHA
docker push michaelzhu101/multi-server:$SHA
docker push michaelzhu101/multi-worker:$SHA
#  apply all configs in the k8s folder
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=michaelzhu101/multi-server:$SHA
kubectl set image deployments/client-deployment server=michaelzhu101/multi-client:$SHA
kubectl set image deployments/worker-deployment server=michaelzhu101/multi-worker:$SHA