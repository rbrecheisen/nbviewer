if [ "${1}" == "--build" ]; then
	docker build -t brecheisen/nbviewer .
elif [ "${1}" == "--stop" ]; then
	docker stop nbviewer; docker rm nbviewer
elif [ "${1}" == "--shell" ]; then
	docker exec -it nbviewer bash
else

	./run.sh --stop

	docker run -d --name nbviewer \
		-p 80:8080 \
		-v $(pwd)/nbviewer/notebooks:/srv/nbviewer/notebooks \
		brecheisen/nbviewer

	# Your own notebooks are mounted in the container folder /srv/nbviewer/notebooks and
	# you can access them at http://localhost/localfile/<file>.ipynb

	open http://localhost/localfile
fi
