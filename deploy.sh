docker build -t jbhatta/multi-client -f ./client/Dockerfile ./client
docker build -t jbhatta/multi-server -f ./server/Dockerfile ./server
docker build -t jbhatta/multi-worker -f ./worker/Dockerfile ./worker

docker push jbhatta/multi-client
docker push jbhatta/multi-server
docker push jbhatta/multi-worker

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jbhatta/multi-server