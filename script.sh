#!/bin/bash

endpoint=$1
warm_seconds=10
test_seconds=40
sleep_seconds=5

date

for i in 1 2 3
do
	# restart services
	kubectl rollout restart -n spring-petclinic deployment customers-service >> /dev/null
	kubectl rollout restart -n spring-petclinic deployment vets-service >> /dev/null
	kubectl rollout restart -n spring-petclinic deployment visits-service >> /dev/null
	kubectl rollout restart -n spring-petclinic deployment api-gateway >> /dev/null

	# wait
	sleep 5

	# run warmup
	warm_duration=${warm_seconds}s
	test_duration=${test_seconds}s

	wrk -d$warm_duration -t4 -c30 $endpoint >> /dev/null

	for j in 1 2 3 4 5 6 7 8 9 10
	do
		sleep 10
		wrk --latency  -d$test_duration -t4 -c40 $endpoint
	done
done

date
