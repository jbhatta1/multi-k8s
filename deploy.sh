docker build -t jbhatta/multi-client:latest -t jbhatta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jbhatta/multi-server:latest -t jbhatta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jbhatta/multi-worker:latest -t jbhatta/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jbhatta/multi-client:latest
docker push jbhatta/multi-server:latest
docker push jbhatta/multi-worker:latest

docker push jbhatta/multi-client:$SHA
docker push jbhatta/multi-server:$SHA
docker push jbhatta/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jbhatta/multi-server:$SHA
kubectl set image deployments/client-deployment client=jbhatta/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jbhatta/multi-worker:$SHA