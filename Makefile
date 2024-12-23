BUILD_FOLDER=build

resume:
	rendercv render \
		--dont-generate-png \
		--output-folder-name ${BUILD_FOLDER} \
		resume.yaml


archive: resume
	cd ${BUILD_FOLDER} && \
	zip resume.zip *.pdf *.html

clean:
	rm -fvr ${BUILD_FOLDER}
