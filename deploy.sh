docker build -t vonghard/multi_client:latest -t vonghard/multi_client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t vonghard/multi_server:latest -t vonghard/multi_server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t vonghard/multi_worker:latest -t vonghard/multi_worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push vonghard/multi_client:latest
docker push vonghard/multi_server:latest
docker push vonghard/multi_worker:latest

docker push vonghard/multi_client:$GIT_SHA
docker push vonghard/multi_server:$GIT_SHA
docker push vonghard/multi_worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=vonghard/multi_server:$GIT_SHA
kubectl set image deployments/client-deployment client=vonghard/multi_client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=vonghard/multi_worker:$GIT_SHA
