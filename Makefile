BUILD_FOLDER=build
FTP_HOST=
FTP_USER=
FTP_PASSWORD=
CHANGELOG_VERSION=`date +%F_%H%M`

resume: resume-en resume-fr

resume-en:
	pipx run rendercv render \
		--dont-generate-png \
		--output-folder-name ${BUILD_FOLDER} \
		--pdf-path ${BUILD_FOLDER}/kevin_kin-foo_en.pdf \
		--markdown-path ${BUILD_FOLDER}/kevin_kin-foo_en.md \
		--html-path ${BUILD_FOLDER}/kevin_kin-foo_en.html \
		en.yaml

resume-fr:
	pipx run rendercv render \
		--dont-generate-png \
		--output-folder-name ${BUILD_FOLDER} \
		--pdf-path ${BUILD_FOLDER}/kevin_kin-foo_fr.pdf \
		--markdown-path ${BUILD_FOLDER}/kevin_kin-foo_fr.md \
		--html-path ${BUILD_FOLDER}/kevin_kin-foo_fr.html \
		fr.yaml

release: resume
	npx conventional-changelog-cli -p eslint -i CHANGELOG.md -s -r 0

	git ci CHANGELOG.md -m "ci: release ${CHANGELOG_VERSION}"

	git tag v${CHANGELOG_VERSION}

	git push --tags origin main

	gh release create v${CHANGELOG_VERSION} \
		--title "v${CHANGELOG_VERSION}" \
		--generate-notes \
		--latest \
		build/*.pdf \
		build/*.html

deploy: resume
	curl --user ${FTP_USER}:${FTP_PASSWORD} \
		--ssl-reqd \
		--upload-file build/kevin_kin-foo_* \
		ftp://${FTP_HOST}/data/

clean:
	rm -fvr ${BUILD_FOLDER}
