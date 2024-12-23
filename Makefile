resume:
	rendercv render \
		--dont-generate-markdown \
		--dont-generate-png \
		resume.yaml

clean:
	rm -fvr rendercv_output
