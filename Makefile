BUILD_FOLDER=build
FTP_HOST=
FTP_USER=
FTP_PASSWORD=

resume:
	rendercv render \
		--dont-generate-png \
		--output-folder-name ${BUILD_FOLDER} \
		resume.yaml


archive: resume
	cd ${BUILD_FOLDER} && \
	zip resumes.zip *.pdf *.html

deploy: resume
	curl --user ${FTP_USER}:${FTP_PASSWORD} \
		--ssl-reqd \
		--upload-file build/*.html \
		ftp://${FTP_HOST}/data/cv.html

	curl --user ${FTP_USER}:${FTP_PASSWORD} \
		--ssl-reqd \
		--upload-file build/*.pdf \
		ftp://${FTP_HOST}/data/cv.pdf

clean:
	rm -fvr ${BUILD_FOLDER}
