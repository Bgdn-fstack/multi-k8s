docker build -t bgd20/multi-client-k8s:latest -t bgd20/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t bgd20/multi-server-k8s:latest -t bgd20/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t bgd20/multi-worker-k8s:latest -t bgd20/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push bgd20/multi-client-k8s:latest
docker push bgd20/multi-server-k8s:latest
docker push bgd20/multi-worker-k8s:latest

docker push bgd20/multi-client-k8s:$SHA
docker push bgd20/multi-server-k8s:$SHA
docker push bgd20/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bgd20/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=bgd20/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=bgd20/multi-worker-k8s:$SHA