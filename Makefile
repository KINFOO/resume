BUILD_FOLDER=build
FTP_HOST=
FTP_USER=
FTP_PASSWORD=
CHANGELOG_VERSION=`date +%F_%H%M`

resume:
	pipx run rendercv render \
		--dont-generate-png \
		--output-folder-name ${BUILD_FOLDER} \
		resume.yaml

release: resume
	npx conventional-changelog-cli -p eslint -i CHANGELOG.md -s -r 0

	git ci CHANGELOG.md -m "ci: release ${CHANGELOG_VERSION}"

	git tag v${CHANGELOG_VERSION}

	git push --tags origin main

	gh release create v${CHANGELOG_VERSION} \
		--title "v${CHANGELOG_VERSION}" \
		build/*.pdf \
		build/*.html

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
