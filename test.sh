#!/bin/bash

bash script.sh http://129.148.43.228/api/gateway/owners/1 > microservices/result1.txt
sleep 60
bash script.sh http://129.148.43.228/api/vet/vets > microservices/result2.txt

kubectl scale -n spring-petclinic deployment vets-service --replicas=3
kubectl scale -n spring-petclinic deployment api-gateway --replicas=3
sleep 60
bash script.sh http://129.148.43.228/api/vet/vets > microservices/result4.txt

kubectl scale -n spring-petclinic deployment vets-service --replicas=1
kubectl scale -n spring-petclinic deployment customers-service --replicas=3
kubectl scale -n spring-petclinic deployment visits-service --replicas=3
sleep 60
bash script.sh http://129.148.43.228/api/gateway/owners/1 > microservices/result3.txt

kubectl scale -n spring-petclinic statefulset customers-db-mysql --replicas=0
kubectl scale -n spring-petclinic statefulset visits-db-mysql --replicas=0
kubectl scale -n spring-petclinic statefulset vets-db-mysql --replicas=0
kubectl scale -n spring-petclinic deployment vets-service --replicas=0
kubectl scale -n spring-petclinic deployment customers-service --replicas=0
kubectl scale -n spring-petclinic deployment visits-service --replicas=0
kubectl scale -n spring-petclinic deployment api-gateway --replicas=0

kubectl scale -n spring-petclinic statefulset monolithic-db-mysql --replicas=1
sleep 60
kubectl scale -n spring-petclinic deployment monolithic-service --replicas=1
sleep 60

bash script-monolith.sh http://144.22.151.62/petclinic/api/owners/1 > monolith/result1.txt
sleep 60
bash script-monolith.sh http://144.22.151.62/petclinic/api/vets > monolith/result2.txt

kubectl scale -n spring-petclinic deployment monolithic-service --replicas=3

sleep 60

bash script-monolith.sh http://144.22.151.62/petclinic/api/owners/1 > monolith/result3.txt
sleep 60
bash script-monolith.sh http://144.22.151.62/petclinic/api/vets > monolith/result4.txt


